/*!
 *  @header NSDateFormatter+SGS.m
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSDateFormatter+SGS.h"

@implementation NSDateFormatter (SGS)

// yyyy
+ (instancetype)ISO8601DateFormatterWithYear {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"yyyy";
    });
    return formatter;
}

// MM
+ (instancetype)ISO8601DateFormatterWithMonth {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"MM";
    });
    return formatter;
}

// yyyy-MM
+ (instancetype)ISO8601DateFormatterWithYearAndMonth {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"yyyy-MM";
    });
    return formatter;
}

// dd
+ (instancetype)ISO8601DateFormatterWithDay {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"dd";
    });
    return formatter;
}

// MM-dd
+ (instancetype)ISO8601DateFormatterWithMonthAndDay {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"MM-dd";
    });
    return formatter;
}

// yyyy-MM-dd
+ (instancetype)ISO8601DateFormatterWithFullDate {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"yyyy-MM-dd";
    });
    return formatter;
}

// HH:mm:ss
+ (instancetype)ISO8601DateFormatterWithFullTime {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"HH:mm:ss";
    });
    return formatter;
}

// yyyy-MM-dd HH:mm:ss
+ (instancetype)ISO8601DateFormatterWithFullDateAndTime {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return formatter;
}

// yyyy-MM-dd'T'HH:mm:ssZ
+ (instancetype)ISO8601DateFormatterWithInternetDateTime {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return formatter;
}

// yyyy-M-d H:mm
+ (instancetype)shortCommonFormat {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"yyyy-M-d H:mm";
    });
    return formatter;
}

// yyyy年M月
+ (instancetype)yearAndMonthFormatOnChinese {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"yyyy年M月";
    });
    return formatter;
}

// yyyy年M月d日
+ (instancetype)yearMonthAndDayFormatOnChinese {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"yyyy年M月d日";
    });
    return formatter;
}

// M月d日
+ (instancetype)monthAndDayFormatOnChinese {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"M月d日";
    });
    return formatter;
}

// 上午 9:30
+ (instancetype)hourAndMinuteFormatOnChinese {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
        formatter.AMSymbol = @"上午";
        formatter.PMSymbol = @"下午";
        formatter.dateFormat = @"a h:mm";
    });
    return formatter;
}

// 获取通用格式的NSDateFormatter
+ (instancetype)ISO8601DateFormatterByShowTSeparator:(BOOL)showTSeparator showTimeZone:(BOOL)showTimeZone {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
    });
    
    NSString *formatStr = @"yyyy-MM-dd";
    formatStr = (showTSeparator) ? [formatStr stringByAppendingString:@"'T'"] : [formatStr stringByAppendingString:@" "];
    formatStr = [formatStr stringByAppendingString:@"HH:mm:ss"];
    if (showTimeZone) formatStr = [formatStr stringByAppendingString:@"Z"];
    
    formatter.dateFormat = formatStr;
    return formatter;
}

@end
