/*!
 *  @header NSDictionary+SGS.h
 *
 *  @abstract NSDictionary 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief NSDictionary 扩展
 */
@interface NSDictionary<KeyType, ObjectType> (SGS)

#pragma mark - 通用
///-----------------------------------------------------------------------------
/// @name 通用
///-----------------------------------------------------------------------------

/*!
 *  @brief 从 main bundle 中读取不可变的字典
 *
 *  @param filename 文件名
 *  @param ext      扩展名
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<KeyType, ObjectType> *)dictionaryWithContentsOfMainBundleFile:(NSString *)filename
                                                                              fileType:(nullable NSString *)ext;

/*!
 *  @brief 从指定文件中读取不可变的字典
 *
 *  @param path       文件名或相对路径
 *  @param directory  文件夹，例如：NSDocumentDirectory
 *  @param domainMask 域，例如：NSUserDomainMask
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<KeyType, ObjectType> *)dictionaryWithContentsOfFile:(NSString *)path
                                                         relativeToDirectory:(NSSearchPathDirectory)directory
                                                                    inDomain:(NSSearchPathDomainMask)domainMask;

/*!
 *  @brief 将字典写入到指定路径中
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
 *  @brief 返回排序后的所有key
 *
 *  @return key 数组
 */
- (NSArray *)allKeysSorted;

/*!
 *  @brief 返回按照key排序的所有值
 *
 *  @return 按照 key 排序后的 value 数组
 */
- (NSArray *)allValuesSortedByKeys;

/*!
 *  @brief 判断字典是否包含key对应的对象
 *
 *  @param key 查询键
 *
 *  @return 如果字典包含该key对应的对象将返回'YES'，否则返回'NO'
 */
- (BOOL)containsObjectForKey:(id)key;

/*!
 *  @brief 获取一组key对应的对象
 *
 *  @param keys 查询键数组
 *
 *  @return 返回key对应的所有对象，当keys数组里的任何一个key都不匹配的时候将返回'nil'
 */
- (nullable NSDictionary<KeyType, ObjectType> *)entriesForKeys:(NSArray *)keys;


#pragma mark - 编码转换
///-----------------------------------------------------------------------------
/// @name 编码转换
///-----------------------------------------------------------------------------

/*!
 *  @brief 将 JSON 数据转为不可变的字典
 *
 *  @param data JSON 数据
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<NSString *, ObjectType> *)dictionaryWithJSONData:(NSData *)data;

/*!
 *  @brief 将 JSON 数据转为不可变的字典
 *
 *  @param data  JSON 数据
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<NSString *, ObjectType> *)dictionaryWithJSONData:(NSData *)data error:(NSError **)error;

/*!
 *  @brief 将字典转为 JSON 数据
 *
 *  @discussion NSJSONWritingOptions 为 kNilOptions
 *
 *  @return NSData or nil
 */
- (nullable NSData *)toJSONData;

/*!
 *  @brief 将字典转为 JSON 数据
 *
 *  @param opt   JSON 转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSData or nil
 */
- (nullable NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opt error:(NSError **)error;

/*!
 *  @brief 将 JSON 字符串转为不可变的字典
 *
 *  @param string JSON 字符串
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<NSString *, ObjectType> *)dictionaryWithJSONString:(NSString *)string;

/*!
 *  @brief 将 JSON 字符串转为不可变的字典
 *
 *  @param string JSON 字符串
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<NSString *, ObjectType> *)dictionaryWithJSONString:(NSString *)string error:(NSError **)error;

/*!
 *  @brief 将字典转为 JSON 字符串
 *
 *  @discussion NSJSONWritingOptions 为 kNilOptions
 *
 *  @return NSString or nil
 */
- (nullable NSString *)toJSONString;

/*!
 *  @brief 将字典转为 JSON 字符串
 *
 *  @param opt   JSON 转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSString or nil
 */
- (nullable NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opt error:(NSError **)error;

/*!
 *  @brief 将 plist 数据转为不可变的字典
 *
 *  @param data plist 数据
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<NSString *, ObjectType> *)dictionaryWithPlistData:(NSData *)data;

/*!
 *  @brief 将 plist 数据转为不可变的字典
 *
 *  @param data  plist 数据
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<NSString *, ObjectType> *)dictionaryWithPlistData:(NSData *)data error:(NSError **)error;

/*!
 *  @brief 将字典转为 plist 数据
 *
 *  @discussion 转换格式为 XML 形式
 *
 *  @return NSData or nil
 */
- (nullable NSData *)toPlistData;

/*!
 *  @brief 将字典转为 plist 数据
 *
 *  @param format 转换格式
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSData or nil
 */
- (nullable NSData *)toPlistDataWithFormat:(NSPropertyListFormat)format error:(NSError **)error;

/*!
 *  @brief 将 plist 字符串转为不可变的字典
 *
 *  @param string plist 字符串
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<NSString *, ObjectType> *)dictionaryWithPlistString:(NSString *)string;

/*!
 *  @brief 将 plist 字符串转为不可变的字典
 *
 *  @param string plist 字符串
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSDictionary or nil
 */
+ (nullable NSDictionary<NSString *, ObjectType> *)dictionaryWithPlistString:(NSString *)string error:(NSError **)error;

/*!
 *  @brief 将字典转为 plist 字符串
 *
 *  @discussion 转换格式为 XML 形式
 *
 *  @return NSString or nil
 */
- (nullable NSString *)toPlistString;

/*!
 *  @brief 将字典转为 plist 字符串
 *
 *  @param format 转换格式
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSString or nil
 */
- (nullable NSString *)toPlistStringWithFormat:(NSPropertyListFormat)format error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
