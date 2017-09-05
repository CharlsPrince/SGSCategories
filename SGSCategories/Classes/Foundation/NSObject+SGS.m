/*!
 *  @header NSObject+SGS.m
 *
 *  @author Created by Lee on 16/9/14.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSObject+SGS.h"
#import <objc/runtime.h>

static const int kKVOBlockKey;

/// KVO 回调类，仅内部使用
@interface kObjectKVOBlockTarget : NSObject
@property (nonatomic, copy) void (^block)(__weak id obj, id oldVal, id newVal);
- (id)initWithBlock:(void (^)(__weak id obj, id oldVal, id newVal))block;
@end

@implementation kObjectKVOBlockTarget
- (id)initWithBlock:(void (^)(__weak id obj, id oldVal, id newVal))block {
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (!self.block) return;
    
    BOOL isPrior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    if (isPrior) return;
    
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    
    self.block(object, oldVal, newVal);
}
@end

#pragma mark - NSObject (SGS)

@implementation NSObject (SGS)

#pragma mark - runtime

- (void)setAssociatedValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociatedCopyValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setAssociatedAssignValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}

#pragma mark - KVO

- (void)addObserverForKeyPath:(NSString *)keyPath block:(void (^)(id _Nonnull, id _Nonnull, id _Nonnull))block {
    if (!keyPath || !block) return;
    kObjectKVOBlockTarget *target = [[kObjectKVOBlockTarget alloc] initWithBlock:block];
    NSMutableDictionary *dic = [self p_allObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    if (!arr) {
        arr = [NSMutableArray array];
        dic[keyPath] = arr;
    }
    [arr addObject:target];
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)removeObserverBlocksForKeyPath:(NSString *)keyPath {
    if (!keyPath) return;
    NSMutableDictionary *dic = [self p_allObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    
    [dic removeObjectForKey:keyPath];
}

- (void)removeObserverBlocks {
    NSMutableDictionary *dic = [self p_allObserverBlocks];
    [dic enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSArray *arr, BOOL *stop) {
        [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    
    [dic removeAllObjects];
}

- (NSMutableDictionary *)p_allObserverBlocks {
    NSMutableDictionary *targets = objc_getAssociatedObject(self, &kKVOBlockKey);
    if (!targets) {
        targets = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &kKVOBlockKey, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return targets;
}


#pragma mark - 其他

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (NSString *)className {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

@end
