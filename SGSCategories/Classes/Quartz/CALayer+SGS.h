/*!
 *  @header CALayer+SGS.h
 *
 *  @abstract CALayer 扩展
 *
 *  @author Created by Lee on 16/9/1.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <QuartzCore/QuartzCore.h>

/*!
 *  @brief 动画填充模式
 */
typedef NS_ENUM(NSInteger, SGSAnimationFillMode) {
    SGSAnimationFillModeRemoved   = 0, //! 动画执行完毕后回复到原始状态，默认
    SGSAnimationFillModeForwards  = 1, //! 动画执行完毕后保持最后的状态
    SGSAnimationFillModeBackwards = 2, //! 在某个初始状态后执行动画
    SGSAnimationFillModeBoth      = 3, //! Forwards 和 Backwards 两者结合
};

/*!
 *  @brief 转场动画效果类型
 */
typedef NS_ENUM(NSInteger, SGSTransitionType) {
    SGSTransitionTypeFade         = 0,  //! 淡出淡入效果
    SGSTransitionTypeMoveIn       = 1,  //! 新视图移动到旧视图上
    SGSTransitionTypePush         = 2,  //! 新视图推出旧视图
    SGSTransitionTypeReveal       = 3,  //! 移开旧视图显示新视图
    SGSTransitionTypeOglFlip      = 4,  //! 翻转效果
    SGSTransitionTypeCube         = 5,  //! 立方体翻转效果
    SGSTransitionTypeSuckEffect   = 6,  //! 收缩效果，不支持方向
    SGSTransitionTypeRippleEffect = 7,  //! 波纹效果，不支持方向
    SGSTransitionTypePageCurl     = 8,  //! 向上翻页效果
    SGSTransitionTypePageUnCurl   = 9,  //! 向下翻页效果
    SGSTransitionTypeCameraOpen   = 10, //! 摄像头打开效果，不支持方向
    SGSTransitionTypeCameraClose  = 11, //! 摄像头关闭效果，不支持方向
};

/*!
 *  @brief 转场动画方向
 */
typedef NS_ENUM(NSInteger, SGSTransitionDirection) {
    SGSTransitionDirectionTop    = 1, //! 从顶部转场
    SGSTransitionDirectionLeft   = 2, //! 从左侧转场
    SGSTransitionDirectionBottom = 3, //! 从底部转场
    SGSTransitionDirectionRight  = 4, //! 从右侧转场
};

/*!
 *  @brief 转场动画速度曲线
 */
typedef NS_ENUM(NSInteger, SGSTransitionTiming) {
    SGSTransitionTimingDefault       = 1, //! 默认
    SGSTransitionTimingEaseIn        = 2, //! 渐进
    SGSTransitionTimingEaseOut       = 3, //! 渐出
    SGSTransitionTimingEaseInEaseOut = 4, //! 渐进渐出
    SGSTransitionTimingLinear        = 5, //! 线性（匀速）
};



NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 核心动画扩展
 */
@interface CALayer (SGS)

#pragma mark - 核心动画
///-----------------------------------------------------------------------------
/// @name 核心动画
///-----------------------------------------------------------------------------

/*!
 *  @brief 为CALayer添加基本动画
 *
 *  @discussion 动画需要改变的属性值都是可选的，但是不能超过两个非空
 *
 *    - 如果 fromValue 和 toValue 都有值，则动画将根据两者之间的数值改变
 *
 *    - 如果 fromValue 和 byValue 都有值，则动画将从 fromValue 到
 *      fromValue + byValue 进行改变
 *
 *    - 如果 byValue 和 toValue 都有值，则动画将从 byValue 到 toValue
 *      进行改变
 *
 *    - 如果仅有 fromValue，则动画将从 fromValue 到 keyPath 的属性值进行改变
 *
 *    - 如果仅有 toValue，则动画将从 keyPath 的属性值到 toValue 进行改变
 *
 *    - 如果仅有 byValue，则动画将从 keyPath 的属性值到再此基础上加上 byValue
 *      进行改变
 *    
 *    - 如果都为 nil，则没有任何变化
 *
 *  @param keyPath            动画属性
 *  @param fromValue          属性改变的基础值
 *  @param toValue            属性改变的最终值
 *  @param byValue            属性改变的进步值
 *  @param fillMode           动画填充模式，默认为Remove
 *  @param repeatCount        重复次数，可以通过传入 MAXFLOAT 这种大数表示无限重复
 *  @param removeOnCompletion 动画执行完毕后是否移除动画
 *
 *  @return CABasicAnimation
 */
- (CABasicAnimation *)addBasicAnimationWithKeyPath:(nullable NSString *)keyPath
                                         fromValue:(nullable id)fromValue
                                           toValue:(nullable id)toValue
                                           byValue:(nullable id)byValue
                                          fillMode:(SGSAnimationFillMode)fillMode
                                       repeatCount:(float)repeatCount
                                removeOnCompletion:(BOOL)removeOnCompletion;

/*!
 *  @brief 为CALayer添加关键帧动画
 *
 *  @param path               关键帧路径
 *  @param duration           时长
 *  @param fillMode           填充模式，默认为Remove
 *  @param repeatCount        重复次数，可以通过传入 MAXFLOAT 这种大数表示无限重复
 *  @param removeOnCompletion 动画执行完毕后是否移除动画
 *
 *  @return CAKeyframeAnimation
 */
- (CAKeyframeAnimation *)addKeyframeAnimationWithPath:(CGPathRef)path
                                             duration:(NSTimeInterval)duration
                                             fillMode:(SGSAnimationFillMode)fillMode
                                          repeatCount:(float)repeatCount
                                   removeOnCompletion:(BOOL)removeOnCompletion;

/*!
 *  @brief 为CALayer添加转场动画
 *
 *  @param type 转场动画类型
 *
 *  @return CATransition
 */
- (CATransition *)addTransitionWithAnimType:(SGSTransitionType)type;

/*!
 *  @brief 为CALayer添加转场动画
 *
 *  @param type      转场动画类型，默认为Fade
 *  @param direction 转场动画方向，如果为0则使用默认方向
 *  @param timing    转场动画速度曲线，如果为0则使用默认方向
 *  @param duration  转场动画时长，如果小于等于0则使用默认值
 *
 *  @return CATransition
 */
- (CATransition *)addTransitionWithAnimType:(SGSTransitionType)type
                                  direction:(SGSTransitionDirection)direction
                                     timing:(SGSTransitionTiming)timing
                                   duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END