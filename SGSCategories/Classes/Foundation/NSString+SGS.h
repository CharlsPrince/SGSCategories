/*!
 *  @header NSString+SGS.h
 *
 *  @abstract NSString 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 编码、转换、正则表达式验证等扩展方法
 */
@interface NSString (SGS)

#pragma mark - 通用
///-----------------------------------------------------------------------------
/// @name 通用
///-----------------------------------------------------------------------------

/*!
 *  @brief 拼接路径
 *
 *  @param path       相对路径
 *  @param directory  根目录文件夹，例如：NSDocumentDirectory
 *  @param domainMask 域，例如：NSUserDomainMask
 *
 *  @return 路径
 */
+ (nullable instancetype)stringWithPath:(NSString *)path
                    relativeToDirectory:(NSSearchPathDirectory)directory
                               inDomain:(NSSearchPathDomainMask)domainMask;

/*!
 *  @brief 从 main bundle 中读取字符串
 *
 *  @discussion 默认使用 UTF8 编码
 *
 *  @param filename 文件名
 *  @param ext      扩展名
 *
 *  @return 字符串 or nil
 */
+ (nullable instancetype)stringWithContentsOfMainBundleFile:(NSString *)filename
                                                   fileType:(nullable NSString *)ext;

/*!
 *  @brief 从 main bundle 中读取字符串
 *
 *  @param filename 文件名
 *  @param ext      扩展名
 *  @param enc      字符串编码形式
 *  @param error    如果读取失败将会传递错误给该参数
 *
 *  @return 字符串 or nil
 */
+ (nullable instancetype)stringWithContentsOfMainBundleFile:(NSString *)filename
                                                   fileType:(nullable NSString *)ext
                                                   encoding:(NSStringEncoding)enc
                                                      error:(NSError **)error;

/*!
 *  @brief 从指定文件中读取字符串
 *
 *  @discussion 默认使用 UTF8 编码
 *
 *  @param path       文件名或相对路径
 *  @param directory  文件夹，例如：NSDocumentDirectory
 *  @param domainMask 域，例如：NSUserDomainMask
 *
 *  @return 字符串 or nil
 */
+ (nullable instancetype)stringWithContentsOfFile:(NSString *)path
                              relativeToDirectory:(NSSearchPathDirectory)directory
                                         inDomain:(NSSearchPathDomainMask)domainMask;

/*!
 *  @brief 从指定文件中读取字符串
 *
 *  @param path       文件名或相对路径
 *  @param directory  文件夹，例如：NSDocumentDirectory
 *  @param domainMask 域，例如：NSUserDomainMask
 *  @param enc        字符串编码
 *  @param error      如果读取失败将会传递错误给该参数
 *
 *  @return 字符串 or nil
 */
+ (nullable instancetype)stringWithContentsOfFile:(NSString *)path
                              relativeToDirectory:(NSSearchPathDirectory)directory
                                         inDomain:(NSSearchPathDomainMask)domainMask
                                         encoding:(NSStringEncoding)enc
                                            error:(NSError **)error;

/*!
 *  @brief 将字符串写入到指定路径中
 *
 *  @discussion 默认使用 UTF8 编码
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

/*!
 *  @brief 将字符串写入到指定路径中
 *
 *  @param path             文件名或相对路径
 *  @param directory        文件夹，例如：NSDocumentDirectory
 *  @param domainMask       域，例如：NSUserDomainMask
 *  @param useAuxiliaryFile 是否使用临时文件覆盖的形式
 *  @param enc              字符串编码
 *  @param error            如果写入失败将会传递错误给该参数
 *
 *  @return YES 写入成功； NO 写入失败或路径有误
 */
- (BOOL)writeToFile:(NSString *)path
relativeToDirectory:(NSSearchPathDirectory)directory
           inDomain:(NSSearchPathDomainMask)domainMask
         atomically:(BOOL)useAuxiliaryFile
           encoding:(NSStringEncoding)enc
              error:(NSError **)error;

