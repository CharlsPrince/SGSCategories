/*!
 *  @header UIColor+SGS.h
 *
 *  @abstract UIColor 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 颜色扩展
 */
@interface UIColor (SGS)

/*!
 *  @brief RGB颜色Red通道数值（0.0~1.0）
 */
@property (nonatomic, assign, readonly) CGFloat redComponent;

/*!
 *  @brief RGB颜色Green通道数值（0.0~1.0）
 */
@property (nonatomic, assign, readonly) CGFloat greenComponent;

/*!
 *  @brief RGB颜色Blue通道数值（0.0~1.0）
 */
@property (nonatomic, assign, readonly) CGFloat blueComponent;

/*!
 *  @brief HSB颜色Hue通道数值（0.0~1.0)
 */
@property (nonatomic, assign, readonly) CGFloat hueComponent;

/*!
 *  @brief HSB颜色saturation通道数值（0.0~1.0)
 */
@property (nonatomic, assign, readonly) CGFloat saturationComponent;

/*!
 *  @brief HSB颜色brightness通道数值（0.0~1.0)
 */
@property (nonatomic, assign, readonly) CGFloat brightnessComponent;

/*!
 *  @brief Alpha通道数值（0.0~1.0）
 */
@property (nonatomic, assign, readonly) CGFloat alphaComponent;

/*!
 *  @brief 色域
 */
@property (nonatomic, assign, readonly) CGColorSpaceModel colorSpaceModel;

/*!
 *  @brief 十六进制RGB数值，如：0xff7f00
 *
 *  @return 十六进制RGB数值
 */
- (uint32_t)rgbValue;

/*!
 *  @brief 十六进制RGBA数值，如：0xff7f00ff
 *
 *  @return 十六进制RGBA数值
 */
- (uint32_t)rgbaValue;

/*!
 *  @brief 获取十六进制RGB字符串，如：orangeColor -> #ff7f00
 *
 *  @return 十六进制RGB字符串 or nil
 */
- (nullable NSString *)rgbHexString;

/*!
 *  @brief 获取十六进制RGBA字符串，如：orangeColor -> #ff7f00ff
 *
 *  @return 十六进制RGBA字符串 or nil
 */
- (nullable NSString *)rgbHexStringWithAlpha;


/*!
 *  @brief 通过十六进制RGB数值实例化 UIColor
 *
 *  @param rgbValue 十六进制RGB数值, 如:0xff7f00 -> orangeColor
 *
 *  @return UIColor
 */
+ (instancetype)colorWithHexRGBValue:(uint32_t)rgbValue;

/*!
 *  @brief 通过十六进制RGB数值以及alpha实例化 UIColor
 *
 *  @discussion 如:0xff7f00 + 1.0 -> orangeColor
 *
 *  @param rgbValue 十六进制RGB数值
 *  @param alpha    alpha
 *
 *  @return UIColor
 */
+ (instancetype)colorWithHexRGBValue:(uint32_t)rgbValue andAlpha:(CGFloat)alpha;

/*!
 *  @brief 通过十六进制RGBA数值实例化 UIColor
 *
 *  @param rgbaValue 十六进制RGB数值, 如:ff7f00ff -> orangeColor
 *
 *  @return UIColor
 */
+ (instancetype)colorWithHexRGBAValue:(uint32_t)rgbaValue;



/*!
 *  @brief 通过输入UInt8的RGB以及alpha值实例化 UIColor
 *
 *  @param red   Red（0~255）
 *  @param greed Green（0~255）
 *  @param blue  Blue（0~255）
 *  @param alpha alpha（0.0~1.0）
 *
 *  @return UIColor
 */
+ (instancetype)colorWithRedUInt8Value:(uint8_t)red greedUInt8Value:(uint8_t)greed blueUInt8Value:(uint8_t)blue alpha:(CGFloat)alpha;


/*!
 *  @brief 通过十六进制数值字符串实例化 UIColor
 *
 *  @discussion 支持的格式：
 *      - 0xRRGGBB
 *      - 0xRRGGBBAA（R：red，G：green，B：blue，A：alpha）
 *
 *  @param hexString 十六进制数值字符串，如: #ff7f00 或 #FF7F00FF -> orangeColor
 *
 *  @return UIColor or nil
 */
+ (nullable instancetype)colorWithHexString:(NSString *)hexString;


/*!
 *  @brief 根据随机 RGB 值实例化 UIColor
 *
 *  @return UIColor
 */
+ (instancetype)colorWithRandomRGB;

@end

NS_ASSUME_NONNULL_END