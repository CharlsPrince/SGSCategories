/*!
 *  @header UIImage+SGS.m
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "UIImage+SGS.h"
#import "NSString+SGS.h"
#import "UIView+SGS.h"
#import "NSFileManager+SGS.h"
#import <float.h>
#import <objc/runtime.h>
@import Accelerate;

#define kDegreesToRadians(d) ((d) * M_PI / 180)

static const int kBlockKey;

/**
 *  保存图片回调类，仅内部使用
 */
@interface kSaveImageBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(UIImage *image, NSError *error, void *context);

- (instancetype)initWithBlock:(void (^)(UIImage *image, NSError *error, void *context))block;
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

@end

@implementation kSaveImageBlockTarget

- (instancetype)initWithBlock:(void (^)(UIImage *, NSError *, void *))block {
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (self.block != nil) self.block(image, error, contextInfo);
}

@end


#pragma mark - 

@implementation UIImage (SGS)

// 生成1像素的纯色图片
+ (instancetype)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

// 生成纯颜色的图片
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    
    CGRect rect = { CGPointZero, size };
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

// 截屏
+ (instancetype)snapshotScreen {
    return [[[UIApplication sharedApplication] keyWindow] snapshotImage];
}

// 生成圆形图片
- (UIImage *)roundImage {
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    CGRect rect = { CGPointZero, self.size };
    
    CGContextAddEllipseInRect(currnetContext, rect);
    CGContextClip(currnetContext);
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

// 生成圆角图片
- (UIImage *)roundRectWithCornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContext(self.size);
    
    CGRect rect = { CGPointZero, self.size };
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

// 截取范围图片
- (UIImage *)cutoutWithFrame:(CGRect)frame {
    CGImageRef cgImg = CGImageCreateWithImageInRect(self.CGImage, frame);
    UIImage *image = [UIImage imageWithCGImage:cgImg];
    CGImageRelease(cgImg);
    
    return image;
}

// 拉伸中心点
- (UIImage *)resizableImageWithCapInCenter {
    CGFloat x = self.size.width / 2.0f;
    CGFloat y = self.size.height / 2.0f;
    UIEdgeInsets edge = UIEdgeInsetsMake(y, x, y, x);
    
    return [self resizableImageWithCapInsets:edge];
}

// 转换成新的尺寸
- (UIImage *)transformToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) return nil;
    
    CGRect rect = { CGPointZero, size };
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 等比例缩放
- (UIImage *)scaleAspectWithSize:(CGSize)newSize {
    CGFloat actualHeight = self.size.height;
    CGFloat actualWidth = self.size.width;
    
    float oldRatio = actualWidth / actualHeight;
    float newRatio = newSize.width / newSize.height;
    if (oldRatio < newRatio) {
        oldRatio = newSize.height / actualHeight;
        actualWidth = oldRatio * actualWidth;
        actualHeight = newSize.height;
    } else {
        oldRatio = newSize.width/actualWidth;
        actualHeight = oldRatio * actualHeight;
        actualWidth = newSize.width;
    }
    
    return [self transformToSize:CGSizeMake(actualWidth, actualHeight)];
}

// 旋转图片
- (UIImage *)rotate:(CGFloat)radians fitSize:(BOOL)fitSize {
    size_t width = (size_t)CGImageGetWidth(self.CGImage);
    size_t height = (size_t)CGImageGetHeight(self.CGImage);
    CGRect newRect = CGRectApplyAffineTransform(CGRectMake(0., 0., width, height),
                                                fitSize ? CGAffineTransformMakeRotation(radians) : CGAffineTransformIdentity);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 (size_t)newRect.size.width,
                                                 (size_t)newRect.size.height,
                                                 8,
                                                 (size_t)newRect.size.width * 4,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    if (!context) return nil;
    
    CGContextSetShouldAntialias(context, true);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    CGContextTranslateCTM(context, +(newRect.size.width * 0.5), +(newRect.size.height * 0.5));
    CGContextRotateCTM(context, radians);
    
    CGContextDrawImage(context, CGRectMake(-(width * 0.5), -(height * 0.5), width, height), self.CGImage);
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:imgRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imgRef);
    CGContextRelease(context);
    
    return image;
}

