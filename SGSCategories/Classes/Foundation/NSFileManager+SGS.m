/*!
 *  @header NSFileManager+SGS.m
 *
 *  @author Created by Lee on 16/4/24.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSFileManager+SGS.h"


@implementation NSFileManager (SGS)

+ (BOOL)createDirectoryAtPath:(NSString *)path attributes:(NSDictionary<NSString *,id> *)attributes {
    return [self createDirectoryAtPath:path withIntermediateDirectories:YES attributes:attributes error:NULL];
}

+ (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary<NSString *,id> *)attributes error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:createIntermediates attributes:attributes error:error];
}

+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSFileManager defaultManager] copyItemAtPath:srcPath toPath:dstPath error:error];
}

+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSFileManager defaultManager] moveItemAtPath:srcPath toPath:dstPath error:error];
}

+ (BOOL)linkItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSFileManager defaultManager] linkItemAtPath:srcPath toPath:dstPath error:error];
}

+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
}

+ (BOOL)fileExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory {
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:isDirectory];
}

+ (BOOL)isReadableFileAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isReadableFileAtPath:path];
}

+ (BOOL)isWritableFileAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isWritableFileAtPath:path];
}

+ (BOOL)isExecutableFileAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isExecutableFileAtPath:path];
}

+ (BOOL)isDeletableFileAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isDeletableFileAtPath:path];
}

+ (NSArray<NSString *> *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:error];
}

+ (NSArray<NSString *> *)subpathsOfDirectoryAtPath:(NSString *)path error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:error];
}

+ (BOOL)setAttributes:(NSDictionary<NSString *,id> *)attributes ofItemAtPath:(NSString *)path error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSFileManager defaultManager] setAttributes:attributes ofItemAtPath:path error:error];
}

+ (NSDictionary<NSString *,id> *)attributesOfItemAtPath:(NSString *)path error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSFileManager defaultManager] attributesOfItemAtPath:path error:error];
}
@end
