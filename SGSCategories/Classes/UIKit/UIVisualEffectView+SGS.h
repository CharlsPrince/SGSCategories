/*!
 *  @header UIVisualEffectView+SGS.h
 *
 *  @abstract UIVisualEffectView 扩展
 *
 *  @author Created by Lee on 16/9/2.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 模糊视图快捷获取方法扩展
 */
@interface UIVisualEffectView (SGS)

/*!
 *  @brief 实例化一个模糊效果的视图
 *
 *  @param frame       视图大小
 *  @param effectStyle 模糊效果:
 *              - UIBlurEffectStyleExtraLight,
 *              - UIBlurEffectStyleLight,
 *              - UIBlurEffectStyleDark
 *
 *  @return UIVisualEffectView
 */
+ (instancetype)blurViewWithFrame:(CGRect)frame
                      effectStyle:(UIBlurEffectStyle)effectStyle;

/*!
 *  @brief 实例化一个模糊效果的视图，并且其contentView拥有颜色渐变效果
 *
 *  @param frame             视图大小
 *  @param effectStyle       模糊效果
 *  @param vibrancyFrame 渐变颜色范围
 *
 *  @return UIVisualEffectView
 */
+ (instancetype)blurViewWithFrame:(CGRect)frame
                      effectStyle:(UIBlurEffectStyle)effectStyle
                    vibrancyFrame:(CGRect)vibrancyFrame;

@end

NS_ASSUME_NONNULL_END
