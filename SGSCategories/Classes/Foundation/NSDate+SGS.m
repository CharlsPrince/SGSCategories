/*!
 *  @header NSDate+SGS.m
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSDate+SGS.h"
#import "NSDateFormatter+SGS.h"

@implementation NSDate (SGS)

#pragma mark - 常用属性

// 年代
- (NSInteger)era {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitEra fromDate:self] era];
}

// 年份
- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

// 月份 (1~12)
- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

// 天 (1~31)
- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

// 小时 (0~23)
- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

// 分 (0~59)
- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

// 秒 (0~59)
- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

// 纳秒
- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitNanosecond fromDate:self] nanosecond];
}

// 星期
- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

// 该月中的第几个周x
- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

// 该月份的第几周
- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

// 该年的第几周
- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

// 返回该日期的周的所在年份
- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

// 当前年中的第几个季度
- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

// 该月的第一天是星期几
- (NSUInteger)weeklyOrdinality {
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
}

// 计算当月有多少天
- (NSUInteger)numberOfDaysInThisMonth {
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

// 计算当月有多少周
- (NSUInteger)numberOfWeeksInThisMonth {
    return [[self lastDayInThisMonth] weekOfMonth];
}

// 是否是闰月
- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

// 是否是闰年
- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

// 判断日期是否是今天
- (BOOL)isToday {
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

// 判断日期是否是明天
- (BOOL)isTomorrow {
    NSDate *tomorrow = [NSDate tomorrow];
    if (tomorrow == nil) return NO;
    
    return [self isEqualToDateIgnoringTime:tomorrow];
}

// 判断日期是否是昨天
- (BOOL)isYesterday {
    NSDate *yesterday = [NSDate yesterday];
    if (yesterday == nil) return NO;
    
    return [self isEqualToDateIgnoringTime:yesterday];
}

// 判断日期是否是今年
- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger thisYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    return selfYear == thisYear;
}

#pragma mark - 日期比较与增减

// 获取当前时间戳
+ (NSTimeInterval)currentTimeStamp {
    return [NSDate dateWithTimeIntervalSinceNow:0.0].timeIntervalSince1970;
}

// 返回明天此刻的日期
+ (instancetype)tomorrow {
    return [[NSDate date] dateByAddingDays:1];
}

// 返回昨天此刻的日期
+ (instancetype)yesterday {
    return [[NSDate date] dateByAddingDays:-1];
}

// 当月的第一天
- (NSDate *)firstDayInThisMonth {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    components.day = 1;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

// 当月的最后一天
- (NSDate *)lastDayInThisMonth {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    components.day = self.numberOfDaysInThisMonth;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

// 上一个月的这一天
- (NSDate *)dayInPreviousMonth {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:kNilOptions];
}

// 下一个月的这一天
- (NSDate *)dayInNextMonth {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:kNilOptions];
}

// 与另一个日期判断是否是同一天
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)date {
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    return ((selfComponents.year == dateComponents.year) &&
            (selfComponents.month == dateComponents.month) &&
            (selfComponents.day == dateComponents.day));
}

// 在参照日期的基础上增加多少秒（使用负数来减少）
- (NSDate*)dateByAddingSeconds:(NSTimeInterval)seconds {
    return [NSDate dateWithTimeInterval:seconds sinceDate:self];
}

// 在参照日期的基础上增加多少分钟（使用负数来减少）
- (NSDate*)dateByAddingMinutes:(NSInteger)minutes {
    return [NSDate dateWithTimeInterval:(60 * minutes) sinceDate:self];
}

// 在参照日期的基础上增加多少小时（使用负数来减少）
- (NSDate*)dateByAddingHours:(NSInteger)hours {
    return [NSDate dateWithTimeInterval:(3600 * hours) sinceDate:self];
}

// 在参照日期的基础上增加多少天（使用负数来减少天数）
- (NSDate*)dateByAddingDays:(NSInteger)days {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = days;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:kNilOptions];
}

// 在参照日期的基础上增加多少周（使用负数来减少周数）
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.weekOfYear = weeks;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:kNilOptions];
}

// 在参照日期的基础上增加多少月（用负数来减少月数）
- (NSDate*)dateByAddingMonths:(NSInteger)months {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = months;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:kNilOptions];
}

// 在参照日期的基础上增加多少年（用负数来减少年数）
- (NSDate*)dateByAddingYears:(NSInteger)years {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = years;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:kNilOptions];
}

// 比较两个日期之间的差值
- (NSDateComponents *)deltaFromDate:(NSDate *)fromDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unitFlags fromDate:fromDate toDate:self options:NSCalendarWrapComponents];
}

// 比较两个日期之间的差值
- (NSDateComponents *)deltaToDate:(NSDate *)toDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unitFlags fromDate:self toDate:toDate options:NSCalendarWrapComponents];
}

// 比较两个日期之间的差值
+ (NSDateComponents *)deltaFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    return [fromDate deltaToDate:toDate];
}

#pragma mark - 日期格式化

// 根据参数返回指定格式的日期
+ (instancetype)dateWithString:(NSString *)dateString
                        format:(NSString *)formatStr
{
    if (dateString == nil || dateString.length == 0) return nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    formatter.locale = [NSLocale currentLocale];
    
    return [formatter dateFromString:dateString];
}


// 根据参数返回指定格式的日期
+ (instancetype)dateWithString:(NSString *)dateString
                        format:(NSString *)formatStr
                      timeZone:(NSTimeZone *)timeZone
                        locale:(NSLocale *)locale
{
    if (dateString == nil || dateString.length == 0) return nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    formatter.timeZone = timeZone;
    formatter.locale = locale;

    return [formatter dateFromString:dateString];
}

+ (instancetype)dateWithString:(NSString *)dateString
                 dateFormatter:(NSDateFormatter *)dateFormatter
{
    if (dateString == nil || dateString.length == 0) return nil;
    return [dateFormatter dateFromString:dateString];
}


// 根据参数返回指定格式的日期字符串
- (NSString *)stringWithFormat:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    formatter.locale = [NSLocale currentLocale];
    return [formatter stringFromDate:self];
}


// 根据参数返回指定格式的日期字符串
- (NSString *)stringWithFormat:(NSString *)formatStr
                      timeZone:(NSTimeZone *)timeZone
                        locale:(NSLocale *)locale
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    formatter.timeZone = timeZone;
    formatter.locale = locale;

    return [formatter stringFromDate:self];
}

// 根据参数返回指定格式的日期字符串
- (NSString *)stringWithDateFormatter:(NSDateFormatter *)dateFormatter
{
    return [dateFormatter stringFromDate:self];
}

// yyyy
- (NSString *)stringWithISO8601YearFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter ISO8601DateFormatterWithYear]];
}

// MM
- (NSString *)stringWithISO8601MonthFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter ISO8601DateFormatterWithMonth]];
}

// yyyy-MM
- (NSString *)stringWithISO8601YearAndMonthFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter ISO8601DateFormatterWithYearAndMonth]];
}

// dd
- (NSString *)stringWithISO8601DayFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter ISO8601DateFormatterWithDay]];
}

// MM-dd
- (NSString *)stringWithISO8601MonthAndDayFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter ISO8601DateFormatterWithMonthAndDay]];
}

// yyyy-MM-dd
- (NSString *)stringWithISO8601FullDateFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter ISO8601DateFormatterWithFullDate]];
}

// HH:mm:ss
- (NSString *)stringWithISO8601FullTimeFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter ISO8601DateFormatterWithFullTime]];
}

// yyyy-MM-dd HH:mm:ss
- (NSString *)stringWithISO8601FullDateAndTimeFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter ISO8601DateFormatterWithFullDateAndTime]];
}

// yyyy-MM-dd'T'HH:mm:ssZ
- (NSString *)stringWithISO8601InternetDateTimeFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter ISO8601DateFormatterWithInternetDateTime]];
}

// yyyy-M-d H:mm
- (NSString *)stringWithShortCommonFormat
{
    return [self stringWithDateFormatter:[NSDateFormatter shortCommonFormat]];
}

// yyyy年M月
- (NSString *)stringWithYearAndMonthFormatOnChinese
{
    return [self stringWithDateFormatter:[NSDateFormatter yearAndMonthFormatOnChinese]];
}

// yyyy年M月d日
- (NSString *)stringWithYearMonthAndDayFormatOnChinese
{
    return [self stringWithDateFormatter:[NSDateFormatter yearMonthAndDayFormatOnChinese]];
}

// M月d日
- (NSString *)stringWithMonthAndDayFormatOnChinese
{
    return [self stringWithDateFormatter:[NSDateFormatter monthAndDayFormatOnChinese]];
}

// a h:mm
- (NSString *)stringWithHourAndMinuteFormatOnChinese
{
    return [self stringWithDateFormatter:[NSDateFormatter hourAndMinuteFormatOnChinese]];
}

/**
 * 将日期转为指定格式的字符串
 * 格式如下:
 *  今年
 *    今天
 *      1分钟内
 *          刚刚
 *      1小时内
 *          xx分钟前
 *      大于1小时
 *          xx小时前
 *    昨天
 *      昨天 18:56:34
 *    早于昨天, 根据参数 showThisYear 是否显示年份
 *      1月23日 19:56:23 或 2016年1月23日 19:56:23
 * 非今年
 *    2015年2月8日 18:45:30
 */
- (NSString *)stringWithCommonFormatAndShowThisYear:(BOOL)showThisYear {
    // 今天
    if (self.isToday) {
        NSDateComponents *cmps = [NSDate deltaFromDate:self toDate:[NSDate  date]];
        if (cmps.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
        } else if (cmps.minute >= 1) {
            return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
        } else if (cmps.second >= 0) {
            return @"刚刚";
        }
    }
    
    NSString *formatStr;
    if (self.isYesterday) {
        formatStr = @"昨天 HH:mm";
    } else if (self.isThisYear && (showThisYear == NO)) {
        formatStr = @"M月d日 HH:mm";
    } else {
        formatStr = @"yyyy年M月d日 HH:mm:ss";
    }
    return [self stringWithFormat:formatStr];
}

@end


