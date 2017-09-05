/*!
 *  @header NSUserDefaults+SGS.h
 *
 *  @abstract NSUserDefaults 扩展
 *
 *  @author Created by Lee on 16/9/2.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 使用 [NSUserDefaults standardUserDefaults] 提供快捷扩展方法
 */
@interface NSUserDefaults (SGS)

#pragma mark - set
///-----------------------------------------------------------------------------
/// @name set
///-----------------------------------------------------------------------------

/*!
 *  @brief 设置对象
 *
 *  @param value       对象值
 *  @param defaultName 键
 */
+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName;

/*!
 *  @brief 设置整型值，文件内部将以 NSNumber 的形式存储
 *
 *  @param value       对象值
 *  @param defaultName 键
 */
+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;

/*!
 *  @brief 设置浮点数，文件内部将以 NSNumber 的形式存储
 *
 *  @param value       对象值
 *  @param defaultName 键
 */
+ (void)setFloat:(float)value forKey:(NSString *)defaultName;

/*!
 *  @brief 设置双精度浮点数，文件内部将以 NSNumber 的形式存储
 *
 *  @param value       对象值
 *  @param defaultName 键
 */
+ (void)setDouble:(double)value forKey:(NSString *)defaultName;

/*!
 *  @brief 设置布尔值，文件内部将以 NSNumber 的形式存储
 *
 *  @param value       对象值
 *  @param defaultName 键
 */
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

/*!
 *  @brief 设置 URL，文件内部将归档为 NSData 存储
 *
 *  @param url       对象值
 *  @param defaultName 键
 */
+ (void)setURL:(nullable NSURL *)url forKey:(NSString *)defaultName;

/*!
 *  @brief 删除对象，相当于 [... setObject:nil forKey:defaultName]
 */
+ (void)removeObjectForKey:(NSString *)defaultName;


#pragma mark - get
///-----------------------------------------------------------------------------
/// @name get
///-----------------------------------------------------------------------------

/*!
 *  @brief 获取值
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值返回 nil
 */
+ (nullable id)objectForKey:(NSString *)defaultName;

/*!
 *  @brief 获取字符串，如果是 NSNumber 类型也可以转为字符串
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者不是字符串也不是 NSNumber 类型则返回 nil
 */
+ (nullable NSString *)stringForKey:(NSString *)defaultName;

/*!
 *  @brief 获取数组
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者类型不匹配返回 nil
 */
+ (nullable NSArray *)arrayForKey:(NSString *)defaultName;

/*!
 *  @brief 获取字典
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者类型不匹配返回 nil
 */
+ (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)defaultName;

/*!
 *  @brief 获取NSData
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者类型不匹配返回 nil
 */
+ (nullable NSData *)dataForKey:(NSString *)defaultName;

/*!
 *  @brief 获取字符串数组
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者类型不匹配返回 nil
 */
+ (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *)defaultName;

/*!
 *  @brief 获取整型值
 *
 *  @discussion 如果找到对应的值将尝试以下转换：
 *      - NSNumber：返回 integerValue 属性值
 *      - NSString：返回 integerValue 属性值
 *      - BOOL：    YES 返回 1，NO 返回 0
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者类型不匹配返回 0
 */
+ (NSInteger)integerForKey:(NSString *)defaultName;

/*!
 *  @brief 获取浮点数
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者类型不匹配返回 0
 */
+ (float)floatForKey:(NSString *)defaultName;

/*!
 *  @brief 获取双精度浮点数
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者类型不匹配返回 0
 */
+ (double)doubleForKey:(NSString *)defaultName;

/*!
 *  @brief 获取布尔值
 *
 *  @discussion 如果找到对应的值将尝试以下转换：
 *      - NSNumber：0 返回 NO，其他值返回 YES
 *      - NSString："YES" 或者 "1" 返回 YES；"NO" 、 "0" 或者其他值返回 NO
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者类型不匹配返回 NO
 */
+ (BOOL)boolForKey:(NSString *)defaultName;

/*!
 *  @brief 获取 URL，将 +setURL:forKey: 设置的 URL NSData 解档
 *
 *  @discussion 如果找到的值类型是字符串，则将尝试转换为 file 类型的 URL
 *
 *  @param defaultName 键
 *
 *  @return 如果找不到对应的值，或者类型不匹配返回 nil
 */
+ (nullable NSURL *)URLForKey:(NSString *)defaultName;

@end

NS_ASSUME_NONNULL_END
