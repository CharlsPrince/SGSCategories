/*!
 *  @header NSArray+SGS.h
 *
 *  @abstract NSArray 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @abstract NSArray 扩展
 */
@interface NSArray<ObjectType> (SGS)

#pragma mark - 通用
///-----------------------------------------------------------------------------
/// @name 通用
///-----------------------------------------------------------------------------

/*!
 *  @abstract 从 main bundle 中读取不可变的数组
 *
 *  @param filename 文件名
 *  @param ext      扩展名
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithContentsOfMainBundleFile:(NSString *)filename
                                                           fileType:(nullable NSString *)ext;

/*!
 *  @abstract 从指定文件中读取不可变的数组
 *
 *  @param path       文件名或相对路径
 *  @param directory  文件夹，例如：NSDocumentDirectory
 *  @param domainMask 域，例如：NSUserDomainMask
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithContentsOfFile:(NSString *)path
                                      relativeToDirectory:(NSSearchPathDirectory)directory
                                                 inDomain:(NSSearchPathDomainMask)domainMask;

/*!
 *  @abstract 将数组写入到指定路径中
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
 *  @abstract 获取数组中的随机元素
 *
 *  @return 数组中随机元素，当数组的元素个数为 0 时返回 nil
 */
- (nullable id)randomObject;


/*!
 *  @abstract 如果下标不越界，那么返回对应的对象；如果下标越界，返回空对象
 *
 *  @param index 元素下标
 *
 *  @return object or nil
 */
- (nullable id)objectOrNilAtIndex:(NSUInteger)index;


#pragma mark - 编码转换
///-----------------------------------------------------------------------------
/// @name 编码转换
///-----------------------------------------------------------------------------

/*!
 *  @abstract 将 JSON 数据转为不可变的数组
 *
 *  @param data JSON 数据
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithJSONData:(NSData *)data;

/*!
 *  @abstract 将 JSON 数据转为不可变的数组
 *
 *  @param data  JSON 数据
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithJSONData:(NSData *)data error:(NSError **)error;

/*!
 *  @abstract 将数组转为 JSON 数据
 *
 *  @discussion NSJSONWritingOptions 为 kNilOptions
 *
 *  @return NSData or nil
 */
- (nullable NSData *)toJSONData;

/*!
 *  @abstract 将数组转为 JSON 数据
 *
 *  @param opt   JSON 转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSData or nil
 */
- (nullable NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opt error:(NSError **)error;

/*!
 *  @abstract 将 JSON 字符串转为不可变的数组
 *
 *  @param string JSON 字符串
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithJSONString:(NSString *)string;

/*!
 *  @abstract 将 JSON 字符串转为不可变的数组
 *
 *  @param string JSON 字符串
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithJSONString:(NSString *)string error:(NSError **)error;

/*!
 *  @abstract 将数组转为 JSON 字符串
 *
 *  @discussion NSJSONWritingOptions 为 kNilOptions
 *
 *  @return NSString or nil
 */
- (nullable NSString *)toJSONString;

/*!
 *  @abstract 将数组转为 JSON 字符串
 *
 *  @param opt   JSON 转换选项
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSString or nil
 */
- (nullable NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opt error:(NSError **)error;

/*!
 *  @abstract 将 plist 数据转为不可变的数组
 *
 *  @param data plist 数据
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithPlistData:(NSData *)data;

/*!
 *  @abstract 将 plist 数据转为不可变的数组
 *
 *  @param data  plist 数据
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithPlistData:(NSData *)data error:(NSError **)error;

/*!
 *  @abstract 将数组转为 plist 数据
 *
 *  @discussion 转换格式为 XML 形式
 *
 *  @return NSData or nil
 */
- (nullable NSData *)toPlistData;

/*!
 *  @abstract 将数组转为 plist 数据
 *
 *  @param format 转换格式
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSData or nil
 */
- (nullable NSData *)toPlistDataWithFormat:(NSPropertyListFormat)format error:(NSError **)error;

/*!
 *  @abstract 将 plist 字符串转为不可变的数组
 *
 *  @param string plist 字符串
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithPlistString:(NSString *)string;

/*!
 *  @abstract 将 plist 字符串转为不可变的数组
 *
 *  @param string plist 字符串
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSArray or nil
 */
+ (nullable NSArray<ObjectType> *)arrayWithPlistString:(NSString *)string error:(NSError **)error;

/*!
 *  @abstract 将数组转为 plist 字符串
 *
 *  @discussion 转换格式为 XML 形式
 *
 *  @return NSString or nil
 */
- (nullable NSString *)toPlistString;

/*!
 *  @abstract 将数组转为 plist 字符串
 *
 *  @param format 转换格式
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSString or nil
 */
- (nullable NSString *)toPlistStringWithFormat:(NSPropertyListFormat)format error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
