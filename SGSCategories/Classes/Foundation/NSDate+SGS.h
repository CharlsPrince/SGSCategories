/*!
 *  @header NSDate+SGS.h
 *
 *  @abstract NSDate 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 常用属性、日期格式化、日期比较等扩展
 */
@interface NSDate (SGS)

#pragma mark - 常用属性
///-----------------------------------------------------------------------------
/// @name 常用属性
///-----------------------------------------------------------------------------

@property (nonatomic, assign, readonly) NSInteger era;          //! 年代
@property (nonatomic, assign, readonly) NSInteger year;         //! 年份
@property (nonatomic, assign, readonly) NSInteger month;        //! 月份 (1~12)
@property (nonatomic, assign, readonly) NSInteger day;          //! 天 (1~31)
@property (nonatomic, assign, readonly) NSInteger hour;         //! 小时 (0~23)
@property (nonatomic, assign, readonly) NSInteger minute;       //! 分 (0~59)
@property (nonatomic, assign, readonly) NSInteger second;       //! 秒 (0~59)
@property (nonatomic, assign, readonly) NSInteger nanosecond;   //! 纳秒
@property (nonatomic, assign, readonly) NSInteger weekday;      //! 星期 (1~7)，如果系统设置以星期天为一个星期的起始，那么 “1” 代表星期天
@property (nonatomic, assign, readonly) NSInteger weekdayOrdinal;    //! 该月中的第几个周x (x为该日期的星期x)
@property (nonatomic, assign, readonly) NSInteger weekOfMonth;       //! 该月份的第几周 (1~5)
@property (nonatomic, assign, readonly) NSInteger weekOfYear;        //! 该年的第几周 (1~53)
@property (nonatomic, assign, readonly) NSInteger yearForWeekOfYear; //! 返回该日期的周的所在年份
@property (nonatomic, assign, readonly) NSInteger quarter;           //! 当前年中的第几个季度

@property (nonatomic, assign, readonly) NSUInteger weeklyOrdinality;  //! 该月的第一天是星期几
@property (nonatomic, assign, readonly) NSUInteger numberOfDaysInThisMonth; //! 计算当月有多少天
@property (nonatomic, assign, readonly) NSUInteger numberOfWeeksInThisMonth; //! 计算当月有多少周

@property (nonatomic, assign, readonly) BOOL isLeapMonth;   //! 是否是闰月
@property (nonatomic, assign, readonly) BOOL isLeapYear;    //! 是否是闰年
@property (nonatomic, assign, readonly) BOOL isToday;       //! 判断日期是否是今天
@property (nonatomic, assign, readonly) BOOL isTomorrow;    //! 判断日期是否是明天
@property (nonatomic, assign, readonly) BOOL isYesterday;   //! 判断日期是否是昨天
@property (nonatomic, assign, readonly) BOOL isThisYear;    //! 判断时期是否是今年


#pragma mark - 日期比较与增减
///-----------------------------------------------------------------------------
/// @name 日期比较与增减
///-----------------------------------------------------------------------------

/*!
 *  @brief 获取当前时间戳
 *
 *  @return 当前时间戳
 */
+ (NSTimeInterval)currentTimeStamp;

/*!
 *  @brief 返回明天此刻的日期
 *
 *  @return 明天此刻的 NSDate
 */
+ (instancetype)tomorrow;

/*!
 *  @brief 返回昨天此刻的日期
 *
 *  @return 昨天此刻的 NSDate
 */
+ (instancetype)yesterday;

/*!
 *  @brief 当月的第一天
 *
 *  @return 当月的第一天 NSDate
 */
- (NSDate *)firstDayInThisMonth;

/*!
 *  @brief 当月的最后一天
 *
 *  @return 当月的最后一天 NSDate
 */
- (NSDate *)lastDayInThisMonth;

/*!
 *  @brief 上一个月的这一天
 *
 *  @return 上一个月的这一天，如果上个月没有这一天返回 `nil` ，例如日期为 7月31日 该方法将返回 nil
 */
- (nullable NSDate *)dayInPreviousMonth;

/*!
 *  @brief 下一个月的这一天
 *
 *  @return 下一个月的这一天，如果下个月没有这一天返回 `nil`，例如日期为 8月31日 该方法将返回 nil
 */
- (nullable NSDate *)dayInNextMonth;

/*!
 *  @brief 与另一个日期判断是否是同一天
 *
 *  @discussion 该方法只比较年月日
 *
 *  @param date 参考日期
 *
 *  @return `YES` 是同一天； `NO` 不是同一天
 */
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)date;

