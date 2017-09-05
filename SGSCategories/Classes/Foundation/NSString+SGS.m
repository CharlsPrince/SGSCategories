/*!
 *  @header NSString+SGS.m
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSString+SGS.h"
#import "NSData+SGS.h"
#import "NSNumber+SGS.h"

#define ErrorLog(msg, error) if (error != nil) { \
NSLog((@"%s [Line %d] "  msg @" {Error: %@}"), __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]); \
}

@implementation NSString (SGS)

#pragma mark - 通用

// 拼接路径
+ (instancetype)stringWithPath:(NSString *)path
           relativeToDirectory:(NSSearchPathDirectory)directory
                      inDomain:(NSSearchPathDomainMask)domainMask
{
    NSString *result = NSSearchPathForDirectoriesInDomains(directory, domainMask, YES).firstObject;
    if (result != nil) {
        if ([path hasPrefix:@"/"]) {
            result = [result stringByAppendingString:path];
        } else {
            result = [result stringByAppendingPathComponent:path];
        }
    }
    
    return result;
}

// 从 main bundle 中读取字符串
+ (instancetype)stringWithContentsOfMainBundleFile:(NSString *)filename
                                          fileType:(NSString *)ext
{
    return [self stringWithContentsOfMainBundleFile:filename
                                           fileType:ext
                                           encoding:NSUTF8StringEncoding
                                              error:NULL];
}

// 从 main bundle 中读取字符串
+ (instancetype)stringWithContentsOfMainBundleFile:(NSString *)filename
                                          fileType:(NSString *)ext
                                          encoding:(NSStringEncoding)enc
                                             error:(NSError * _Nullable __autoreleasing *)error
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    if (path == nil) return nil;
    return [self stringWithContentsOfFile:path encoding:enc error:error];
}

// 从指定文件中读取字符串
+ (instancetype)stringWithContentsOfFile:(NSString *)path
                     relativeToDirectory:(NSSearchPathDirectory)directory
                                inDomain:(NSSearchPathDomainMask)domainMask
{
    return [self stringWithContentsOfFile:path
                      relativeToDirectory:directory
                                 inDomain:domainMask
                                 encoding:NSUTF8StringEncoding
                                    error:NULL];
}

// 从指定文件中读取字符串
+ (instancetype)stringWithContentsOfFile:(NSString *)path
                     relativeToDirectory:(NSSearchPathDirectory)directory
                                inDomain:(NSSearchPathDomainMask)domainMask
                                encoding:(NSStringEncoding)enc
                                   error:(NSError * _Nullable __autoreleasing *)error
{
    path = [self stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return nil;
    return [self stringWithContentsOfFile:path encoding:enc error:error];
}

// 将字符串写入到指定路径中
- (BOOL)writeToFile:(NSString *)path
relativeToDirectory:(NSSearchPathDirectory)directory
           inDomain:(NSSearchPathDomainMask)domainMask
         atomically:(BOOL)useAuxiliaryFile
{
    return [self writeToFile:path
         relativeToDirectory:directory
                    inDomain:domainMask
                  atomically:useAuxiliaryFile
                    encoding:NSUTF8StringEncoding
                       error:NULL];
}

// 将字符串写入到指定路径中
- (BOOL)writeToFile:(NSString *)path
relativeToDirectory:(NSSearchPathDirectory)directory
           inDomain:(NSSearchPathDomainMask)domainMask
         atomically:(BOOL)useAuxiliaryFile
           encoding:(NSStringEncoding)enc
              error:(NSError * _Nullable __autoreleasing *)error
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return NO;
    return [self writeToFile:path atomically:useAuxiliaryFile encoding:enc error:error];
}

// 去除首尾空字符（包括换行符）
- (NSString *)trim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

// 判断字符串是否包含空字符
- (BOOL)hasBlank
{
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if ([blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

// 判断字符串是否包含特定字符
- (BOOL)containsCharacterSet:(NSCharacterSet *)set
{
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

// 返回字符串范围
- (NSRange)rangeOfAll
{
    return [self rangeOfComposedCharacterSequenceAtIndex:self.length];
}

#pragma mark - 字符串转换与编码

// 将字符串转换为NSNumber类型
- (NSNumber *)numberValue
{
    return [NSNumber numberWithString:self];
}

// 将 NSData 转为 UTF8 编码的字符串
+ (instancetype)stringWithUTF8Data:(NSData *)data
{
    return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

// 返回 UTF8 编码的NSData
- (NSData *)toUTF8Data
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// 将 JSON 对象转为字符串
+ (NSString *)stringWithJSONObject:(id)json
{
    return [[NSData dataWithJSONObject:json] toUTF8String];
}

// 将 JSON 对象转为字符串
+ (NSString *)stringWithJSONObject:(id)json
                           options:(NSJSONWritingOptions)opt
                             error:(NSError * _Nullable __autoreleasing *)error
{
    return [[NSData dataWithJSONObject:json options:opt error:error] toUTF8String];
}

// 将字符串转为 JSON 对象
- (id)toJSONObject
{
    return [[self toUTF8Data] toJSONObject];
}

// 将字符串转为 JSON 对象
- (id)toJSONObjectWithOptions:(NSJSONReadingOptions)opt
                        error:(NSError * _Nullable __autoreleasing *)error
{
    return [[self toUTF8Data] toJSONObjectWithOptions:opt error:error];
}

// 将 plist 对象转为字符串
+ (NSString *)stringWithPropertyList:(id)plist
{
    return [[NSData dataWithPropertyList:plist] toUTF8String];
}

// 将 plist 对象转为字符串
+ (NSString *)stringWithPropertyList:(id)plist
                              format:(NSPropertyListFormat)format
                               error:(NSError * _Nullable __autoreleasing *)error
{
    return [[NSData dataWithPropertyList:plist format:format error:error] toUTF8String];
}

// 将字符串转为 plist 对象
- (id)toPropertyList
{
    return [[self toUTF8Data] toPropertyList];
}

// 将字符串转为 plist 对象
- (id)toPropertyListWithOptions:(NSPropertyListReadOptions)opt
                          error:(NSError * _Nullable __autoreleasing *)error
{
    return [[self toUTF8Data] toPropertyListWithOptions:opt error:error];
}

// 解码 Base-64 字符串
+ (instancetype)stringWithBase64EncodedString:(NSString *)base64String
{
    return [[NSData dataWithBase64EncodedString:base64String] toUTF8String];
}

// 解码 Base-64 字符串
+ (instancetype)stringWithBase64EncodedString:(NSString *)base64String
                                      options:(NSDataBase64DecodingOptions)options
{
    return [[[NSData alloc] initWithBase64EncodedString:base64String options:options] toUTF8String];
}

// 将字符串进行 Base-64 编码
- (NSString *)base64EncodedString
{
    return [[self toUTF8Data] base64EncodedString];
}

// 将字符串进行 Base-64 编码
- (NSString *)base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)options
{
    return [[self toUTF8Data] base64EncodedStringWithOptions:options];
}

// 将字符串进行编码令其符合URL规范
- (NSString *)stringByURLQueryEncode
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

// 去除编码格式
- (NSString *)stringByURLQueryDecode
{
    return [self stringByRemovingPercentEncoding];
}

// 将HTML格式字符串进行转换
- (NSString *)stringByEscapingHTML
{
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result.copy;
}


#pragma mark - 正则表达式

// 通过正则表达式替换部分字符串
- (NSString *)stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement
                               error:(NSError * _Nullable __autoreleasing *)error
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:options error:error];
    if (error != nil) return self;
    
    NSRange range = {0, self.length};
    return [regular stringByReplacingMatchesInString:self options:0 range:range withTemplate:replacement];
}

// 使用正则表达式验证字符串是否匹配
- (BOOL)validateByRegex:(NSString *)regex {
    NSPredicate *regular = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regular evaluateWithObject:self];
}

// 身份证验证（15位或18位）
- (BOOL)validIdentificationCard {
    BOOL regularPass = [self validateByRegex:@"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"];
    
    // 如果身份证长度为15位或者不通过验证直接返回结果
    if ((self.length < 18) || (regularPass == NO)) {
        return regularPass;
    }
    
    // 对18位身份证号码的最后一位进行校验
    int idCardWi[17] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};  // 前17位加权因子
    
    // 计算前17位各自乘以加权因子后的总和
    int idCardWiSum = 0;
    for (int i = 0; i < 17; i++) {
        NSRange range = {i, 1};
        idCardWiSum += [self substringWithRange:range].integerValue * idCardWi[i];
    }
    
    int idCardMod = idCardWiSum % 11; //计算出校验码所在数组的位置
    NSString *idCardLast = [self substringFromIndex:17]; //得到最后一位身份证号码
    NSArray *idCardY = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];  // 除以11后可能产生的11位余数、验证码
    
    // 如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if (idCardMod == 2) {
        return ([idCardLast isEqualToString:@"X"] || [idCardLast isEqualToString:@"x"]);
    }
    
    // 用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
    return [idCardLast isEqualToString:idCardY[idCardMod]];
}

//  中国手机号码验证（13\14\15\17\18开头的11位纯数字，也可以包含+86）
- (BOOL)validChineseMobilePhoneNumber {
    return [self validateByRegex:@"^(\\+?\\d{2}-?)?(1[34578])\\d{9}$"];
}

// 中国移动手机号码验证
- (BOOL)validChinaMobilePhoneNumber {
    /**
     中国移动：China Mobile
     2G号段（GSM网络）134x（0-8）、135、136、137、138、139、150、151、152、158、159、182、183、184
     3G号段（TD-SCDMA网络）157、187、188
     3G上网卡 147
     4G号段 178
     */
    return [self validateByRegex:@"^1(34[0-8]|(3[5-9]|5[0127-9]|8[23478]|47|78)\\d)\\d{7}$"];
}