/*!
 *  @brief 去除首尾空字符（包括换行符）
 *
 *  @return 去除首尾空字符后的字符串
 */
- (NSString *)trim;

/*!
 *  @brief 判断字符串是否包含空字符
 *
 *  @discussion 根据 [NSCharacterSet whitespaceAndNewlineCharacterSet] 判断
 *
 *  @return `YES` 含有空格、制表符、回车符或换行符； `NO` 不包含空字符
 */
- (BOOL)hasBlank;

/*!
 *  @brief 判断字符串是否包含特定字符
 *
 *  @param set 需要判断的字符集
 *
 *  @return `YES` or `NO`
 */
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;

/*!
 *  @brief 返回字符串范围
 *
 *  @return [self rangeOfComposedCharacterSequenceAtIndex:self.length]
 */
- (NSRange)rangeOfAll;


#pragma mark - 字符串转换与编码
///-----------------------------------------------------------------------------
/// @name 字符串转换与编码
///-----------------------------------------------------------------------------

/*!
 *  @brief 将字符串转换为 NSNumber 类型
 *
 *  @return 如果是数值类型返回 NSNumber；如果是非数值类型（如：@"abc"）则返回'nil'
 */
- (nullable NSNumber *)numberValue;

/*!
 *  @brief 将 NSData 转为 UTF8 编码的字符串
 *
 *  @param data 数据
 *
 *  @return NSString or nil
 */
+ (nullable instancetype)stringWithUTF8Data:(NSData *)data;

/*!
 *  @brief 返回 UTF8 编码的NSData，等同于：[self dataUsingEncoding:NSUTF8StringEncoding]
 *
 *  @return NSData or nil
 */
- (nullable NSData *)toUTF8Data;

/*!
 *  @brief 将 JSON 对象转为字符串
 *
 *  @discussion NSJSONWritingOptions 为 kNilOptions
 *
 *  @param json JSON 对象
 *
 *  @return NSString or nil
 */
+ (nullable NSString *)stringWithJSONObject:(id)json;

/*!
 *  @brief 将 JSON 对象转为字符串
 *
 *  @param json  JSON 对象
 *  @param opt   JSON 转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSString or nil
 */
+ (nullable NSString *)stringWithJSONObject:(id)json
                                    options:(NSJSONWritingOptions)opt
                                      error:(NSError **)error;

/*!
 *  @brief 将字符串转为 JSON 对象
 *
 *  @discussion 例如: @"{\"name\":\"a\",\"count\":2}" -> @{@"name":@"a",@"count":@2}
 *      NSJSONWritingOptions 为 kNilOptions
 *
 *  @return JSON 对象 or nil
 */
- (nullable id)toJSONObject;

/*!
 *  @brief 将字符串转为 JSON 对象
 *
 *  @discussion 例如: @"{\"name\":\"a\",\"count\":2}" -> @{@"name":@"a",@"count":@2}
 *
 *  @param opt   JSON 转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return JSON 对象 or nil
 */
- (nullable id)toJSONObjectWithOptions:(NSJSONReadingOptions)opt
                                 error:(NSError **)error;

/*!
 *  @brief 将 plist 对象转为字符串
 *
 *  @discussion 转换格式为 XML 形式
 *
 *  @param plist plist 对象
 *
 *  @return NSString or nil
 */
+ (nullable NSString *)stringWithPropertyList:(id)plist;

/*!
 *  @brief 将 plist 对象转为字符串
 *
 *  @param plist  plist 对象
 *  @param format 转换格式
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSString or nil
 */
+ (nullable NSString *)stringWithPropertyList:(id)plist
                                       format:(NSPropertyListFormat)format
                                        error:(NSError **)error;

/*!
 *  @brief 将字符串转为 plist 对象
 *
 *  @discussion NSPropertyListReadOptions 为 kNilOptions
 *
 *  @return plist 对象 or nil
 */