/*!
 *  @brief 在参照日期的基础上增加多少秒（使用负数来减少）
 *
 *  @param seconds 增加或减少的时间
 *
 *  @return 增加后的 NSDate
 */
- (NSDate*)dateByAddingSeconds:(NSTimeInterval)seconds;

/*!
 *  @brief 在参照日期的基础上增加多少分钟（使用负数来减少）
 *
 *  @param minutes 增加或减少的时间
 *
 *  @return 增加后的 NSDate
 */
- (NSDate*)dateByAddingMinutes:(NSInteger)minutes;

/*!
 *  @brief 在参照日期的基础上增加多少小时（使用负数来减少）
 *
 *  @param hours 增加或减少的时间
 *
 *  @return 增加后的 NSDate
 */
- (NSDate*)dateByAddingHours:(NSInteger)hours;

/*!
 *  @brief 在参照日期的基础上增加多少天（使用负数来减少天数）
 *
 *  @param days 增加或减少的天数
 *
 *  @return 增加后的 NSDate
 */
- (NSDate*)dateByAddingDays:(NSInteger)days;

/*!
 *  @brief 在参照日期的基础上增加多少周（使用负数来减少周数）
 *
 *  @param days 增加或减少的周数
 *
 *  @return 增加后的 NSDate
 */
- (NSDate*)dateByAddingWeeks:(NSInteger)weeks;

/*!
 *  @brief 在参照日期的基础上增加多少月（用负数来减少月数）
 *
 *  @param days 增加或减少的月数
 *
 *  @return 增加后的 NSDate
 */
- (NSDate*)dateByAddingMonths:(NSInteger)months;

/*!
 *  @brief 在参照日期的基础上增加多少年（用负数来减少年数）
 *
 *  @param days 增加或减少的年数
 *
 *  @return 增加后的 NSDate
 */
- (NSDate*)dateByAddingYears:(NSInteger)years;

/*!
 *  @brief 比较当前日期和参考日期的差值
 *
 *  @param fromDate 要减的日期
 *
 *  @return 日期差值 NSDateComponents
 */
- (NSDateComponents *)deltaFromDate:(NSDate *)fromDate;

/*!
 *  @brief 比较当前日期和参考日期的差值
 *
 *  @param toDate 被减日期
 *
 *  @return 日期差值 NSDateComponents
 */
- (NSDateComponents *)deltaToDate:(NSDate *)toDate;

/*!
 *  @brief 比较两个日期之间的差值
 *
 *  @param fromDate 要减的日期
 *  @param toDate   被减日期
 *
 *  @return 日期差值 NSDateComponents
 */
+ (NSDateComponents *)deltaFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;


#pragma mark - 日期格式化
///-----------------------------------------------------------------------------
/// @name 日期格式化
///-----------------------------------------------------------------------------

/*!
 *  @brief 根据参数返回指定格式的日期
 *
 *  @param dateString 日期字符串
 *  @param formatStr  日期格式字符串
 *
 *  @return NSDate or nil
 */
+ (nullable instancetype)dateWithString:(NSString *)dateString
                                 format:(NSString *)formatStr;

/*!
 *  @brief 根据参数返回指定格式的日期
 *
 *  @param dateString 日期字符串
 *  @param formatStr  日期格式字符串
 *  @param timeZone   时区
 *  @param locale     地区
 *
 *  @return NSDate or nil
 */
+ (nullable instancetype)dateWithString:(NSString *)dateString
                                 format:(NSString *)formatStr
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;

/*!
 *  @brief 根据参数返回指定格式的日期
 *
 *  @param dateString    日期字符串
 *  @param dateFormatter 日期格式
 *
 *  @return NSDate or nil
 */
+ (nullable instancetype)dateWithString:(NSString *)dateString
                          dateFormatter:(NSDateFormatter *)dateFormatter;

/*!
 *  @brief 根据参数返回指定格式的日期字符串
 *
 *  @param formatStr 指定的日期格式字符串
 *
 *  @return 指定格式的日期字符串
 */
- (NSString *)stringWithFormat:(NSString *)formatStr;

/*!
 *  @brief 根据参数返回指定格式的日期字符串
 *
 *  @param formatStr 指定的日期格式字符串
 *  @param timeZone  时区
 *  @param locale    地区
 *
 *  @return 指定格式的日期字符串
 */
- (NSString *)stringWithFormat:(NSString *)formatStr
                      timeZone:(nullable NSTimeZone *)timeZone
                        locale:(nullable NSLocale *)locale;

