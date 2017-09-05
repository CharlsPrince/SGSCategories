/*!
 *  @header NSData+SGS.m
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */


#import "NSData+SGS.h"
#import "NSString+SGS.h"
#include <CommonCrypto/CommonCrypto.h>
#include <zlib.h>


@implementation NSData (SGS)

#pragma mark - 通用

// 通过资源文件（mainBundle 中查找）实例化 NSData
+ (instancetype)dataWithContentsOfMainBundleFile:(NSString *)filename
                                        fileType:(NSString *)ext
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    if (path == nil) return nil;
    return [NSData dataWithContentsOfFile:path];
}

// 从指定目录中读取数据
+ (instancetype)dataWithContentsOfFile:(NSString *)path
                   relativeToDirectory:(NSSearchPathDirectory)directory
                              inDomain:(NSSearchPathDomainMask)domainMask
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return nil;
    return [NSData dataWithContentsOfFile:path];
}

// 写入文件
- (BOOL)writeToFile:(NSString *)path
relativeToDirectory:(NSSearchPathDirectory)directory
           inDomain:(NSSearchPathDomainMask)domainMask
         atomically:(BOOL)useAuxiliaryFile
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return NO;
    return [self writeToFile:path atomically:useAuxiliaryFile];
}


#pragma mark - 转换与编码

+ (NSData *)dataWithUTF8String:(NSString *)string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)toUTF8String {
    if (self.length == 0) return nil;
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

+ (instancetype)dataWithHexString:(NSString *)hexString {
    hexString = [hexString stringByReplacingOccurrencesOfString:@" " withString:@""];
    hexString = [hexString lowercaseString];
    
    NSUInteger length = hexString.length;
    if (length == 0) return nil;
    if ((length % 2) != 0) return nil;
    
    const char *cHexStr = [hexString UTF8String];
    if (cHexStr == 0) return nil;
    
    NSMutableData *result = [NSMutableData dataWithCapacity:(length / 2)];
    unsigned char byte;
    char tempStr[3] = {'\0', '\0', '\0'};
    for (int i = 0; i < length / 2; i++) {
        tempStr[0] = cHexStr[i * 2];
        tempStr[1] = cHexStr[i * 2 + 1];
        byte = strtol(tempStr, NULL, 16);
        [result appendBytes:&byte length:1];
    }
    return result.copy;
}

- (NSString *)toHexString {
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02x", *byte];
    }
    return result.copy;
}

+ (NSData *)dataWithJSONObject:(id)json {
    return [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:NULL];
}

+ (NSData *)dataWithJSONObject:(id)json
                       options:(NSJSONWritingOptions)opt
                         error:(NSError * _Nullable __autoreleasing *)error
{
    return [NSJSONSerialization dataWithJSONObject:json options:opt error:error];
}

- (id)toJSONObject {
    return [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:NULL];
}

- (id)toJSONObjectWithOptions:(NSJSONReadingOptions)opt error:(NSError * _Nullable __autoreleasing *)error {
    return [NSJSONSerialization JSONObjectWithData:self options:opt error:error];
}

+ (NSData *)dataWithPropertyList:(id)plist {
    return [NSPropertyListSerialization dataWithPropertyList:plist
                                                      format:NSPropertyListXMLFormat_v1_0
                                                     options:0
                                                       error:NULL];
}

+ (NSData *)dataWithPropertyList:(id)plist
                          format:(NSPropertyListFormat)format
                           error:(out NSError * _Nullable __autoreleasing *)error
{
    return [NSPropertyListSerialization dataWithPropertyList:plist
                                                      format:format
                                                     options:0
                                                       error:error];
}

- (id)toPropertyList {
    return [NSPropertyListSerialization propertyListWithData:self
                                                     options:kNilOptions
                                                      format:NULL
                                                       error:NULL];
}

- (id)toPropertyListWithOptions:(NSPropertyListReadOptions)opt error:(NSError * _Nullable __autoreleasing *)error {
    return [NSPropertyListSerialization propertyListWithData:self
                                                     options:opt
                                                      format:NULL
                                                       error:error];
}

+ (instancetype)dataWithBase64EncodedString:(NSString *)base64String {
    return [[self alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSString *)base64EncodedString {
    return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (instancetype)dataWithBase64EncodedData:(NSData *)base64Data {
    return [[self alloc] initWithBase64EncodedData:base64Data options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSData *)base64EncodedData {
    return [self base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
}



#pragma mark - 解/压缩

// gzip 解压
- (NSData *)gzipInflate {
    if ([self length] == 0) return self;
    
    unsigned full_length = (unsigned)[self length];
    unsigned half_length = (unsigned)[self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (unsigned)[self length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15 + 32)) != Z_OK) return nil;
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy:half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd(&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    }
    
    return nil;
}

// gzip 压缩
- (NSData *)gzipDeflate {
    if ([self length] == 0) return self;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15 + 16),
                     8, Z_DEFAULT_STRATEGY) != Z_OK)
        return nil;
    
    // 16K chunks for expansion
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];
    
    do {
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy:16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
    }
    while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}

// zlib 解压
- (NSData *)zlibInflate {
    if ([self length] == 0) return self;
    
    NSUInteger full_length = [self length];
    NSUInteger half_length = [self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)full_length;
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit(&strm) != Z_OK) return nil;
    
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy:half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd(&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    }
    
    return nil;
}

// zlib 压缩
- (NSData *)zlibDeflate {
    if ([self length] == 0) return self;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit(&strm, Z_DEFAULT_COMPRESSION) != Z_OK) return nil;
    
    // 16K chuncks for expansion
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];
    
    do {
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy:16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
    }
    while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}


@end
