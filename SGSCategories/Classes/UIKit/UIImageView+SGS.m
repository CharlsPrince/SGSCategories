/*!
 *  @header UIImageView+SGS.m
 *
 *  @author Created by Lee on 16/4/24.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "UIImageView+SGS.h"
#import "UIImage+SGS.h"

@implementation UIImageView (SGS)

// 为UIImageView添加圆角图片
- (void)setRoundRectImage:(UIImage *)image withCornerRadius:(CGFloat)radius {
    UIImage *roundRectImage = [image roundRectWithCornerRadius:radius];
    self.image = (roundRectImage) ? roundRectImage : image;
}

@end
