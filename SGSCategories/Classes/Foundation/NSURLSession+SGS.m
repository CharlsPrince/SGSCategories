/*!
 *  @header NSURLSession+SGS.m
 *
 *  @author Created by Lee on 16/9/19.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSURLSession+SGS.h"
#import <objc/runtime.h>

static const int kLockKey;
static const int kProgressObserversKey;

#pragma mark - Session Task Progress Observer

typedef NS_ENUM(NSInteger, kSessionTaskProgressType) {
    kSessionTaskProgressTypeDownload,
    kSessionTaskProgressTypeUpload,
};

@interface p_SessionTaskProgressObserver : NSObject
@property (nonatomic, copy) void (^uploadProgressBlock)(NSProgress *progress);
@property (nonatomic, copy) void (^downloadProgressBlock)(NSProgress *progress);
@end

@implementation p_SessionTaskProgressObserver {
    NSProgress *_uploadProgress;
    NSProgress *_downloadProgress;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _downloadProgress = [[NSProgress alloc] initWithParent:nil userInfo:nil];
        _downloadProgress.totalUnitCount = NSURLSessionTransferSizeUnknown;
        
        _uploadProgress = [[NSProgress alloc] initWithParent:nil userInfo:nil];
        _uploadProgress.totalUnitCount = NSURLSessionTransferSizeUnknown;
    }
    return self;
}

- (void)p_setupProgressForTask:(NSURLSessionTask *)task {
    _downloadProgress.totalUnitCount = task.countOfBytesExpectedToReceive;
    _uploadProgress.totalUnitCount   = task.countOfBytesExpectedToSend;
    
    __weak __typeof__(task) weakTask = task;
    
    [_downloadProgress setCancellable:YES];
    [_downloadProgress setCancellationHandler:^{
        __typeof__(weakTask) strongTask = weakTask;
        [strongTask cancel];
    }];
    [_downloadProgress setPausable:YES];
    [_downloadProgress setPausingHandler:^{
        __typeof__(weakTask) strongTask = weakTask;
        [strongTask suspend];
    }];
    if ([_downloadProgress respondsToSelector:@selector(setResumingHandler:)]) {
        [_downloadProgress setResumingHandler:^{
            __typeof__(weakTask) strongTask = weakTask;
            [strongTask resume];
        }];
    }
    
    [_uploadProgress setCancellable:YES];
    [_uploadProgress setCancellationHandler:^{
        __typeof__(weakTask) strongTask = weakTask;
        [strongTask cancel];
    }];
    [_uploadProgress setPausable:YES];
    [_uploadProgress setPausingHandler:^{
        __typeof__(weakTask) strongTask = weakTask;
        [strongTask suspend];
    }];
    if ([_uploadProgress respondsToSelector:@selector(setResumingHandler:)]) {
        [_uploadProgress setResumingHandler:^{
            __typeof__(weakTask) strongTask = weakTask;
            [strongTask resume];
        }];
    }
    
    
    [task addObserver:self
           forKeyPath:NSStringFromSelector(@selector(countOfBytesReceived))
              options:NSKeyValueObservingOptionNew
              context:NULL];
    [task addObserver:self
           forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToReceive))
              options:NSKeyValueObservingOptionNew
              context:NULL];
    
    [task addObserver:self
           forKeyPath:NSStringFromSelector(@selector(countOfBytesSent))
              options:NSKeyValueObservingOptionNew
              context:NULL];
    [task addObserver:self
           forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToSend))
              options:NSKeyValueObservingOptionNew
              context:NULL];
    
    [_downloadProgress addObserver:self
                        forKeyPath:NSStringFromSelector(@selector(fractionCompleted))
                           options:NSKeyValueObservingOptionNew
                           context:NULL];
    [_uploadProgress addObserver:self
                      forKeyPath:NSStringFromSelector(@selector(fractionCompleted))
                         options:NSKeyValueObservingOptionNew
                         context:NULL];
}

- (void)p_cleanUpProgressForTask:(NSURLSessionTask *)task {
    [task removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesReceived))];
    [task removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToReceive))];
    [task removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesSent))];
    [task removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesExpectedToSend))];
    [_downloadProgress removeObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted))];
    [_uploadProgress removeObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted))];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([object isKindOfClass:[NSURLSessionTask class]]) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesReceived))]) {
            _downloadProgress.completedUnitCount = [change[NSKeyValueChangeNewKey] longLongValue];
        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesExpectedToReceive))]) {
            _downloadProgress.totalUnitCount = [change[NSKeyValueChangeNewKey] longLongValue];
        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesSent))]) {
            _uploadProgress.completedUnitCount = [change[NSKeyValueChangeNewKey] longLongValue];
        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesExpectedToSend))]) {
            _uploadProgress.totalUnitCount = [change[NSKeyValueChangeNewKey] longLongValue];
        }
    } else if ([object isEqual:_downloadProgress]) {
        if (self.downloadProgressBlock) {
            self.downloadProgressBlock(object);
        }
    } else if ([object isEqual:_uploadProgress]) {
        if (self.uploadProgressBlock) {
            self.uploadProgressBlock(object);
        }
    }
}

@end


#pragma mark - NSURLSession (SGS)

@implementation NSURLSession (SGS)

#pragma mark - Response Filter

+ (SGSResponseFilterBlock)responseStringFilter {
    return ^NSString *(NSURLResponse *response, NSData *data) {
        if ((data == nil) || (data.length == 0)) return nil;

        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    };
}

+ (SGSResponseFilterBlock)responseJSONFilter {
    return ^id(NSURLResponse *response, NSData *data) {
        if ((data == nil) || (data.length == 0)) return nil;
        
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error != nil) return error;
        
        return json;
    };
}

#pragma mark - Data Task

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                               responseFilter:(SGSResponseFilterBlock)filter
                                      success:(SGSResponseSuccessBlock)success
                                      failure:(SGSResponseFailureBlock)failure
{
    return [self dataTaskWithRequest:request downloadProgress:nil uploadProgress:nil responseFilter:filter success:success failure:failure];
}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
                           responseFilter:(SGSResponseFilterBlock)filter
                                  success:(SGSResponseSuccessBlock)success
                                  failure:(SGSResponseFailureBlock)failure
{
    return [self dataTaskWithURL:url downloadProgress:nil uploadProgress:nil responseFilter:filter success:success failure:failure];
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                             downloadProgress:(SGSProgressBlock)downloadProgressBlock
                               uploadProgress:(SGSProgressBlock)uploadProgressBlock
                               responseFilter:(SGSResponseFilterBlock)filter
                                      success:(SGSResponseSuccessBlock)success
                                      failure:(SGSResponseFailureBlock)failure
{
    __weak typeof(&*self) weakSelf = self;
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [weakSelf p_callBackObjectWithFilter:filter success:success failure:failure response:response data:data error:error];
    }];
    
    [self p_addDownloadProgressBlock:downloadProgressBlock uploadProgressBlock:uploadProgressBlock forTask:task];
    
    return task;
}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
                         downloadProgress:(SGSProgressBlock)downloadProgressBlock
                           uploadProgress:(SGSProgressBlock)uploadProgressBlock
                           responseFilter:(SGSResponseFilterBlock)filter
                                  success:(SGSResponseSuccessBlock)success
                                  failure:(SGSResponseFailureBlock)failure
{
    __weak typeof(&*self) weakSelf = self;
    
    NSURLSessionDataTask *task = [self dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [weakSelf p_callBackObjectWithFilter:filter success:success failure:failure response:response data:data error:error];
    }];
    
    [self p_addDownloadProgressBlock:downloadProgressBlock uploadProgressBlock:uploadProgressBlock forTask:task];
    
    return task;
}


#pragma mark - Upload Task

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromFile:(NSURL *)fileURL
                                         progress:(SGSProgressBlock)progressBlock
                                   responseFilter:(SGSResponseFilterBlock)filter
                                          success:(SGSResponseSuccessBlock)success
                                          failure:(SGSResponseFailureBlock)failure
{
    __weak typeof(&*self) weakSelf = self;
    
    NSURLSessionUploadTask *task = [self uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [weakSelf p_callBackObjectWithFilter:filter success:success failure:failure response:response data:data error:error];
    }];
    
    [self p_addDownloadProgressBlock:nil uploadProgressBlock:progressBlock forTask:task];
    
    return task;
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromData:(NSData *)bodyData
                                         progress:(SGSProgressBlock)progressBlock
                                   responseFilter:(SGSResponseFilterBlock)filter
                                          success:(SGSResponseSuccessBlock)success
                                          failure:(SGSResponseFailureBlock)failure
{
    __weak typeof(&*self) weakSelf = self;
    
    NSURLSessionUploadTask *task = [self uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [weakSelf p_callBackObjectWithFilter:filter success:success failure:failure response:response data:data error:error];
    }];
    
    [self p_addDownloadProgressBlock:nil uploadProgressBlock:progressBlock forTask:task];
    
    return task;
}


#pragma mark - Download Task

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(SGSProgressBlock)progressBlock
                                          destination:(SGSDownloadTargetBlock)destination
                                              success:(SGSDownloadSuccessBlock)success
                                              failure:(SGSResponseFailureBlock)failure
{
    __weak typeof(&*self) weakSelf = self;
    
    NSURLSessionDownloadTask *task = [self downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [weakSelf p_callBackFileWithDestination:destination success:success failure:failure response:response location:location error:error];
    }];
    
    [self p_addDownloadProgressBlock:progressBlock uploadProgressBlock:nil forTask:task];
    
    return task;
}

- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url
                                         progress:(SGSProgressBlock)progressBlock
                                      destination:(SGSDownloadTargetBlock)destination
                                          success:(SGSDownloadSuccessBlock)success
                                          failure:(SGSResponseFailureBlock)failure
{
    __weak typeof(&*self) weakSelf = self;
    
    NSURLSessionDownloadTask *task = [self downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [weakSelf p_callBackFileWithDestination:destination success:success failure:failure response:response location:location error:error];
    }];
    
    [self p_addDownloadProgressBlock:progressBlock uploadProgressBlock:nil forTask:task];
    
    return task;
}

- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData
                                                progress:(SGSProgressBlock)progressBlock
                                             destination:(SGSDownloadTargetBlock)destination
                                                 success:(SGSDownloadSuccessBlock)success
                                                 failure:(SGSResponseFailureBlock)failure
{
    __weak typeof(&*self) weakSelf = self;
    
    NSURLSessionDownloadTask *task = [self downloadTaskWithResumeData:resumeData completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [weakSelf p_callBackFileWithDestination:destination success:success failure:failure response:response location:location error:error];
    }];
    
    [self p_addDownloadProgressBlock:progressBlock uploadProgressBlock:nil forTask:task];
    
    return task;
}


#pragma mark - Completion

- (void)p_callBackObjectWithFilter:(id (^)(NSURLResponse *, NSData *))filter
                           success:(void (^)(id, id))success
                          failure:(void (^)(id, id))failure
                         response:(NSURLResponse *)response
                             data:(NSData *)data
                            error:(NSError *)error
{
    if (error) {
        [self p_invokeBlock:failure response:response obj:error];
        return ;
    }
    
    id responseObject = data;
    
    if (filter != nil) {
        responseObject = filter(response, data);
    }
    
    if ([responseObject isKindOfClass:[NSError class]]) {
        [self p_invokeBlock:failure response:response obj:responseObject];
    } else {
        [self p_invokeBlock:success response:response obj:responseObject];
    }
}

- (void)p_callBackFileWithDestination:(NSURL *(^)(NSURLResponse *, NSURL *))destination
                              success:(void (^)(id, id))success
                              failure:(void (^)(id, id))failure
                             response:(NSURLResponse *)response
                             location:(NSURL *)location
                                error:(NSError *)error
{
    if (error) {
        [self p_invokeBlock:failure response:response obj:error];
        return ;
    }
    
    NSURL *fileURL = nil;
    if (destination) {
        NSURL *destURL = destination(response, location);
        if (destURL) {
            fileURL = destURL;
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:destURL error:&error];
            if (error) {
                [self p_invokeBlock:failure response:response obj:error];
                return ;
            }
        }
    }
    
    [self p_invokeBlock:success response:response obj:fileURL];
}

- (void)p_invokeBlock:(void (^)(id, id))block response:(NSURLResponse *)response obj:(id)obj {
    if (block) {
        if ([NSThread isMainThread]) {
            block(response, obj);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(response, obj);
            });
        }
    }
}


#pragma mark - Progress Observing

- (void)p_addDownloadProgressBlock:(void (^)(NSProgress *))downloadProgressBlock
               uploadProgressBlock:(void (^)(NSProgress *))uploadProgressBlock
                           forTask:(NSURLSessionTask *)task
{
    if ((downloadProgressBlock == nil) && (uploadProgressBlock == nil)) return;
    
    p_SessionTaskProgressObserver *observer = [[p_SessionTaskProgressObserver alloc] init];
    observer.downloadProgressBlock = downloadProgressBlock;
    observer.uploadProgressBlock = uploadProgressBlock;
    [self p_addProgressObserver:observer forTask:task];
}

- (void)p_addProgressObserver:(p_SessionTaskProgressObserver *)observer
                      forTask:(NSURLSessionTask *)task
{
    NSLock *lock = [self p_lock];
    NSMutableDictionary *progressObserversByTaskIdentifier = [self p_progressObserversByTaskIdentifier];
    [lock lock];
    progressObserversByTaskIdentifier[@(task.taskIdentifier)] = observer;
    [observer p_setupProgressForTask:task];
    [lock unlock];
}

- (p_SessionTaskProgressObserver *)p_progressObserverForTask:(NSURLSessionTask *)task {
    NSLock *lock = [self p_lock];
    NSMutableDictionary *progressObserversByTaskIdentifier = [self p_progressObserversByTaskIdentifier];
    p_SessionTaskProgressObserver *observer = nil;
    [lock lock];
    observer = progressObserversByTaskIdentifier[@(task.taskIdentifier)];
    [lock unlock];
    
    return observer;
}

- (void)p_removeProgressObserverForTask:(NSURLSessionTask *)task {
    NSLock *lock = [self p_lock];
    NSMutableDictionary *progressObserversByTaskIdentifier = [self p_progressObserversByTaskIdentifier];
    p_SessionTaskProgressObserver *observer = [self p_progressObserverForTask:task];
    [lock lock];
    [observer p_cleanUpProgressForTask:task];
    [progressObserversByTaskIdentifier removeObjectForKey:@(task.taskIdentifier)];
    [lock unlock];
}


#pragma mark - Associated

- (NSLock *)p_lock {
    NSLock *lock = objc_getAssociatedObject(self, &kLockKey);
    if (lock == nil) {
        lock = [[NSLock alloc] init];
        objc_setAssociatedObject(self, &kLockKey, lock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return lock;
}

- (NSMutableDictionary *)p_progressObserversByTaskIdentifier {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &kProgressObserversKey);
    if (dict == nil) {
        dict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &kProgressObserversKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dict;
}

@end
