/*!
 *  @header NSMutableDictionary+SGS.h
 *
 *  @abstract NSMutableDictionary 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief NSMutableDictionary 扩展
 */
@interface NSMutableDictionary<KeyType, ObjectType> (SGS)

#pragma mark - 通用
///-----------------------------------------------------------------------------
/// @name 通用
///-----------------------------------------------------------------------------

/*!
 *  @brief 从 main bundle 中读取可变的字典
 *
 *  @param filename 文件名
 *  @param ext      扩展名
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<KeyType, ObjectType> *)dictionaryWithContentsOfMainBundleFile:(NSString *)filename
                                                                                     fileType:(nullable NSString *)ext;

/*!
 *  @brief 从指定文件中读取可变的字典
 *
 *  @param path       文件名或相对路径
 *  @param directory  文件夹，例如：NSDocumentDirectory
 *  @param domainMask 域，例如：NSUserDomainMask
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<KeyType, ObjectType> *)dictionaryWithContentsOfFile:(NSString *)path
                                                                relativeToDirectory:(NSSearchPathDirectory)directory
                                                                           inDomain:(NSSearchPathDomainMask)domainMask;

/*!
 *  @brief 弹出key对应的对象
 *
 *  @param aKey 查询键
 *
 *  @return id or nil
 */
- (nullable id)popObjectForKey:(id)aKey;

/*!
 *  @brief 弹出keys对应的所有对象
 *
 *  @param keys 查询键数组
 *
 *  @return 返回keys对应的所有对象，当keys数组里的任何一个key都不匹配的时候将返回'nil'
 */
- (nullable NSDictionary *)popEntriesForKeys:(NSArray *)keys;


#pragma mark - 编码转换
///-----------------------------------------------------------------------------
/// @name 编码转换
///-----------------------------------------------------------------------------

/*!
 *  @brief 将 JSON 数据转为可变的字典
 *
 *  @param data JSON 数据
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<NSString *, ObjectType> *)dictionaryWithJSONData:(NSData *)data;

/*!
 *  @brief 将 JSON 数据转为可变的字典
 *
 *  @param data  JSON 数据
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<NSString *, ObjectType> *)dictionaryWithJSONData:(NSData *)data error:(NSError **)error;

/*!
 *  @brief 将 JSON 字符串转为可变的字典
 *
 *  @param string JSON 字符串
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<NSString *, ObjectType> *)dictionaryWithJSONString:(NSString *)string;

/*!
 *  @brief 将 JSON 字符串转为可变的字典
 *
 *  @param string JSON 字符串
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<NSString *, ObjectType> *)dictionaryWithJSONString:(NSString *)string error:(NSError **)error;

/*!
 *  @brief 将 plist 数据转为可变的字典
 *
 *  @param data plist 数据
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<NSString *, ObjectType> *)dictionaryWithPlistData:(NSData *)data;

/*!
 *  @brief 将 plist 数据转为可变的字典
 *
 *  @param data  plist 数据
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<NSString *, ObjectType> *)dictionaryWithPlistData:(NSData *)data error:(NSError **)error;

/*!
 *  @brief 将 plist 字符串转为可变的字典
 *
 *  @param string plist 字符串
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<NSString *, ObjectType> *)dictionaryWithPlistString:(NSString *)string;

/*!
 *  @brief 将 plist 字符串转为可变的字典
 *
 *  @param string plist 字符串
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable NSMutableDictionary<NSString *, ObjectType> *)dictionaryWithPlistString:(NSString *)string error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
