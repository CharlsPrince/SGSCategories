/*!
 *  @header NSNumber+SGS.h
 *
 *  @abstract NSNumber 扩展
 *
 *  @author Created by Lee on 16/4/20.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief 转字符串方法扩展
 */
@interface NSNumber (SGS)

/*!
 *  @brief 根据字符串实例化 NSNumber 对象
 *
 *  @discussion 字符串格式可以为：@"18", @"-0x1F", @"3.14", @" .12e5 ", @"true", 
 *      @"NO", @"nil" 等
 *
 *  @param string 字符串
 *
 *  @return NSNumber or nil
 */
+ (nullable instancetype)numberWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END