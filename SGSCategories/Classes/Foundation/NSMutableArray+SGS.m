/*!
 *  @header NSMutableArray+SGS.m
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSMutableArray+SGS.h"
#import "NSString+SGS.h"
#import "NSData+SGS.h"

@implementation NSMutableArray (SGS)

#pragma mark - 通用

+ (NSMutableArray *)arrayWithContentsOfMainBundleFile:(NSString *)filename fileType:(NSString *)ext {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:ext];
    if (path == nil) return nil;
    return [NSMutableArray arrayWithContentsOfFile:path];
}

+ (NSMutableArray *)arrayWithContentsOfFile:(NSString *)path
                        relativeToDirectory:(NSSearchPathDirectory)directory
                                   inDomain:(NSSearchPathDomainMask)domainMask
{
    path = [NSString stringWithPath:path relativeToDirectory:directory inDomain:domainMask];
    if (path == nil) return nil;
    return [NSMutableArray arrayWithContentsOfFile:path];
}

// 弹出数组首元素
- (id)popFirstObject {
    id obj = nil;
    if (self.count > 0) {
        obj = self.firstObject;
        [self removeObjectAtIndex:0];
    }
    return obj;
}

// 弹出数组末尾元素
- (id)popLastObject {
    id obj = nil;
    if (self.count > 0) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}

// 将元素添加到数组末尾
- (void)appendObject:(id)anObject {
    if (anObject != nil) {
        [self addObject:anObject];
    }
}

// 将元素添加到数组开头
- (void)prependObject:(id)anObject {
    if (anObject != nil) {
        [self insertObject:anObject atIndex:0];
    }
}

// 将另一个数组中的元素添加到数组末尾
- (void)appendObjects:(NSArray *)objects {
    if (objects.count > 0) {
        [self addObjectsFromArray:objects];
    }
}

// 将另一个数组中的元素添加到数组开头
- (void)prependObjects:(NSArray *)objects {
    if (objects.count > 0) {
        NSUInteger i = 0;
        for (id obj in objects) {
            [self insertObject:obj atIndex:i++];
        }
    }
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if ((anObject != nil) && (index < self.count)) {
        [self insertObject:anObject atIndex:index];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

- (void)moveObjectToFirstFromIndex:(NSUInteger)index {
    if ((index != 0) && (index < self.count)) {
        id obj = [self objectAtIndex:index];
        [self removeObjectAtIndex:index];
        [self insertObject:obj atIndex:0];
    }
}

- (void)moveObjectToLastFromIndex:(NSUInteger)index {
    if ((index != (self.count-1)) && (index < self.count)) {
        id obj = [self objectAtIndex:index];
        [self removeObjectAtIndex:index];
        [self addObject:obj];
    }
}

// 在指定位置插入数组元素
- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

// 倒转数组
- (void)reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

// 打乱数组顺序
- (void)shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1) withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}

#pragma mark - 编码转换

+ (NSMutableArray *)arrayWithJSONData:(NSData *)data {
    return [NSMutableArray arrayWithJSONData:data error:NULL];
}

+ (NSMutableArray *)arrayWithJSONData:(NSData *)data error:(NSError * _Nullable __autoreleasing *)error {
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:error];
    return ([array isKindOfClass:[NSMutableArray class]] ? array : nil);
}

+ (NSMutableArray *)arrayWithJSONString:(NSString *)string {
    return [NSMutableArray arrayWithJSONString:string error:NULL];
}

+ (NSMutableArray *)arrayWithJSONString:(NSString *)string error:(NSError * _Nullable __autoreleasing *)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return nil;
    return [NSMutableArray arrayWithJSONData:data error:error];
}

+ (NSMutableArray *)arrayWithPlistData:(NSData *)data {
    return [NSMutableArray arrayWithPlistData:data error:NULL];
}

+ (NSMutableArray *)arrayWithPlistData:(NSData *)data error:(NSError * _Nullable __autoreleasing *)error {
    NSMutableArray *array = [NSPropertyListSerialization propertyListWithData:data
                                                                      options:NSPropertyListMutableContainers
                                                                       format:NULL
                                                                        error:error];
    return ([array isKindOfClass:[NSMutableArray class]] ? array : nil);
}

+ (NSMutableArray *)arrayWithPlistString:(NSString *)string {
    return [NSMutableArray arrayWithPlistString:string error:NULL];
}

+ (NSMutableArray *)arrayWithPlistString:(NSString *)string error:(NSError * _Nullable __autoreleasing *)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) return nil;
    return [NSMutableArray arrayWithPlistData:data error:error];
}
@end
