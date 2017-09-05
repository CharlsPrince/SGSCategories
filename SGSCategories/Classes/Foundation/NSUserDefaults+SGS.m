/*!
 *  @header NSUserDefaults+SGS.m
 *
 *  @author Created by Lee on 16/9/2.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSUserDefaults+SGS.h"

@implementation NSUserDefaults (SGS)

+ (void)setObject:(id)value forKey:(NSString *)defaultName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:value forKey:defaultName];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setInteger:value forKey:defaultName];
}

+ (void)setFloat:(float)value forKey:(NSString *)defaultName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setFloat:value forKey:defaultName];
}

+ (void)setDouble:(double)value forKey:(NSString *)defaultName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setDouble:value forKey:defaultName];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:value forKey:defaultName];
}

+ (void)setURL:(NSURL *)url forKey:(NSString *)defaultName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setURL:url forKey:defaultName];
}

+ (void)removeObjectForKey:(NSString *)defaultName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:defaultName];
}

+ (id)objectForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (NSString *)stringForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] stringForKey:defaultName];
}

+ (NSArray *)arrayForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:defaultName];
}

+ (NSDictionary<NSString *,id> *)dictionaryForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:defaultName];
}

+ (NSData *)dataForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] dataForKey:defaultName];
}

+ (NSArray<NSString *> *)stringArrayForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] stringArrayForKey:defaultName];
}

+ (NSInteger)integerForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] integerForKey:defaultName];
}

+ (float)floatForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] floatForKey:defaultName];
}

+ (double)doubleForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:defaultName];
}

+ (BOOL)boolForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];
}

+ (NSURL *)URLForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] URLForKey:defaultName];
}

@end