// 中国联通手机号码验证
- (BOOL)validChinaUnicomPhoneNumber {
    /**
     中国联通：China Unicom
     2G号段（GSM网络）130、131、132、155、156
     3G上网卡145
     3G号段（WCDMA网络）185、186
     4G号段 176、185
     */
    return [self validateByRegex:@"^1(3[0-2]|5[256]|8[56]|45|76)\\d{8}$"];
}

// 中国电信手机号码验证
- (BOOL)validChinaTelecomPhoneNumber {
    /**
     * 中国电信：China Telecom
     * 2G/3G号段（CDMA2000网络）133、153、180、181、189
     * 4G号段 177
     */
    return [self validateByRegex:@"^1((33|53|8[019]|77)[0-9]|349)\\d{7}$"];
}

// 中国座机电话号码验证（010-12345678 或 0123-1234567）
- (BOOL)validChinesePhoneNumber {
    return [self validateByRegex:@"^\\d{3}-\\d{8}|\\d{4}-\\d{7}$"];
}

// 电子邮箱验证
- (BOOL)validEmail {
    return [self validateByRegex:@"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"];
}

// 中国邮政编码验证
- (BOOL)validPostcode {
    return [self validateByRegex:@"^[1-9]\\d{5}(?!\\d)$"];
}

