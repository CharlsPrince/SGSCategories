/*!
 *  @header NSDictionary+SGS.m
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSDictionary+SGS.h"
#import "NSString+SGS.h"
#import "NSData+SGS.h"

@implementation NSDictionary (SGS)

#pragma mark - 通用

+ (NSDictionary *)dictionaryWithContentsOfMainBundleFile:(NSString *)filename
                                                fileType:(NSString *)ext
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    if (path == nil) return nil;
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

+ (NSDictionary *)dictionaryWithContentsOfFile:(NSString *)path
                           relativeToDirectory:(NSSearchPathDirectory)directory
                                      inDomain:(NSSearchPathDomainMask)domainMask
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return nil;
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

- (BOOL)writeToFile:(NSString *)path
relativeToDirectory:(NSSearchPathDirectory)directory
           inDomain:(NSSearchPathDomainMask)domainMask
         atomically:(BOOL)useAuxiliaryFile
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return NO;
    return [self writeToFile:path atomically:useAuxiliaryFile];
}

// 返回排序后的所有key
- (NSArray *)allKeysSorted {
    return [self.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

// 返回按照key排序的所有值
- (NSArray *)allValuesSortedByKeys {
    NSArray *sortedKeys = [self allKeysSorted];
    NSMutableArray *arr = @[].mutableCopy;
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return arr.copy;
}

// 判断字典是否包含key对应的对象
- (BOOL)containsObjectForKey:(id)key {
    if (key == nil) return NO;
    return self[key] != nil;
}

// 获取一组key对应的对象
- (NSDictionary *)entriesForKeys:(NSArray *)keys {
    if (keys == nil || keys.count == 0) return nil;
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    for (id key in keys) {
        id value = self[key];
        if (value) dict[key] = value;
    }
    return dict.copy;
}

#pragma mark - 编码转换

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data {
    return [NSDictionary dictionaryWithJSONData:data error:NULL];
}

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data error:(NSError * _Nullable __autoreleasing *)error {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:error];
    return ([dict isKindOfClass:[NSDictionary class]] ? dict : nil);
}

- (NSData *)toJSONData {
    return [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:NULL];
}

- (NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opt error:(NSError * _Nullable __autoreleasing *)error {
    return [NSJSONSerialization dataWithJSONObject:self options:opt error:error];
}

+ (NSDictionary *)dictionaryWithJSONString:(NSString *)string {
    return [NSDictionary dictionaryWithJSONString:string error:NULL];
}

+ (NSDictionary *)dictionaryWithJSONString:(NSString *)string error:(NSError * _Nullable __autoreleasing *)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return nil;
    return [NSDictionary dictionaryWithJSONData:data error:error];
}

- (NSString *)toJSONString {
    return [[self toJSONData] toUTF8String];
}

- (NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opt error:(NSError * _Nullable __autoreleasing *)error {
    return [[self toJSONDataWithOptions:opt error:error] toUTF8String];
}

+ (NSDictionary *)dictionaryWithPlistData:(NSData *)data {
    return [NSDictionary dictionaryWithPlistData:data error:NULL];
}

+ (NSDictionary *)dictionaryWithPlistData:(NSData *)data error:(NSError * _Nullable __autoreleasing *)error {
    NSDictionary *dict = [NSPropertyListSerialization propertyListWithData:data
                                                                   options:NSPropertyListImmutable
                                                                    format:NULL
                                                                     error:error];
    return ([dict isKindOfClass:[NSDictionary class]] ? dict : nil);
}

- (NSData *)toPlistData {
    return [NSPropertyListSerialization dataWithPropertyList:self
                                                      format:NSPropertyListXMLFormat_v1_0
                                                     options:0
                                                       error:NULL];
}

- (NSData *)toPlistDataWithFormat:(NSPropertyListFormat)format error:(NSError * _Nullable __autoreleasing *)error {
    return [NSPropertyListSerialization dataWithPropertyList:self
                                                      format:format
                                                     options:0
                                                       error:error];
}

+ (NSDictionary *)dictionaryWithPlistString:(NSString *)string {
    return [NSDictionary dictionaryWithPlistString:string error:NULL];
}

+ (NSDictionary *)dictionaryWithPlistString:(NSString *)string error:(NSError * _Nullable __autoreleasing *)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return nil;
    return [NSDictionary dictionaryWithPlistData:data error:error];
}

- (NSString *)toPlistString {
    return [[self toPlistData] toUTF8String];
}

- (NSString *)toPlistStringWithFormat:(NSPropertyListFormat)format error:(NSError * _Nullable __autoreleasing *)error {
    return [[self toPlistDataWithFormat:format error:error] toUTF8String];
}
@end
