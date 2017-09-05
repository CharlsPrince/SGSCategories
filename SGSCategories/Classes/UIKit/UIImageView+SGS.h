/*!
 *  @header UIImageView+SGS.h
 *
 *  @abstract UIImageView 扩展
 *
 *  @author Created by Lee on 16/4/24.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief UIImageView 扩展
 */
@interface UIImageView (SGS)

/*!
 *  @brief 为UIImageView设置图片，并且自动将图片切为圆角
 *
 *  @param image  图片
 *  @param radius 圆角角度
 */
- (void)setRoundRectImage:(UIImage *)image withCornerRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END