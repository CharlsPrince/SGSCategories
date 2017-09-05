/*!
 *  @header NSData+SGS.h
 *
 *  @abstract NSData 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 编码、转换、解压缩等扩展方法
 */
@interface NSData (SGS)

#pragma mark - 通用
///-----------------------------------------------------------------------------
/// @name 通用
///-----------------------------------------------------------------------------

/*!
 *  @brief 从 main bundle 中读取数据
 *
 *  @param filename 文件名
 *  @param ext      扩展名
 *
 *  @return NSData or nil
 */
+ (nullable instancetype)dataWithContentsOfMainBundleFile:(NSString *)filename
                                                 fileType:(nullable NSString *)ext;

/*!
 *  @brief 从指定文件中读取数据
 *
 *  @param path       文件名或相对路径
 *  @param directory  文件夹，例如：NSDocumentDirectory
 *  @param domainMask 域，例如：NSUserDomainMask
 *
 *  @return NSData or nil
 */
+ (nullable instancetype)dataWithContentsOfFile:(NSString *)path
                            relativeToDirectory:(NSSearchPathDirectory)directory
                                       inDomain:(NSSearchPathDomainMask)domainMask;

/*!
 *  @brief 将数据写入到指定路径中
 *
 *  @param path             文件名或相对路径
 *  @param directory        文件夹，例如：NSDocumentDirectory
 *  @param domainMask       域，例如：NSUserDomainMask
 *  @param useAuxiliaryFile 是否使用临时文件覆盖的形式
 *
 *  @return YES 写入成功； NO 写入失败或路径有误
 */
- (BOOL)writeToFile:(NSString *)path
relativeToDirectory:(NSSearchPathDirectory)directory
           inDomain:(NSSearchPathDomainMask)domainMask
         atomically:(BOOL)useAuxiliaryFile;


#pragma mark - 转换与编码
///-----------------------------------------------------------------------------
/// @name 转换与编码
///-----------------------------------------------------------------------------

/*!
 *  @brief 将 UTF8 编码的字符串转为 NSData，等同于 [string dataUsingEncoding:NSUTF8StringEncoding]
 *
 *  @param string 待转换的字符串
 *
 *  @return NSData or nil
 */
+ (nullable NSData *)dataWithUTF8String:(NSString *)string;

/*!
 *  @brief 将 NSData 转为 UTF8 编码的字符串
 *
 *  @return NSString or nil
 */
- (nullable NSString *)toUTF8String;

/*!
 *  @brief 将十六进制字符串转为 NSData
 *
 *  @param hexString 十六进制字符串，不区分大小写
 *
 *  @return NSData or nil
 */
+ (nullable NSData *)dataWithHexString:(NSString *)hexString;

/*!
 *  @brief 将 NSData 转为小写形式的十六进制字符串
 *
 *  @return 小写形式的十六进制字符串
 */
- (NSString *)toHexString;

/*!
 *  @brief 将 JSON 对象转为 NSData
 *
 *  @discussion NSJSONWritingOptions 为 kNilOptions
 *
 *  @param json JSON 对象
 *
 *  @return NSData or nil
 */
+ (nullable NSData *)dataWithJSONObject:(id)json;

/*!
 *  @brief 将 JSON 对象转为 NSData
 *
 *  @param json  JSON 对象
 *  @param opt   JSON 转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSData or nil
 */
+ (nullable NSData *)dataWithJSONObject:(id)json
                                options:(NSJSONWritingOptions)opt
                                  error:(NSError **)error;

/*!
 *  @brief 将 NSData 转为 JSON 对象
 *
 *  @discussion NSJSONReadingOptions 为 kNilOptions
 *
 *  @return JSON 对象 or nil
 */
- (nullable id)toJSONObject;

/*!
 *  @brief 将 NSData 转为 JSON 对象
 *
 *  @param opt   JSON 转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return JSON 对象 or nil
 */
- (nullable id)toJSONObjectWithOptions:(NSJSONReadingOptions)opt
                                 error:(NSError **)error;

/*!
 *  @brief 将 plist 对象转为 NSData
 *
 *  @discussion 转换格式为 XML 形式
 *
 *  @param plist plist 对象
 *
 *  @return NSData or nil
 */
+ (nullable NSData *)dataWithPropertyList:(id)plist;

/*!
 *  @brief 将 plist 对象转为 NSData
 *
 *  @param plist  plist 对象
 *  @param format 转换格式
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSData or nil
 */
+ (nullable NSData *)dataWithPropertyList:(id)plist
                                   format:(NSPropertyListFormat)format
                                    error:(out NSError **)error;

/*!
 *  @brief 将 NSData 转为 plist 对象
 *
 *  @discussion NSPropertyListReadOptions 为 kNilOptions
 *
 *  @return plist 对象 or nil
 */
- (nullable id)toPropertyList;

/*!
 *  @brief 将 NSData 转为 plist 对象
 *
 *  @param opt   转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return plist 对象 or nil
 */
- (nullable id)toPropertyListWithOptions:(NSPropertyListReadOptions)opt
                                   error:(NSError **)error;

/*!
 *  @brief 将 Base-64 编码的字符串解码为 NSData
 *
 *  @discussion 编码形式默认为 NSDataBase64DecodingIgnoreUnknownCharacters
 *
 *  @param base64String Base-64 编码的字符串
 *
 *  @return 解码后的 NSData or nil
 */
+ (nullable instancetype)dataWithBase64EncodedString:(NSString *)base64String;

/*!
 *  @brief 将 NSData 转为 Base-64 编码字符串
 *
 *  @discussion 编码形式默认为 NSDataBase64Encoding64CharacterLineLength
 *
 *  @return Base-64 编码字符串
 */
- (NSString *)base64EncodedString;

/*!
 *  @brief 解码 Base-64 编码数据
 *
 *  @param base64Data Base-64 编码数据
 *
 *  @return 解码后的 NSData or nil
 */
+ (nullable instancetype)dataWithBase64EncodedData:(NSData *)base64Data;

/*!
 *  @brief Base-64 编码数据
 *
 *  @return Base-64 编码数据
 */
- (NSData *)base64EncodedData;


#pragma mark - 解/压缩
///-----------------------------------------------------------------------------
/// @name 解/压缩
///-----------------------------------------------------------------------------

/*!
 *  @brief gzip 解压
 *
 *  @return 解压后的NSData or nil
 */
- (nullable NSData *)gzipInflate;

/*!
 *  @brief gzip 压缩
 *
 *  @return 压缩后的NSData or nil
 */
- (nullable NSData *)gzipDeflate;

/*!
 *  @brief zlib 解压
 *
 *  @return 解压后的NSData or nil
 */
- (nullable NSData *)zlibInflate;

/*!
 *  @brief zlib 压缩
 *
 *  @return 压缩后的NSData or nil
 */
- (nullable NSData *)zlibDeflate;

@end

NS_ASSUME_NONNULL_END