- (nullable id)toPropertyList;

/*!
 *  @brief 将字符串转为 plist 对象
 *
 *  @param opt   plist 转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return plist 对象 or nil
 */
- (nullable id)toPropertyListWithOptions:(NSPropertyListReadOptions)opt
                                   error:(NSError **)error;

/*!
 *  @brief 解码 Base-64 字符串
 *
 *  @discussion 解码选项为 NSDataBase64DecodingIgnoreUnknownCharacters
 *
 *  @param base64String Base-64 编码的字符串
 *
 *  @return 解码后的字符串 or nil
 */
+ (nullable instancetype)stringWithBase64EncodedString:(NSString *)base64String;

/*!
 *  @brief 解码 Base-64 字符串
 *
 *  @param base64String Base-64 编码的字符串
 *  @param options      解码选项
 *
 *  @return 解码后的字符串 or nil
 */
+ (nullable instancetype)stringWithBase64EncodedString:(NSString *)base64String
                                               options:(NSDataBase64DecodingOptions)options;

/*!
 *  @brief 将字符串进行 Base-64 编码
 *
 *  @discussion 编码选项为 NSDataBase64Encoding64CharacterLineLength
 *
 *  @return Base-64 编码字符串
 */
- (NSString *)base64EncodedString;

/*!
 *  @brief 将字符串进行 Base-64 编码
 *
 *  @param options 编码选项
 *
 *  @return Base-64 编码字符串
 */
- (NSString *)base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)options;

/*!
 *  @brief 将字符串进行编码令其符合URL规范
 *
 *  @discussion iOS7以后等同于：[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
 *
 *  @return 编码后的 NSString or nil
 */
- (nullable NSString *)stringByURLQueryEncode;

/*!
 *  @brief 去除编码格式
 *
 *  @discussion iOS7以后等同于：[self stringByRemovingPercentEncoding]
 *
 *  @return 去除编码后的 NSString or nil
 */
- (nullable NSString *)stringByURLQueryDecode;

/*!
 *  @brief 将HTML格式字符串进行转换
 *
 *  @discussion 转换规则如下：
 *      1. ["] 转义为 [&quot;]
 *      2. [&] 转义为 [&amp;]
 *      3. ['] 转义为 [&apos;]
 *      4. [<] 转义为 [&lt;]
 *      5. [>] 转义为 [&gt;]
 *
 *  @return 编码后的 NSString or nil
 */
- (NSString *)stringByEscapingHTML;


#pragma mark - 正则表达式
///-----------------------------------------------------------------------------
/// @name 正则表达式
///-----------------------------------------------------------------------------

/*!
 *  @brief 通过正则表达式替换部分字符串
 *
 *  @param regex       正则表达式
 *  @param options     匹配规则
 *  @param replacement 替换的字符串
 *  @param error       如果正则表达式有误，那么将传递错误到该参数中，并且返回原始字符串
 *
 *  @return 替换后的字符串 or 原始字符串
 */
- (NSString *)stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement
                               error:(NSError **)error;

/*!
 *  @brief 使用正则表达式验证字符串是否匹配
 *
 *  @param regex 正则表达式
 *
 *  @return 是否匹配
 */
- (BOOL)validateByRegex:(NSString *)regex;

