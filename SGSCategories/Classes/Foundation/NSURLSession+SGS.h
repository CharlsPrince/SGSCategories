/*!
 *  @header NSURLSession+SGS.h
 *
 *  @abstract NSURLSession 扩展
 *
 *  @author Created by Lee on 16/9/19.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 请求进度闭包
 *
 *  @param progress 请求进度
 */
typedef void(^SGSProgressBlock)(NSProgress *progress);

/*!
 *  @brief 请求响应过滤闭包
 *
 *  @param response     响应
 *  @param responseData 请求返回的数据
 *
 *  @return id or NSError
 */
typedef id _Nullable (^SGSResponseFilterBlock)(NSURLResponse *response, NSData * _Nullable responseData);

/*!
 *  @brief 请求成功
 *
 *  @param response       响应
 *  @param responseObject 请求返回的数据
 */
typedef void(^SGSResponseSuccessBlock)(NSURLResponse *response, id _Nullable responseObject);

/*!
 *  @brief 请求失败
 *
 *  @param response 响应
 *  @param error    失败信息
 */
typedef void(^SGSResponseFailureBlock)(NSURLResponse * _Nullable response, NSError *error);

/*!
 *  @brief 下载成功
 *
 *  @param response 响应
 *  @param filePath 下载数据的路径
 */
typedef void(^SGSDownloadSuccessBlock)(NSURLResponse *response, NSURL * _Nullable filePath);

/*!
 *  @brief 下载完成后保存路径闭包
 *
 *  @param response 响应
 *  @param location 下载数据的临时路径
 *
 *  @return File URL
 */
typedef NSURL * _Nonnull (^SGSDownloadTargetBlock)(NSURLResponse *response, NSURL *location);


@interface NSURLSession (SGS)

#pragma mark - Response Filter
///-----------------------------------------------------------------------------
/// @name Response Filter
///-----------------------------------------------------------------------------

/*!
 *  @brief 返回字符串
 *
 *  @return 请求完毕后的过滤闭包
 */
+ (SGSResponseFilterBlock)responseStringFilter;

/*!
 *  @brief 返回 JSON 数据
 *
 *  @return 请求完毕后的过滤闭包
 */
+ (SGSResponseFilterBlock)responseJSONFilter;



#pragma mark - HTTP Request
///-----------------------------------------------------------------------------
/// @name HTTP Request
///-----------------------------------------------------------------------------

/*!
 *  @brief HTTP 请求，请求方法自定义
 *
 *  @discussion 如果 filter 为空，那么 success 将回调原始返回的 NSData 数据
 *
 *      如果 filter 不为空，那么在请求完毕后调用该闭包，根据该闭包返回的数据类型进行判断：
 *      - NSError 类型：回调 failure 闭包
 *      - 其他类型     ：回调 success 闭包，传入的 responseObject 由 filter 的返回值提供
 *
 *  @param request HTTP 请求
 *  @param filter  请求完毕后的过滤闭包
 *  @param success 请求成功
 *  @param failure 请求失败
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                               responseFilter:(nullable SGSResponseFilterBlock)filter
                                      success:(nullable SGSResponseSuccessBlock)success
                                      failure:(nullable SGSResponseFailureBlock)failure;

/*!
 *  @brief HTTP GET 请求
 *
 *  @discussion 如果 filter 为空，那么 success 将回调原始返回的 NSData 数据
 *
 *      如果 filter 不为空，那么在请求完毕后调用该闭包，根据该闭包返回的数据类型进行判断：
 *      - NSError 类型：回调 failure 闭包
 *      - 其他类型     ：回调 success 闭包，传入的 responseObject 由 filter 的返回值提供
 *
 *  @param url     请求地址
 *  @param filter  请求完毕后的过滤闭包
 *  @param success 请求成功
 *  @param failure 请求失败
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
                           responseFilter:(nullable SGSResponseFilterBlock)filter
                                  success:(nullable SGSResponseSuccessBlock)success
                                  failure:(nullable SGSResponseFailureBlock)failure;

/*!
 *  @brief HTTP 请求，请求方法自定义
 *
 *  @discussion 如果 filter 为空，那么 success 将回调原始返回的 NSData 数据
 *
 *      如果 filter 不为空，那么在请求完毕后调用该闭包，根据该闭包返回的数据类型进行判断：
 *      - NSError 类型：回调 failure 闭包
 *      - 其他类型     ：回调 success 闭包，传入的 responseObject 由 filter 的返回值提供
 *
 *  @param request               HTTP 请求
 *  @param downloadProgressBlock 下载进度闭包
 *  @param uploadProgressBlock   上传进度闭包
 *  @param filter                请求完毕后的过滤闭包
 *  @param success               请求成功
 *  @param failure               请求失败
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                             downloadProgress:(nullable SGSProgressBlock)downloadProgressBlock
                               uploadProgress:(nullable SGSProgressBlock)uploadProgressBlock
                               responseFilter:(nullable SGSResponseFilterBlock)filter
                                      success:(nullable SGSResponseSuccessBlock)success
                                      failure:(nullable SGSResponseFailureBlock)failure;

/*!
 *  @brief HTTP GET 请求
 *
 *  @discussion 如果 filter 为空，那么 success 将回调原始返回的 NSData 数据
 *
 *      如果 filter 不为空，那么在请求完毕后调用该闭包，根据该闭包返回的数据类型进行判断：
 *      - NSError 类型：回调 failure 闭包
 *      - 其他类型     ：回调 success 闭包，传入的 responseObject 由 filter 的返回值提供
 *
 *  @param url                   请求地址
 *  @param downloadProgressBlock 下载进度闭包
 *  @param uploadProgressBlock   上传进度闭包
 *  @param filter                请求完毕后的过滤闭包
 *  @param success               请求成功
 *  @param failure               请求失败
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
                         downloadProgress:(nullable SGSProgressBlock)downloadProgressBlock
                           uploadProgress:(nullable SGSProgressBlock)uploadProgressBlock
                           responseFilter:(nullable SGSResponseFilterBlock)filter
                                  success:(nullable SGSResponseSuccessBlock)success
                                  failure:(nullable SGSResponseFailureBlock)failure;

#pragma mark - Upload
///-----------------------------------------------------------------------------
/// @name Upload
///-----------------------------------------------------------------------------

/*!
 *  @brief 上传文件
 *
 *  @discussion 如果 filter 为空，那么 success 将回调原始返回的 NSData 数据
 *
 *      如果 filter 不为空，那么在请求完毕后调用该闭包，根据该闭包返回的数据类型进行判断：
 *      - NSError 类型：回调 failure 闭包
 *      - 其他类型     ：回调 success 闭包，传入的 responseObject 由 filter 的返回值提供
 *
 *  @param request       HTTP 请求
 *  @param fileURL       文件 URL
 *  @param progressBlock 上传进度闭包
 *  @param filter        上传完毕后的过滤闭包
 *  @param success       上传成功
 *  @param failure       上传失败
 *
 *  @return NSURLSessionUploadTask
 */
- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromFile:(NSURL *)fileURL
                                         progress:(nullable SGSProgressBlock)progressBlock
                                   responseFilter:(nullable SGSResponseFilterBlock)filter
                                          success:(nullable SGSResponseSuccessBlock)success
                                          failure:(nullable SGSResponseFailureBlock)failure;

/*!
 *  @brief 上传数据
 *
 *  @discussion 如果 filter 为空，那么 success 将回调原始返回的 NSData 数据
 *
 *      如果 filter 不为空，那么在请求完毕后调用该闭包，根据该闭包返回的数据类型进行判断：
 *      - NSError 类型：回调 failure 闭包
 *      - 其他类型     ：回调 success 闭包，传入的 responseObject 由 filter 的返回值提供
 *
 *  @param request       HTTP 请求
 *  @param bodyData      待上传的数据
 *  @param progressBlock 上传进度闭包
 *  @param filter        上传完毕后的过滤闭包
 *  @param success       上传成功
 *  @param failure       上传失败
 *
 *  @return NSURLSessionUploadTask
 */
- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromData:(nullable NSData *)bodyData
                                         progress:(nullable SGSProgressBlock)progressBlock
                                   responseFilter:(nullable SGSResponseFilterBlock)filter
                                          success:(nullable SGSResponseSuccessBlock)success
                                          failure:(nullable SGSResponseFailureBlock)failure;


#pragma mark - Download
///-----------------------------------------------------------------------------
/// @name Download
///-----------------------------------------------------------------------------

/*!
 *  @brief 下载
 *
 *  @param request       HTTP 请求
 *  @param progressBlock 下载进度闭包
 *  @param destination   下载完毕后的保存路径
 *  @param success       下载成功
 *  @param failure       下载失败
 *
 *  @return NSURLSessionDownloadTask
 */
- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(nullable SGSProgressBlock)progressBlock
                                          destination:(nullable SGSDownloadTargetBlock)destination
                                              success:(nullable SGSDownloadSuccessBlock)success
                                              failure:(nullable SGSResponseFailureBlock)failure;
/*!
 *  @brief 下载
 *
 *  @param url           下载地址
 *  @param progressBlock 下载进度闭包
 *  @param destination   下载完毕后的保存路径
 *  @param success       下载成功
 *  @param failure       下载失败
 *
 *  @return NSURLSessionDownloadTask
 */
- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSURL *)url
                                         progress:(nullable SGSProgressBlock)progressBlock
                                      destination:(nullable SGSDownloadTargetBlock)destination
                                          success:(nullable SGSDownloadSuccessBlock)success
                                          failure:(nullable SGSResponseFailureBlock)failure;

/*!
 *  @brief 断点续传
 *
 *  @param resumeData    断点数据
 *  @param progressBlock 下载进度闭包
 *  @param destination   下载完毕后的保存路径
 *  @param success       下载成功
 *  @param failure       下载失败
 *
 *  @return NSURLSessionDownloadTask
 */
- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData
                                                progress:(nullable SGSProgressBlock)progressBlock
                                             destination:(nullable SGSDownloadTargetBlock)destination
                                                 success:(nullable SGSDownloadSuccessBlock)success
                                                 failure:(nullable SGSResponseFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END