/*!
 *  @header NSTimer+SGS.h
 *
 *  @abstract NSTimer 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TimerHandler)();

/*!
 *  @brief 增加 NSTimer 在 block 中执行代码的扩展方法
 */
@interface NSTimer (SGS)

/*!
 *  @brief 实例化NSTimer，并自动加入当前 run loop 中执行
 *
 *  @discussion 将需要执行的代码放入block中，Timer将在interval秒之后自动执行block
 *
 *      使用该方法创建的Timer不需要先使其失效再释放对象
 *
 *      参考：《Effective Objective-C 2.0（52 Specific Ways to Improve Your iOS and OS X Programs）》第52条
 *
 *  @param interval 执行间隔
 *  @param block    执行任务的block
 *  @param repeats  'YES'重复执行block中的内容，'NO'只执行一次block的内容
 *
 *  @return NSTimer
 */
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(TimerHandler)block repeats:(BOOL)repeats;

/*!
 *  @brief 实例化NSTimer
 *
 *  @discussion 将需要执行的代码放入block中，需要放入run loop中才会执行 [runloop addTimer:timer forMode:mode];
 *
 *      使用该方法创建的Timer不需要先使其失效再释放对象
 *
 *  @param interval 执行间隔
 *  @param block    执行任务的block
 *  @param repeats  'YES'重复执行block中的内容，'NO'只执行一次block的内容
 *
 *  @return NSTimer
 */
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval block:(TimerHandler)block repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
