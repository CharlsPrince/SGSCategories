/*!
 *  @header UIView+SGS.h
 *
 *  @abstract UIView 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief UIView 扩展
 */
@interface UIView (SGS)

@property (nonatomic, assign) CGFloat left;    //! left    == self.frame.origin.x.
@property (nonatomic, assign) CGFloat top;     //! top     == self.frame.origin.y
@property (nonatomic, assign) CGFloat right;   //! right   == self.frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat bottom;  //! bottom  == self.frame.origin.y + frame.size.height
@property (nonatomic, assign) CGFloat width;   //! width   == self.frame.size.width.
@property (nonatomic, assign) CGFloat height;  //! height  == self.frame.size.height.
@property (nonatomic, assign) CGFloat centerX; //! centerX == self.center.x
@property (nonatomic, assign) CGFloat centerY; //! centerY == self. center.y
@property (nonatomic, assign) CGPoint origin;  //! origin  == self.frame.origin.
@property (nonatomic, assign) CGSize  size;    //! size    == self.frame.size.


/**
 *  @brief 将当前视图截取为图片
 *
 *  @return 截图 or nil
 */
- (nullable UIImage *)snapshotImage;

/**
 *  @brief 截图保存为PDF
 *
 *  @return PDF数据 or nil
 */
- (nullable NSData *)snapshotPDF;


@end

NS_ASSUME_NONNULL_END