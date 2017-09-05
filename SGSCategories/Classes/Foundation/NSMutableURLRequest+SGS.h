/*!
 *  @header NSMutableURLRequest+SGS.h
 *
 *  @abstract NSMutableURLRequest 扩展
 *
 *  @author Created by Lee on 16/9/19.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SGSHTTPMethod) {
    SGSHTTPMethodGET,
    SGSHTTPMethodPOST,
    SGSHTTPMethodHEAD,
    SGSHTTPMethodPUT,
    SGSHTTPMethodPATCH,
    SGSHTTPMethodDELETE
};

NS_ASSUME_NONNULL_BEGIN


/*!
 *  @brief NSMutableURLRequest 扩展
 */
@interface NSMutableURLRequest (SGS)

#pragma mark - HTTP
///-----------------------------------------------------------------------------
/// @name HTTP
///-----------------------------------------------------------------------------

/*!
 *  @brief 以 application/x-www-form-urlencoded 编码形式初始化 HTTP 请求
 *
 *  @discussion 默认字符集使用 UTF-8，
 *      query 将根据 HTTP Method 判断是拼接在请求地址之后还是放在请求体中，
 *      默认使用 NSURLRequestUseProtocolCachePolicy 缓存策略，默认请求超时时长为60秒
 *
 *  @param method     HTTP 请求方法
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *
 *  @return NSMutableURLRequest
 */
+ (instancetype)httpRequestWithMethod:(SGSHTTPMethod)method
                            URLString:(NSString *)URLString
                           parameters:(nullable NSDictionary *)parameters;

/*!
 *  @brief 以 application/x-www-form-urlencoded 编码形式初始化 HTTP 请求
 *
 *  @param method                  HTTP 请求方法
 *  @param URLString               请求地址
 *  @param parameters              请求参数
 *  @param encoding                编码允许的字符集
 *  @param encodingParametersInURI 是否将请求参数拼接在请求地址中
 *  @param cachePolicy             缓存策略
 *  @param timeoutInterval         超时时长，单位：秒
 *
 *  @return NSMutableURLRequest
 */
+ (instancetype)httpRequestWithMethod:(SGSHTTPMethod)method
                            URLString:(NSString *)URLString
                           parameters:(nullable NSDictionary *)parameters
                       stringEncoding:(NSStringEncoding)encoding
              encodingParametersInURI:(BOOL)encodingParametersInURI
                          cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                      timeoutInterval:(NSTimeInterval)timeoutInterval;

/*!
 *  @brief 以 application/json 编码形式初始化 HTTP 请求
 *
 *  @discussion 默认 JSON 编码使用 kNilOptions，
 *      query 将根据 HTTP Method 判断是拼接在请求地址之后还是放在请求体中，
 *      默认使用 NSURLRequestUseProtocolCachePolicy 缓存策略，默认请求超时时长为60秒
 *
 *  @param method     HTTP 请求方法
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *
 *  @return NSMutableURLRequest
 */
+ (instancetype)jsonRequestWithMethod:(SGSHTTPMethod)method
                            URLString:(NSString *)URLString
                           parameters:(nullable id)parameters;

/*!
 *  @brief 以 application/json 编码形式初始化 HTTP 请求
 *
 *  @param method                  HTTP 请求方法
 *  @param URLString               请求地址
 *  @param parameters              请求参数
 *  @param writingOptions          JSON 编码形式
 *  @param encodingParametersInURI 是否将请求参数拼接在请求地址中
 *  @param cachePolicy             缓存策略
 *  @param timeoutInterval         超时时长，单位：秒
 *
 *  @return NSMutableURLRequest
 */
+ (instancetype)jsonRequestWithMethod:(SGSHTTPMethod)method
                            URLString:(NSString *)URLString
                           parameters:(nullable id)parameters
                       writingOptions:(NSJSONWritingOptions)writingOptions
              encodingParametersInURI:(BOOL)encodingParametersInURI
                          cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                      timeoutInterval:(NSTimeInterval)timeoutInterval;

/*!
 *  @brief 以 application/x-plist 编码形式初始化 HTTP 请求
 *
 *  @discussion 默认使用 XML 格式，编码使用 kNilOptions，
 *      query 将根据 HTTP Method 判断是拼接在请求地址之后还是放在请求体中，
 *      默认使用 NSURLRequestUseProtocolCachePolicy 缓存策略，默认请求超时时长为60秒
 *
 *  @param method     HTTP 请求方法
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *
 *  @return NSMutableURLRequest
 */
+ (instancetype)plistRequestWithMethod:(SGSHTTPMethod)method
                             URLString:(NSString *)URLString
                            parameters:(nullable id)parameters;

/*!
 *  @brief 以 application/x-plist 编码形式初始化 HTTP 请求
 *
 *  @param method                  HTTP 请求方法
 *  @param URLString               请求地址
 *  @param parameters              请求参数
 *  @param format                  plist 格式
 *  @param writingOptions          plist 编码形式
 *  @param encodingParametersInURI 是否将请求参数拼接在请求地址中
 *  @param cachePolicy             缓存策略
 *  @param timeoutInterval         超时时长，单位：秒
 *
 *  @return NSMutableURLRequest
 */
+ (instancetype)plistRequestWithMethod:(SGSHTTPMethod)method
                             URLString:(NSString *)URLString
                            parameters:(nullable id)parameters
                           plistFormat:(NSPropertyListFormat)format
                        writingOptions:(NSPropertyListWriteOptions)writingOptions
               encodingParametersInURI:(BOOL)encodingParametersInURI
                           cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                       timeoutInterval:(NSTimeInterval)timeoutInterval;


/*!
 *  @brief 在请求头中设置认证用户名和密码，内部默认进行 Base-64 编码
 *
 *  @param username 用户名
 *  @param password 密码
 */
- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username
                                       password:(NSString *)password;

/*!
 *  @brief 清除请求头中的认证用户名和密码
 */
- (void)clearAuthorizationHeader;

@end

NS_ASSUME_NONNULL_END