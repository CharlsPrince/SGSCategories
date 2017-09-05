/*!
 *  @header CALayer+SGS.m
 *
 *  @author Created by Lee on 16/9/1.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "CALayer+SGS.h"

@implementation CALayer (SGS)

- (CABasicAnimation *)addBasicAnimationWithKeyPath:(NSString *)keyPath
                                         fromValue:(id)fromValue
                                           toValue:(id)toValue
                                           byValue:(id)byValue
                                          fillMode:(SGSAnimationFillMode)fillMode
                                       repeatCount:(float)repeatCount
                                removeOnCompletion:(BOOL)removeOnCompletion
{
    static NSString *key = @"SGSBasicAnimation";
    
    if ([self animationForKey:key] != nil) {
        [self removeAnimationForKey:key];
    }
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath             = keyPath;
    animation.fromValue           = fromValue;
    animation.toValue             = toValue;
    animation.byValue             = byValue;
    animation.fillMode            = [self p_fillMode:fillMode];
    animation.repeatCount         = repeatCount;
    animation.removedOnCompletion = removeOnCompletion;
    
    [self addAnimation:animation forKey:key];
    
    return animation;
}

- (CAKeyframeAnimation *)addKeyframeAnimationWithPath:(CGPathRef)path
                                             duration:(NSTimeInterval)duration
                                             fillMode:(SGSAnimationFillMode)fillMode
                                          repeatCount:(float)repeatCount
                                   removeOnCompletion:(BOOL)removeOnCompletion
{
    static NSString *key = @"SGSKeyframeAnimation";
    
    if ([self animationForKey:key] != nil) {
        [self removeAnimationForKey:key];
    }
    
    CAKeyframeAnimation *kfAnim = [CAKeyframeAnimation animation];
    
    kfAnim.path                = path;
    kfAnim.fillMode            = [self p_fillMode:fillMode];
    kfAnim.repeatCount         = repeatCount;
    kfAnim.removedOnCompletion = removeOnCompletion;
    
    if (duration > 0) {
        kfAnim.duration = duration;
    }
    
    [self addAnimation:kfAnim forKey:key];
    
    return kfAnim;
}

- (CATransition *)addTransitionWithAnimType:(SGSTransitionType)type {
    return [self addTransitionWithAnimType:type direction:kNilOptions timing:kNilOptions duration:-1];
}

- (CATransition *)addTransitionWithAnimType:(SGSTransitionType)type direction:(SGSTransitionDirection)direction timing:(SGSTransitionTiming)timing duration:(NSTimeInterval)duration {
    
    static NSString *key = @"SGSTransition";
    
    if ([self animationForKey:key] != nil) {
        [self removeAnimationForKey:key];
    }
    
    CATransition *transition = [CATransition animation];
    
    transition.type = [self p_transitionAnimType:type];
    
    NSString *dir = [self p_transitionAnimDirection:direction];
    if (dir != nil) {
        transition.subtype = dir;
    }
    
    NSString *ti = [self p_transitionTiming:timing];
    if (ti != nil) {
        transition.timingFunction = [CAMediaTimingFunction functionWithName:ti];
    }
    
    if (duration > 0) {
        transition.duration = duration;
    }
    
    [self addAnimation:transition forKey:key];
    
    return transition;
}

- (NSString *)p_transitionAnimType:(SGSTransitionType)type {
    switch (type) {
        case SGSTransitionTypeFade:         return kCATransitionFade;
        case SGSTransitionTypeMoveIn:       return kCATransitionMoveIn;
        case SGSTransitionTypePush:         return kCATransitionPush;
        case SGSTransitionTypeReveal:       return kCATransitionReveal;
        case SGSTransitionTypeOglFlip:      return @"oglFlip";
        case SGSTransitionTypeCube:         return @"cube";
        case SGSTransitionTypeSuckEffect:   return @"suckEffect";
        case SGSTransitionTypeRippleEffect: return @"rippleEffect";
        case SGSTransitionTypePageCurl:     return @"pageCurl";
        case SGSTransitionTypePageUnCurl:   return @"pageUnCurl";
        case SGSTransitionTypeCameraOpen:   return @"cameraIrisHollowOpen";
        case SGSTransitionTypeCameraClose:  return @"cameraIrisHollowClose";
    }
}

- (NSString *)p_transitionAnimDirection:(SGSTransitionDirection)direction {
    switch (direction) {
        case SGSTransitionDirectionTop:    return kCATransitionFromTop;
        case SGSTransitionDirectionLeft:   return kCATransitionFromLeft;
        case SGSTransitionDirectionBottom: return kCATransitionFromBottom;
        case SGSTransitionDirectionRight:  return kCATransitionFromRight;
        default: return nil;
    }
}

- (NSString *)p_transitionTiming:(SGSTransitionTiming)timing {
    switch (timing) {
        case SGSTransitionTimingDefault:       return kCAMediaTimingFunctionDefault;
        case SGSTransitionTimingEaseIn:        return kCAMediaTimingFunctionEaseIn;
        case SGSTransitionTimingEaseOut:       return kCAMediaTimingFunctionEaseOut;
        case SGSTransitionTimingEaseInEaseOut: return kCAMediaTimingFunctionEaseInEaseOut;
        case SGSTransitionTimingLinear:        return kCAMediaTimingFunctionLinear;
        default: return nil;
    }
}

- (NSString *)p_fillMode:(SGSAnimationFillMode)fillMode {
    switch (fillMode) {
        case SGSAnimationFillModeRemoved:   return kCAFillModeRemoved;
        case SGSAnimationFillModeForwards:  return kCAFillModeForwards;
        case SGSAnimationFillModeBackwards: return kCAFillModeBackwards;
        case SGSAnimationFillModeBoth:      return kCAFillModeBoth;
    }
}

@end