/*!
 *  @brief 身份证验证（15位或18位）
 *
 *  @discussion
 *  身份证15位编码规则：dddddd yymmdd xx p
 *      - dddddd：6位地区编码
 *      - yymmdd: 出生年(两位年)月日，如：910215
 *      - xx: 顺序编码，系统产生，无法确定
 *      - p: 性别，奇数为男，偶数为女
 *  只使用正则表达式验证
 *
 *  身份证18位编码规则：dddddd yyyymmdd xxx y
 *      - dddddd：6位地区编码
 *      - yyyymmdd: 出生年(四位年)月日，如：19910215
 *      - xxx：顺序编码，系统产生，无法确定，奇数为男，偶数为女
 *      - y: 校验码，该位数值可通过前17位计算获得
 *  除了使用正则表达式验证外，还对最后一位进行校验
 *
 *  regex: ^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validIdentificationCard;

/*!
 *  @brief 中国手机号码验证（13\14\15\17\18开头的11位纯数字，也可以包含+86）
 *
 *  @discussion regex: ^(\\+?\\d{2}-?)?(1[34578])\\d{9}$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validChineseMobilePhoneNumber;

/*!
 *  @brief 中国移动手机号码验证
 *
 *  @discussion regex: ^1(34[0-8]|(3[5-9]|5[0127-9]|8[23478]|47|78)\\d)\\d{7}$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validChinaMobilePhoneNumber;

/*!
 *  @brief 中国联通手机号码验证
 *
 *  @discussion regex: ^1(34[0-8]|(3[5-9]|5[0127-9]|8[23478]|47|78)\\d)\\d{7}$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validChinaUnicomPhoneNumber;

/*!
 *  @brief 中国电信手机号码验证
 *
 *  @discussion regex: ^1(34[0-8]|(3[5-9]|5[0127-9]|8[23478]|47|78)\\d)\\d{7}$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validChinaTelecomPhoneNumber;

/*!
 *  @brief 中国座机电话号码验证（010-12345678 或 0123-1234567）
 *
 *  @discussion regex: ^\d{3}-\d{8}|\d{4}-\d{7}$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validChinesePhoneNumber;

/*!
 *  @brief 电子邮箱验证
 *
 *  @discussion regex: ^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validEmail;

/*!
 *  @brief 中国邮政编码验证
 *
 *  @discussion regex: ^[1-9]\d{5}(?!\d)$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validPostcode;

/*!
 *  @brief QQ号验证（不以0开头的5-12位数字）
 *
 *  @discussion regex: ^[1-9]\d{4,11}$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validQQ;

/*!
 *  @brief 账户验证（5-20位 字母、数字或下划线或.）
 *
 *  @discussion regex: ^[A-Za-z0-9_.]{5,20}+$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validAccount;

/*!
 *  @brief 密码验证（6-18位ACSII字符，包括：大小写字母、数字、以及部分特殊字符）
 *
 *  @discussion 特殊字符包括：空格!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
 *      regex: ^[\u0020-\u007f]{6,18}$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validPassword;

/*!
 *  @brief IP地址验证（IPv4）
 *
 *  @discussion regex: ^((([1-9]\d?)|(1\d{2})|(2[0-4]\d)|(25[0-5]))\.){3}(([1-9]\d?)|(1\d{2})|(2[0-4]\d)|(25[0-5]))$
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)validIPv4;

/*!
 *  @brief 判断是否是空白行
 *
 *  @discussion regex: \n\s*\r
 *
 *  @return `YES` 合法； `NO` 不合法
 */
- (BOOL)isAfterSpace;


#pragma mark - 数字属性
///-----------------------------------------------------------------------------
/// @name 数字属性
///-----------------------------------------------------------------------------

@property (nonatomic, assign, readonly) char charValue;
@property (nonatomic, assign, readonly) unsigned char unsignedCharValue;
@property (nonatomic, assign, readonly) short shortValue;
@property (nonatomic, assign, readonly) unsigned short unsignedShortValue;
@property (nonatomic, assign, readonly) unsigned int unsignedIntValue;
@property (nonatomic, assign, readonly) long longValue;
@property (nonatomic, assign, readonly) unsigned long unsignedLongValue;
@property (nonatomic, assign, readonly) unsigned long long unsignedLongLongValue;
@property (nonatomic, assign, readonly) NSUInteger unsignedIntegerValue;

@end

NS_ASSUME_NONNULL_END
