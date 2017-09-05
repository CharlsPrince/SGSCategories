/*!
 *  @header NSArray+SGS.m
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSArray+SGS.h"
#import "NSString+SGS.h"
#import "NSData+SGS.h"

@implementation NSArray (SGS)

+ (NSArray *)arrayWithContentsOfMainBundleFile:(NSString *)filename
                                      fileType:(NSString *)ext
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    if (path == nil) return nil;
    return [NSArray arrayWithContentsOfFile:path];
}

+ (NSArray *)arrayWithContentsOfFile:(NSString *)path
                 relativeToDirectory:(NSSearchPathDirectory)directory
                            inDomain:(NSSearchPathDomainMask)domainMask
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return nil;
    return [NSArray arrayWithContentsOfFile:path];
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

- (id)randomObject {
    NSUInteger count = self.count;
    return ((count > 0) ? self[arc4random_uniform((uint32_t)count)] : nil);
}

- (id)objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

#pragma mark - 编码转换

+ (NSArray *)arrayWithJSONData:(NSData *)data {
    return [NSArray arrayWithJSONData:data error:NULL];
}

+ (NSArray *)arrayWithJSONData:(NSData *)data error:(NSError * _Nullable __autoreleasing *)error {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingAllowFragments
                                                       error:error];
    return ([array isKindOfClass:[NSArray class]] ? array : nil);
}

- (NSData *)toJSONData {
    return [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:NULL];
}

- (NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opt error:(NSError * _Nullable __autoreleasing *)error {
    return [NSJSONSerialization dataWithJSONObject:self options:opt error:error];
}

+ (NSArray *)arrayWithJSONString:(NSString *)string {
    return [NSArray arrayWithJSONString:string error:NULL];
}

+ (NSArray *)arrayWithJSONString:(NSString *)string error:(NSError * _Nullable __autoreleasing *)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return nil;
    return [NSArray arrayWithJSONData:data error:error];
}

- (NSString *)toJSONString {
    return [[self toJSONData] toUTF8String];
}

- (NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opt error:(NSError * _Nullable __autoreleasing *)error {
    return [[self toJSONDataWithOptions:opt error:error] toUTF8String];
}

+ (NSArray *)arrayWithPlistData:(NSData *)data {
    return [NSArray arrayWithPlistData:data error:NULL];
}

+ (NSArray *)arrayWithPlistData:(NSData *)data error:(out NSError * _Nullable __autoreleasing *)error {
    NSArray *array = [NSPropertyListSerialization propertyListWithData:data
                                                               options:NSPropertyListImmutable
                                                                format:NULL
                                                                 error:error];
    return ([array isKindOfClass:[NSArray class]] ? array : nil);
}

- (NSData *)toPlistData {
    return [NSPropertyListSerialization dataWithPropertyList:self
                                                      format:NSPropertyListXMLFormat_v1_0
                                                     options:0
                                                       error:NULL];
}

- (NSData *)toPlistDataWithFormat:(NSPropertyListFormat)format error:(out NSError * _Nullable __autoreleasing *)error {
    return [NSPropertyListSerialization dataWithPropertyList:self
                                                      format:format
                                                     options:0
                                                       error:error];
}

+ (NSArray *)arrayWithPlistString:(NSString *)string {
    return [NSArray arrayWithPlistString:string error:NULL];
}

+ (NSArray *)arrayWithPlistString:(NSString *)string error:(out NSError * _Nullable __autoreleasing *)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return nil;
    return [NSArray arrayWithPlistData:data error:error];
}

- (NSString *)toPlistString {
    return [[self toPlistData] toUTF8String];
}

- (NSString *)toPlistStringWithFormat:(NSPropertyListFormat)format error:(NSError * _Nullable __autoreleasing *)error {
    return [[self toPlistDataWithFormat:format error:error] toUTF8String];
}

@end