// QQ号验证（不以0开头的5-12位数字）
- (BOOL)validQQ {
    return [self validateByRegex:@"^[1-9]\\d{4,11}$"];
}

// 账户验证（5-20位 字母、数字或下划线或.）
- (BOOL)validAccount {
    return [self validateByRegex:@"^[A-Za-z0-9_.]{5,20}+$"];
}

// 密码验证（6-18位 大小写字母、数字、以及特殊字符: 空格!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~）
- (BOOL)validPassword {
    return [self validateByRegex:@"^[\\u0020-\\u007f & ^]{6,18}$"];
}

// IP地址验证（IPv4）
- (BOOL)validIPv4 {
    return [self validateByRegex:@"^((([1-9]\\d?)|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))\\.){3}(([1-9]\\d?)|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))$"];
}

// 判断是否是空白行
- (BOOL)isAfterSpace {
    return [self validateByRegex:@"\\n\\s*\\r"];
}


#pragma mark - 数字属性

- (char)charValue {
    return self.numberValue.charValue;
}

- (unsigned char) unsignedCharValue {
    return self.numberValue.unsignedCharValue;
}

- (short) shortValue {
    return self.numberValue.shortValue;
}

- (unsigned short) unsignedShortValue {
    return self.numberValue.unsignedShortValue;
}

- (unsigned int) unsignedIntValue {
    return self.numberValue.unsignedIntValue;
}

- (long) longValue {
    return self.numberValue.longValue;
}

- (unsigned long) unsignedLongValue {
    return self.numberValue.unsignedLongValue;
}

- (unsigned long long) unsignedLongLongValue {
    return self.numberValue.unsignedLongLongValue;
}

- (NSUInteger) unsignedIntegerValue {
    return self.numberValue.unsignedIntegerValue;
}


@end
