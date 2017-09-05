/*!
 *  @header NSMutableArray+SGS.h
 *
 *  @abstract NSMutableArray 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @abstract NSMutableArray 扩展
 */
@interface NSMutableArray<ObjectType> (SGS)

#pragma mark - 通用
///-----------------------------------------------------------------------------
/// @name 通用
///-----------------------------------------------------------------------------

/*!
 *  @abstract 从 main bundle 中读取可变的数组
 *
 *  @param filename 文件名
 *  @param ext      扩展名
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithContentsOfMainBundleFile:(NSString *)filename
                                                                  fileType:(nullable NSString *)ext;

/*!
 *  @abstract 从指定文件中读取可变的数组
 *
 *  @param path       文件名或相对路径
 *  @param directory  文件夹，例如：NSDocumentDirectory
 *  @param domainMask 域，例如：NSUserDomainMask
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithContentsOfFile:(NSString *)path
                                             relativeToDirectory:(NSSearchPathDirectory)directory
                                                        inDomain:(NSSearchPathDomainMask)domainMask;

/*!
 *  @abstract 弹出数组首元素
 *
 *  @return id or nil
 */
- (nullable id)popFirstObject;

/*!
 *  @abstract 弹出数组末尾元素
 *
 *  @return id or nil
 */
- (nullable id)popLastObject;

/*!
 *  @abstract 将元素添加到数组末尾
 *
 *  @param anObject 待添加的元素
 */
- (void)appendObject:(nullable ObjectType)anObject;

/*!
 *  @abstract 将元素添加到数组开头
 *
 *  @param anObject 待添加的元素
 */
- (void)prependObject:(nullable ObjectType)anObject;

/*!
 *  @abstract 将另一个数组中的元素添加到数组末尾
 *
 *  @param objects 待添加的元素数组，如果为空或元素个数为空则不进行任何操作
 */
- (void)appendObjects:(nullable NSArray<ObjectType> *)objects;

/*!
 *  @abstract 将另一个数组中的元素添加到数组开头
 *
 *  @param objects 待添加的元素数组，如果为空或元素个数为空则不进行任何操作
 */
- (void)prependObjects:(nullable NSArray<ObjectType> *)objects;

/*!
 *  @abstract 在指定的位置插入元素；如果元素为空或者下标越界，那么将不进行任何操作
 *
 *  @param anObject 待插入的元素
 *  @param index 待插入的位置
 */
- (void)safeInsertObject:(nullable ObjectType)anObject atIndex:(NSUInteger)index;

/*!
 *  @abstract 移除指定位置的元素；如果下标越界，那么将不进行任何操作
 *
 *  @param index 待删除元素的位置
 */
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

/*!
 *  @abstract 将指定位置的元素移动到数组开头；如果下标越界，那么将不进行任何操作
 *
 *  @param index 指定位置
 */
- (void)moveObjectToFirstFromIndex:(NSUInteger)index;

/*!
 *  @abstract 将指定位置的元素移动到数组末尾；如果下标越界，那么将不进行任何操作
 *
 *  @param index 指定位置
 */
- (void)moveObjectToLastFromIndex:(NSUInteger)index;

/*!
 *  @abstract 在指定位置插入数组元素
 *
 *  @param objects 数组元素
 *  @param index   需要插入的位置
 */
- (void)insertObjects:(NSArray<ObjectType> *)objects atIndex:(NSUInteger)index;

/*!
 *  @abstract 倒转数组
 */
- (void)reverse;

/*!
 *  @abstract 打乱数组顺序
 */
- (void)shuffle;


#pragma mark - 编码转换
///-----------------------------------------------------------------------------
/// @name 编码转换
///-----------------------------------------------------------------------------

/*!
 *  @abstract 将 JSON 数据转为可变的数组
 *
 *  @param data JSON 数据
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithJSONData:(NSData *)data;

/*!
 *  @abstract 将 JSON 数据转为可变的数组
 *
 *  @param data  JSON 数据
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithJSONData:(NSData *)data error:(NSError **)error;

/*!
 *  @abstract 将 JSON 字符串转为可变的数组
 *
 *  @param string JSON 字符串
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithJSONString:(NSString *)string;

/*!
 *  @abstract 将 JSON 字符串转为可变的数组
 *
 *  @param string JSON 字符串
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithJSONString:(NSString *)string error:(NSError **)error;

/*!
 *  @abstract 将 plist 数据转为可变的数组
 *
 *  @param data plist 数据
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithPlistData:(NSData *)data;

/*!
 *  @abstract 将 plist 数据转为可变的数组
 *
 *  @param data  plist 数据
 *  @param error 如果转换失败将会传递错误给该参数
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithPlistData:(NSData *)data error:(NSError **)error;

/*!
 *  @abstract 将 plist 字符串转为可变的数组
 *
 *  @param string plist 字符串
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithPlistString:(NSString *)string;

/*!
 *  @abstract 将 plist 字符串转为可变的数组
 *
 *  @param string plist 字符串
 *  @param error  如果转换失败将会传递错误给该参数
 *
 *  @return NSMutableArray or nil
 */
+ (nullable NSMutableArray<ObjectType> *)arrayWithPlistString:(NSString *)string error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
