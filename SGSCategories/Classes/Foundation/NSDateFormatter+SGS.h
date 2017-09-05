/*!
 *  @header NSDateFormatter+SGS.h
 *
 *  @abstract NSDateFormatter 扩展
 *
 *  @author Created by Lee on 16/8/8.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 常用的日期格式扩展
 */
@interface NSDateFormatter (SGS)

/*!
 *  @brief 获取 ISO 8601 标准日期格式的 NSDateFormatter，格式为：yyyy
 *
 *  @discussion 例如：2016
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterWithYear;

/*!
 *  @brief 获取 ISO 8601 标准日期格式的 NSDateFormatter，格式为：MM
 *
 *  @discussion 例如：06
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterWithMonth;

/*!
 *  @brief 获取 ISO 8601 标准日期格式的 NSDateFormatter，格式为：yyyy-MM
 *
 *  @discussion 例如：2016-06
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterWithYearAndMonth;

/*!
 *  @brief 获取 ISO 8601 标准日期格式的 NSDateFormatter，格式为：dd
 *
 *  @discussion 例如：13
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterWithDay;

/*!
 *  @brief 获取 ISO 8601 标准日期格式的 NSDateFormatter，格式为：MM-dd
 *
 *  @discussion 例如：06-13
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterWithMonthAndDay;

/*!
 *  @brief 获取 ISO 8601 标准日期格式的 NSDateFormatter，格式为：yyyy-MM-dd
 *
 *  @discussion 例如：2016-06-13
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterWithFullDate;

/*!
 *  @brief 获取 ISO 8601 标准日期格式的 NSDateFormatter，格式为：HH:mm:ss
 *
 *  @discussion 例如：16:00:00
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterWithFullTime;

/*!
 *  @brief 获取 ISO 8601 标准日期格式的 NSDateFormatter，格式为：yyyy-MM-dd HH:mm:ss
 *
 *  @discussion 例如：2016-06-13 16:00:00
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterWithFullDateAndTime;

/*!
 *  @brief 获取 ISO 8601 标准日期格式的 NSDateFormatter，格式为：yyyy-MM-dd'T'HH:mm:ssZ
 *
 *  @discussion 例如：2016-06-13T16:00:00+08:00
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterWithInternetDateTime;

/*!
 *  @brief 获取常用日期格式的NSDateFormatter，格式为：yyyy-M-d H:mm
 *
 *  @return NSDateFormatter
 */
+ (instancetype)shortCommonFormat;

/*!
 *  @brief 获取常用日期格式的NSDateFormatter，格式为：yyyy年M月
 *
 *  @return NSDateFormatter
 */
+ (instancetype)yearAndMonthFormatOnChinese;

/*!
 *  @brief 获取常用日期格式的NSDateFormatter，格式为：yyyy年M月d日
 *
 *  @return NSDateFormatter
 */
+ (instancetype)yearMonthAndDayFormatOnChinese;

/*!
 *  @brief 获取常用日期格式的NSDateFormatter，格式为：M月d日
 *
 *  @return NSDateFormatter
 */
+ (instancetype)monthAndDayFormatOnChinese;

/*!
 *  @brief 获取常用日期格式的NSDateFormatter，格式为：上午 9:05
 *
 *  @return NSDateFormatter
 */
+ (instancetype)hourAndMinuteFormatOnChinese;

/*!
 *  @brief 获取 ISO 8601 标准格式的 NSDateFormatter
 *
 *  @discussion 根据参数有可能的格式为:
 *    1. yyyy-MM-dd'T'HH:mm:ss+Z
 *    2. yyyy-MM-dd'T'HH:mm:ss
 *    3. yyyy-MM-dd HH:mm:ss+Z
 *    4. yyyy-MM-dd HH:mm:ss
 *
 *    例如：2016-06-13T16:00:00+08:00
 *
 *  @param showTSeparator 是否显示'T'分隔符
 *  @param showTimeZone   是否显示时区
 *
 *  @return NSDateFormatter
 */
+ (instancetype)ISO8601DateFormatterByShowTSeparator:(BOOL)showTSeparator showTimeZone:(BOOL)showTimeZone;

@end

NS_ASSUME_NONNULL_END
