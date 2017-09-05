/*!
 *  @header UIImage+SGS.h
 *
 *  @abstract UIImage 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 图片扩展
 */
@interface UIImage (SGS)

/*!
 *  @brief 生成1像素的纯色图片
 *
 *  @param color 颜色
 *
 *  @return UIImage
 */
+ (instancetype)imageWithColor:(UIColor *)color;

/*!
 *  @brief 生成纯颜色的图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return UIImage, 如果尺寸的宽度或高度为0将返回 nil
 */
+ (nullable instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;

/*!
 *  @brief 截屏
 *
 *  @return UIImage
 */
+ (nullable instancetype)snapshotScreen;

/*!
 *  @brief 生成圆形图片
 *
 *  @return 圆形裁剪后的 UIImage
 */
- (nullable UIImage *)roundImage;

/*!
 *  @brief 生成圆角图片
 *
 *  @param radius 圆角角度
 *
 *  @return 圆角矩形裁剪后的 UIImage
 */
- (nullable UIImage *)roundRectWithCornerRadius:(CGFloat)radius;

/*!
 *  @brief 截取固定范围的图片
 *
 *  @param frame 截取范围
 *
 *  @return 圆角矩形裁剪后的 UIImage
 */
- (nullable UIImage *)cutoutWithFrame:(CGRect)frame;

/*!
 *  @brief 拉伸中心点
 *
 *  @return 拉伸后的 UIImage
 */
- (UIImage *)resizableImageWithCapInCenter;

/*!
 *  @brief 转换成新的尺寸（有拉伸）
 *
 *  @param newSize 新尺寸
 *
 *  @return 新尺寸的 UIImage
 */
- (nullable UIImage *)transformToSize:(CGSize)newSize;

/*!
 *  @brief 等比例缩放
 *
 *  @param newSize 新尺寸
 *
 *  @return 等比例缩放后的 UIImage
 */
- (nullable UIImage *)scaleAspectWithSize:(CGSize)newSize;

/*!
 *  @brief 旋转图片，单位：弧度
 *
 *  @param radians 旋转角度，向左转为正数，向右转为负数
 *  @param fitSize 是否自适应大小
 *
 *  @return 旋转后的 UIImage
 */
- (nullable UIImage *)rotate:(CGFloat)radians fitSize:(BOOL)fitSize;

/*!
 *  @brief 让图片向左旋转90°
 *
 *  @return 旋转后的 UIImage
 */
- (nullable UIImage *)rotateLeft90;

/*!
 *  @brief 让图片向右旋转90°
 *
 *  @return 旋转后的 UIImage
 */
- (nullable UIImage *)rotateRight90;


/*!
 *  @brief 将图片保存到相册中，如果图片为GIF动图将强制转码为PNG
 *
 *  @discussion 如果希望将动图保存到相册中，可以使用 PHAssetChangeRequest
 *
 *  @param contextInfo 上下文信息
 *  @param block       保存完毕回调block
 */
- (void)writeToSavedPhotosAlbumWithContext:(nullable void *)contextInfo
                             finishedBlock:(nullable void (^)(UIImage * _Nullable image, NSError * _Nullable error, void *contextInfo))block;

/*!
 *  @brief 将图片转为JPG格式保存到指定路径中
 *
 *  @param path             保存路径
 *  @param compress         压缩比（0.0~1.0）
 *  @param useAuxiliaryFile 如果已存在文件，是否使用临时文件形式替换
 *                          - YES，先创建临时文件，保存完毕后替换原文件
 *                          - NO，直接写入
 *
 *  @return 保存成功返回'YES'，保存失败返回'NO'
 */
- (BOOL)writeToJPEGFile:(NSString *)path compressionQuality:(CGFloat)compress atomically:(BOOL)useAuxiliaryFile;

/*!
 *  @brief 将图片转为PNG格式保存到指定路径中
 *
 *  @param path             保存路径
 *  @param useAuxiliaryFile 如果已存在文件，是否使用临时文件形式替换
 *                          - YES，先创建临时文件，保存完毕后替换原文件
 *                          - NO，直接写入
 *
 *  @return 保存成功返回'YES'，保存失败返回'NO'
 */
- (BOOL)writeToPNGFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;

/*!
 *  @brief 将图片转为JPG格式保存到指定路径中
 *
 *  @param path             保存图片的相对路径，也可以是文件名
 *  @param directory        文件夹，例如：NSDocumentDirectory
 *  @param domainMask       域，例如：NSUserDomainMask
 *  @param compress         压缩比（0.0~1.0）
 *  @param useAuxiliaryFile 如果已存在文件，是否使用临时文件形式替换
 *                          - YES，先创建临时文件，保存完毕后替换原文件
 *                          - NO，直接写入
 *
 *  @return 保存成功返回'YES'，保存失败返回'NO'
 */
- (BOOL)writeToJPEGFile:(NSString *)path relativeToDirectory:(NSSearchPathDirectory)directory inDomain:(NSSearchPathDomainMask)domainMask compressionQuality:(CGFloat)compress atomically:(BOOL)useAuxiliaryFile;

/*!
 *  @brief 将图片转为PNG格式保存到指定路径中
 *
 *  @param path             保存图片的相对路径，也可以是文件名
 *  @param directory        文件夹，例如：NSDocumentDirectory
 *  @param domainMask       域，例如：NSUserDomainMask
 *  @param useAuxiliaryFile 如果已存在文件，是否使用临时文件形式替换
 *                          - YES，先创建临时文件，保存完毕后替换原文件
 *                          - NO，直接写入
 *
 *  @return 保存成功返回'YES'，保存失败返回'NO'
 */
- (BOOL)writeToPNGFile:(NSString *)path relativeToDirectory:(NSSearchPathDirectory)directory inDomain:(NSSearchPathDomainMask)domainMask atomically:(BOOL)useAuxiliaryFile;

/*!
 *  @brief 从文件中读取图片
 *
 *  @param path       保存图片的相对路径，也可以是文件名
 *  @param directory  文件夹，例如：NSDocumentDirectory
 *  @param domainMask 域，例如：NSUserDomainMask
 *
 *  @return UIImage or nil
 */
+ (nullable UIImage *)imageWithContentsOfFile:(NSString *)path relativeToDirectory:(NSSearchPathDirectory)directory inDomain:(NSSearchPathDomainMask)domainMask;



#pragma mark - 高斯模糊效果
///-----------------------------------------------------------------------------
/// @name 高斯模糊效果
/// @see  https://developer.apple.com/downloads/index.action?name=WWDC%202013 -> 'UIImageEffects'
///-----------------------------------------------------------------------------

/*!
 *  @brief 浅色模糊
 *
 *  @return 高斯模糊渲染的图片
 */
- (nullable UIImage *)lightEffect;

/*!
 *  @brief 另一种浅色模糊
 *
 *  @return 高斯模糊渲染的图片
 */
- (nullable UIImage *)extraLightEffect;

/*!
 *  @brief 深色模糊
 *
 *  @return 高斯模糊渲染的图片
 */
- (nullable UIImage *)darkEffect;

/*!
 *  @brief 使用特定颜色渲染
 *
 *  @return 高斯模糊渲染的图片
 */
- (nullable UIImage *)tintEffectWithColor:(UIColor *)tintColor;

/*!
 *  @brief 高斯模糊效果
 *
 *  @param blurRadius            模糊程度，0表示无模糊渲染
 *  @param tintColor             模糊渲染颜色
 *  @param saturationDeltaFactor 饱和度
 *  @param maskImage             掩膜
 *
 *  @return 高斯模糊渲染的图片
 */
- (nullable UIImage *)blurWithRadius:(CGFloat)blurRadius
                           tintColor:(UIColor *)tintColor
               saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                           maskImage:(nullable UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