/*!
 *  @brief 根据参数返回指定格式的日期字符串
 *
 *  @param dateFormatter 指定的日期格式
 *
 *  @return 指定格式的日期字符串
 */
- (NSString *)stringWithDateFormatter:(NSDateFormatter *)dateFormatter;

/*!
 *  @brief 返回 `yyyy` 格式的年份字符串
 *
 *  @return 返回 `yyyy` 格式的年份字符串
 */
- (NSString *)stringWithISO8601YearFormat;

/*!
 *  @brief 返回 `MM` 格式的月份字符串
 *
 *  @return 返回 `MM` 格式的月份字符串
 */
- (NSString *)stringWithISO8601MonthFormat;

/*!
 *  @brief 返回 `yyyy-MM` 格式的日期字符串
 *
 *  @return 返回 `yyyy-MM` 格式的日期字符串
 */
- (NSString *)stringWithISO8601YearAndMonthFormat;

/*!
 *  @brief 返回 `dd` 格式的日期字符串
 *
 *  @return 返回 `dd` 格式的日期字符串
 */
- (NSString *)stringWithISO8601DayFormat;

/*!
 *  @brief 返回 `MM-dd` 格式的日期字符串
 *
 *  @return 返回 `MM-dd` 格式的日期字符串
 */
- (NSString *)stringWithISO8601MonthAndDayFormat;

/*!
 *  @brief 返回 `yyyy-MM-dd` 格式的日期字符串
 *
 *  @return 返回 `yyyy-MM-dd` 格式的日期字符串
 */
- (NSString *)stringWithISO8601FullDateFormat;

/*!
 *  @brief 返回 `HH:mm:ss` 格式的时间字符串
 *
 *  @return 返回 `HH:mm:ss` 格式的时间字符串
 */
- (NSString *)stringWithISO8601FullTimeFormat;

/*!
 *  @brief 返回 `yyyy-MM-dd HH:mm:ss` 格式的日期字符串
 *
 *  @return 返回 `yyyy-MM-dd HH:mm:ss` 格式的日期字符串
 */
- (NSString *)stringWithISO8601FullDateAndTimeFormat;

/*!
 *  @brief 返回 `yyyy-MM-dd'T'HH:mm:ssZ` 格式的日期字符串
 *
 *  @return 返回 `yyyy-MM-dd'T'HH:mm:ssZ` 格式的日期字符串
 */
- (NSString *)stringWithISO8601InternetDateTimeFormat;

/*!
 *  @brief 返回 `yyyy-M-d H:mm` 格式的日期字符串
 *
 *  @return 返回 `yyyy-M-d H:mm` 格式的日期字符串
 */
- (NSString *)stringWithShortCommonFormat;

/*!
 *  @brief 返回 `yyyy年M月` 格式的日期字符串
 *
 *  @return 返回 `yyyy年M月` 格式的日期字符串
 */
- (NSString *)stringWithYearAndMonthFormatOnChinese;

/*!
 *  @brief 返回 `yyyy年M月d日` 格式的日期字符串
 *
 *  @return 返回 `yyyy年M月d日` 格式的日期字符串
 */
- (NSString *)stringWithYearMonthAndDayFormatOnChinese;

/*!
 *  @brief 返回 `M月d日` 格式的日期字符串
 *
 *  @return 返回 `M月d日` 格式的日期字符串
 */
- (NSString *)stringWithMonthAndDayFormatOnChinese;

/*!
 *  @brief 返回 `a h:mm` 格式的时间字符串
 *
 *  @return 返回 `a h:mm` 格式的时间字符串
 */
- (NSString *)stringWithHourAndMinuteFormatOnChinese;

/*!
 *  @brief 将日期转为指定格式的字符串
 *
 *  @discussion 格式如下:
 *      今年
 *          今天
 *              1分钟内
 *                  刚刚
 *              1小时内
 *                  xx分钟前
 *              大于1小时
 *                  xx小时前
 *          昨天
 *                  昨天 18:56:34
 *          早于昨天, 根据参数 showThisYear 是否显示年份
 *                  1月23日 19:56:23 或 2016年1月23日 19:56:23
 *      非今年
 *                  2015年2月8日 18:45:30
 *
 *  @param showThisYear 是否显示今年的年份
 *
 *  @return 指定格式的日期字符串
 */
- (NSString *)stringWithCommonFormatAndShowThisYear:(BOOL)showThisYear;

@end



NS_ASSUME_NONNULL_END
