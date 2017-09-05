/*!
 *  @header NSURL+SGS.h
 *
 *  @abstract NSURL 扩展
 *
 *  @author Created by Lee on 16/9/19.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief NSURL 扩展
 */
@interface NSURL (SGS)

#pragma mark - HTTP
///-----------------------------------------------------------------------------
/// @name HTTP
///-----------------------------------------------------------------------------

/*!
 *  @brief 根据请求地址和请求参数初始化 NSURL
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *
 *  @return NSURL，当 URLString 不合法时将返回 nil
 */
+ (nullable instancetype)URLWithString:(NSString *)URLString
                            parameters:(NSDictionary *)parameters;

/*!
 *  @brief 根据请求地址和基础地址以及请求参数初始化 NSURL
 *
 *  @param URLString  请求地址，例如："file/search"
 *  @param baseURL    基础地址，例如："http://www.example.com/"
 *  @param parameters 请求参数，例如：{"keyword": "abc"}
 *
 *  @return "http://www.example.com/file/search?keyword=abc"
 */
+ (nullable instancetype)URLWithString:(NSString *)URLString
                         relativeToURL:(nullable NSURL *)baseURL
                            parameters:(NSDictionary *)parameters;

/*!
 *  @brief 根据请求参数添加 query
 *
 *  @param parameters 请求参数，例如：{"keyword": "abc"}
 *
 *  @return NSURL
 */
- (NSURL *)URLByAppendingQueryWithParameters:(NSDictionary *)parameters;

/*!
 *  @brief 将请求参数转换为 query 字符串
 *
 *  @param parameters 请求参数，例如：{"keyword": "abc", "filter": "Car"}
 *
 *  @return "keyword=abc&filter=Car"
 */
+ (nullable NSString *)queryStringFromParameters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END