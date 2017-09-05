/*!
 *  @header UIVisualEffectView+SGS.m
 *
 *  @author Created by Lee on 16/9/2.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "UIVisualEffectView+SGS.h"

@implementation UIVisualEffectView (SGS)

// 实例化一个模糊效果的视图
+ (instancetype)blurViewWithFrame:(CGRect)frame effectStyle:(UIBlurEffectStyle)effectStyle {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:effectStyle];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.frame = frame;
    
    return blurView;
}

// 实例化一个模糊效果的视图，并且其contentView拥有颜色渐变效果
+ (instancetype)blurViewWithFrame:(CGRect)frame effectStyle:(UIBlurEffectStyle)effectStyle vibrancyFrame:(CGRect)vibrancyFrame {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:effectStyle];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.frame = frame;
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    vibrancyView.frame = vibrancyFrame;
    [blurView.contentView addSubview:vibrancyView];
    
    return blurView;
}

@end
