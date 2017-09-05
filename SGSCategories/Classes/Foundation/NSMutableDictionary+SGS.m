/*!
 *  @header NSMutableDictionary+SGS.m
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSMutableDictionary+SGS.h"
#import "NSString+SGS.h"
#import "NSData+SGS.h"

@implementation NSMutableDictionary (SGS)

#pragma mark - 通用

+ (NSMutableDictionary *)dictionaryWithContentsOfMainBundleFile:(NSString *)filename fileType:(NSString *)ext {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    if (path == nil) return nil;
    return [NSMutableDictionary dictionaryWithContentsOfFile:path];
}

+ (NSMutableDictionary *)dictionaryWithContentsOfFile:(NSString *)path
                                  relativeToDirectory:(NSSearchPathDirectory)directory
                                             inDomain:(NSSearchPathDomainMask)domainMask
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return nil;
    return [NSMutableDictionary dictionaryWithContentsOfFile:path];
}

// 弹出key对应的对象
- (id)popObjectForKey:(id)aKey {
    if (!aKey) return nil;
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}

// 弹出keys对应的所有对象
- (NSDictionary *)popEntriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dict = @{}.mutableCopy;
    for (id key in keys) {
        id value = self[key];
        if (value) {
            [self removeObjectForKey:key];
            dict[key] = value;
        }
    }
    return dict.copy;
}

#pragma mark - 编码转换

+ (NSMutableDictionary *)dictionaryWithJSONData:(NSData *)data {
    return [NSMutableDictionary dictionaryWithJSONData:data error:NULL];
}

+ (NSMutableDictionary *)dictionaryWithJSONData:(NSData *)data error:(NSError * _Nullable __autoreleasing *)error {
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers
                                                                  error:error];
    return ([dict isKindOfClass:[NSMutableDictionary class]] ? dict : nil);
}

+ (NSMutableDictionary *)dictionaryWithJSONString:(NSString *)string {
    return [NSMutableDictionary dictionaryWithJSONString:string error:NULL];
}

+ (NSMutableDictionary *)dictionaryWithJSONString:(NSString *)string error:(NSError * _Nullable __autoreleasing *)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return nil;
    return [NSMutableDictionary dictionaryWithJSONData:data error:error];
}

+ (NSMutableDictionary *)dictionaryWithPlistData:(NSData *)data {
    return [NSMutableDictionary dictionaryWithPlistData:data error:NULL];
}

+ (NSMutableDictionary *)dictionaryWithPlistData:(NSData *)data error:(NSError * _Nullable __autoreleasing *)error {
    NSMutableDictionary *dict = [NSPropertyListSerialization propertyListWithData:data
                                                                          options:NSPropertyListMutableContainers
                                                                           format:NULL
                                                                            error:error];
    return ([dict isKindOfClass:[NSMutableDictionary class]] ? dict : nil);
}

+ (NSMutableDictionary *)dictionaryWithPlistString:(NSString *)string {
    return [NSMutableDictionary dictionaryWithPlistString:string error:NULL];
}

+ (NSMutableDictionary *)dictionaryWithPlistString:(NSString *)string error:(NSError * _Nullable __autoreleasing *)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return nil;
    return [NSMutableDictionary dictionaryWithPlistData:data error:error];
}
@end
