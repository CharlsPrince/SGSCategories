/*!
 *  @header NSNotificationCenter+SGS.h
 *
 *  @abstract NSNotificationCenter 扩展
 *
 *  @author Created by Lee on 16/4/24.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 在主线程中发送通知的扩展方法
 */
@interface NSNotificationCenter (SGS)

/*!
 *  @brief 在主线程中发送通知
 *
 *  @param notification 通知
 */
- (void)postNotificationOnMainThread:(NSNotification *)notification;

/*!
 *  @brief 在主线程中发送通知，并且根据需要判断是否等待当前线程结束再发送
 *
 *  @param notification 通知
 *  @param wait         是否等待当前线程结束
 *  @discussion  如果 waitUntilDone 为 YES，当前线程结束后会阻塞主线程，然后发送通知
 */
- (void)postNotificationOnMainThread:(NSNotification *)notification waitUntilDone:(BOOL)wait;

/*!
 *  @brief 根据通知的名称和发送对象，在主线程中发送通知
 *
 *  @param name   通知名称
 *  @param object 发送对象
 */
- (void)postNotificationNameOnMainThread:(NSString *)name object:(nullable id)object;

/*!
 *  @brief 根据通知的名称、发送对象以及附加信息，在主线程中发送通知
 *
 *  @param name     通知名称
 *  @param object   发送对象
 *  @param userInfo 附加信息
 */
- (void)postNotificationNameOnMainThread:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

/*!
 *  @brief 根据通知名称、发送对象以及附加信息，在主线程中发送通知，并且根据需要判断是否等待当前线程结束再发送
 *
 *  @discussion  如果 waitUntilDone 为 YES，当前线程结束后会阻塞主线程，然后发送通知
 *
 *  @param name     通知名称
 *  @param object   发送对象
 *  @param userInfo 附加信息
 *  @param wait     是否等待当前线程结束
 */
- (void)postNotificationNameOnMainThread:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo waitUntilDone:(BOOL)wait;

@end

NS_ASSUME_NONNULL_END