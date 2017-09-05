/*!
 *  @header NSTimer+SGS.m
 *
 *  @abstract NSTimer 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSTimer+SGS.h"

@implementation NSTimer (SGS)

// 实例化NSTimer，并自动加入当前 run loop 中执行
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(TimerHandler)block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(p_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

// 实例化NSTimer
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval block:(TimerHandler)block repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:interval target:self selector:@selector(p_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

// 私有方法，执行block内容
+ (void)p_blockInvoke:(nullable NSTimer *)timer {
    TimerHandler block = timer.userInfo;
    if (block) {
        block();
    }
}
@end