// 让图片向左旋转90°
- (UIImage *)rotateLeft90 {
    return [self rotate:kDegreesToRadians(90) fitSize:YES];
}

// 让图片向右旋转90°
- (UIImage *)rotateRight90 {
    return [self rotate:kDegreesToRadians(-90) fitSize:YES];
}


// 将图片保存到相册中
- (void)writeToSavedPhotosAlbumWithContext:(void *)contextInfo
                             finishedBlock:(void (^)(UIImage * _Nullable, NSError * _Nullable, void * _Nonnull))block
{
    kSaveImageBlockTarget *target = [[kSaveImageBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &kBlockKey, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImageWriteToSavedPhotosAlbum(self, target, @selector(image:didFinishSavingWithError:contextInfo:), contextInfo);
}

// 将图片保存为JPG文件
- (BOOL)writeToJPEGFile:(NSString *)path
     compressionQuality:(CGFloat)compress
             atomically:(BOOL)useAuxiliaryFile
{
    if (path.length == 0) return NO;
    NSData *imageData = UIImageJPEGRepresentation(self, compress);
    if (imageData.length == 0) return NO;
    
    return [imageData writeToFile:path atomically:useAuxiliaryFile];
}

// 将图片保存为PNG文件
- (BOOL)writeToPNGFile:(NSString *)path
            atomically:(BOOL)useAuxiliaryFile
{
    if (path.length == 0) return NO;
    NSData *imageData = UIImagePNGRepresentation(self);
    if (imageData.length == 0) return NO;
    
    return [imageData writeToFile:path atomically:useAuxiliaryFile];
}

// 将图片保存为JPG文件
- (BOOL)writeToJPEGFile:(NSString *)path
    relativeToDirectory:(NSSearchPathDirectory)directory
               inDomain:(NSSearchPathDomainMask)domainMask
     compressionQuality:(CGFloat)compress
             atomically:(BOOL)useAuxiliaryFile
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    return [self writeToJPEGFile:path compressionQuality:compress atomically:useAuxiliaryFile];
}

// 将图片保存为PNG文件
- (BOOL)writeToPNGFile:(NSString *)path
   relativeToDirectory:(NSSearchPathDirectory)directory
              inDomain:(NSSearchPathDomainMask)domainMask
            atomically:(BOOL)useAuxiliaryFile
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    return [self writeToPNGFile:path atomically:useAuxiliaryFile];
}

// 从文件中读取图片
+ (UIImage *)imageWithContentsOfFile:(NSString *)path
                 relativeToDirectory:(NSSearchPathDirectory)directory
                            inDomain:(NSSearchPathDomainMask)domainMask
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return nil;
    
    return [UIImage imageWithContentsOfFile:path];
}


///================================================================
///  MARK: 高斯模糊效果
///        源码来自苹果官方：https://developer.apple.com/downloads/index.action?name=WWDC%202013 -> 'UIImageEffects'
///================================================================

// 浅色模糊效果
- (UIImage *)lightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self blurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

// 另一种浅色模糊效果
- (UIImage *)extraLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self blurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

// 深色模糊效果
- (UIImage *)darkEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self blurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

// 使用特定颜色渲染
- (UIImage *)tintEffectWithColor:(UIColor *)tintColor
{
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self blurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}

// 高斯模糊效果
- (UIImage *)blurWithRadius:(CGFloat)blurRadius
                  tintColor:(UIColor *)tintColor
      saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                  maskImage:(UIImage *)maskImage
{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
#if DEBUG
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
#endif
        return nil;
    }
    if (!self.CGImage) {
#if DEBUG
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
#endif
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
#if DEBUG
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
#endif
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}
@end
