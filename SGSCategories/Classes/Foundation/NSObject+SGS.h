/*!
 *  @header NSObject+SGS.h
 *
 *  @abstract NSObject 扩展
 *
 *  @author Created by Lee on 16/9/14.
 *  
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief runtime, KVO 等扩展
 */
@interface NSObject (SGS)

#pragma mark - 动态关联属性
///-----------------------------------------------------------------------------
/// @name 动态关联属性
///-----------------------------------------------------------------------------

/*!
 *  @brief 动态添加属性（OBJC_ASSOCIATION_RETAIN_NONATOMIC）
 *
 *  @param value 属性值
 *  @param key   属性关联key
 */
- (void)setAssociatedValue:(nullable id)value withKey:(void *)key;

/*!
 *  @brief 动态添加属性（OBJC_ASSOCIATION_COPY_NONATOMIC）
 *
 *  @param value 属性值
 *  @param key   属性关联key
 */
- (void)setAssociatedCopyValue:(nullable id)value withKey:(void *)key;

/*!
 *  @brief 动态添加属性（OBJC_ASSOCIATION_ASSIGN）
 *
 *  @param value 属性值
 *  @param key   属性关联key
 */
- (void)setAssociatedAssignValue:(nullable id)value withKey:(void *)key;

/*!
 *  @brief 动态获取属性
 *
 *  @param key 属性关联key
 *
 *  @return value
 */
- (nullable id)getAssociatedValueForKey:(void *)key;

/*!
 *  @brief 移除所有动态关联的属性
 */
- (void)removeAssociatedValues;

#pragma mark - KVO
///-----------------------------------------------------------------------------
/// @name KVO
///-----------------------------------------------------------------------------

/*!
 *  @brief 以 block 的形式接收被观察者的属性变化信息
 *
 *  @discussion 该 block 同观察者一样会被持有，需要通过 `removeObserverBlocksForKeyPath:`
 *      或 `removeObserverBlocks` 来移除观察者 block
 *
 *  @param keyPath 被观察者的键路径
 *  @param block   block
 */
- (void)addObserverForKeyPath:(NSString*)keyPath
                        block:(void (^)(id _Nonnull obj, id _Nonnull oldVal, id _Nonnull newVal))block;

/*!
 *  @brief 停止观察并移除观察者 block
 *
 *  @param keyPath 被观察者的键路径
 */
- (void)removeObserverBlocksForKeyPath:(NSString*)keyPath;

/*!
 *  @brief 移除所有观察者 block
 */
- (void)removeObserverBlocks;

#pragma mark - 其他
///-----------------------------------------------------------------------------
/// @name 其他
///-----------------------------------------------------------------------------

/*!
 *  @brief 类名字符串
 *
 *  @return 类名字符串
 */
+ (NSString *)className;

/*!
 *  @brief 类名字符串
 *
 *  @return 类名字符串
 */
- (NSString *)className;

@end

NS_ASSUME_NONNULL_END
