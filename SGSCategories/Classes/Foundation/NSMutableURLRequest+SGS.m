/*!
 *  @header NSMutableURLRequest+SGS.m
 *
 *  @author Created by Lee on 16/9/19.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSMutableURLRequest+SGS.h"
#import "NSURL+SGS.h"

@implementation NSMutableURLRequest (SGS)

#pragma mark - Initialization

+ (instancetype)httpRequestWithMethod:(SGSHTTPMethod)method
                            URLString:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    BOOL encodingParametersInURI = [self p_encodingParametersInURIWithHTTPMethod:method];
    [mutableRequest p_httpSerializingWithMethod:method parameters:parameters stringEncoding:NSUTF8StringEncoding encodingParametersInURI:encodingParametersInURI];
    
    return mutableRequest;
}

+ (instancetype)httpRequestWithMethod:(SGSHTTPMethod)method
                            URLString:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                       stringEncoding:(NSStringEncoding)encoding
              encodingParametersInURI:(BOOL)encodingParametersInURI
                          cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                      timeoutInterval:(NSTimeInterval)timeoutInterval
{
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    
    [mutableRequest p_httpSerializingWithMethod:method parameters:parameters stringEncoding:encoding encodingParametersInURI:encodingParametersInURI];
    
    return mutableRequest;
}

+ (instancetype)jsonRequestWithMethod:(SGSHTTPMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
{
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    BOOL encodingParametersInURI = [self p_encodingParametersInURIWithHTTPMethod:method];
    [mutableRequest p_jsonSerializingWithMethod:method parameters:parameters writingOptions:kNilOptions encodingParametersInURI:encodingParametersInURI];
    
    return mutableRequest;
}

+ (instancetype)jsonRequestWithMethod:(SGSHTTPMethod)method
                            URLString:(NSString *)URLString
                           parameters:(id)parameters
                       writingOptions:(NSJSONWritingOptions)writingOptions
              encodingParametersInURI:(BOOL)encodingParametersInURI
                          cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                      timeoutInterval:(NSTimeInterval)timeoutInterval
{
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    
    [mutableRequest p_jsonSerializingWithMethod:method parameters:parameters writingOptions:writingOptions encodingParametersInURI:encodingParametersInURI];
    
    return mutableRequest;
}

+ (instancetype)plistRequestWithMethod:(SGSHTTPMethod)method
                             URLString:(NSString *)URLString
                            parameters:(id)parameters
{
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    BOOL encodingParametersInURI = [self p_encodingParametersInURIWithHTTPMethod:method];
    [mutableRequest p_plistSerializingWithMethod:method parameters:parameters plistFormat:NSPropertyListXMLFormat_v1_0 writingOptions:kNilOptions encodingParametersInURI:encodingParametersInURI];
    
    return mutableRequest;
}

+ (instancetype)plistRequestWithMethod:(SGSHTTPMethod)method
                             URLString:(NSString *)URLString
                            parameters:(id)parameters
                           plistFormat:(NSPropertyListFormat)format
                        writingOptions:(NSPropertyListWriteOptions)writingOptions
               encodingParametersInURI:(BOOL)encodingParametersInURI
                           cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                       timeoutInterval:(NSTimeInterval)timeoutInterval
{
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    
    [mutableRequest p_plistSerializingWithMethod:method parameters:parameters plistFormat:format writingOptions:writingOptions encodingParametersInURI:encodingParametersInURI];
    
    return mutableRequest;
}


#pragma mark - Authorization

- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username password:(NSString *)password {
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodeStr = [authData base64EncodedStringWithOptions:kNilOptions];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", encodeStr];
    [self setValue:authValue forHTTPHeaderField:@"Authorization"];
}

- (void)clearAuthorizationHeader {
    [self setValue:nil forHTTPHeaderField:@"Authorization"];
}


#pragma mark - Serializing

+ (BOOL)p_encodingParametersInURIWithHTTPMethod:(SGSHTTPMethod)method {
    static NSSet<NSNumber *> *set = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set = [NSSet setWithObjects:@(SGSHTTPMethodGET), @(SGSHTTPMethodHEAD), @(SGSHTTPMethodDELETE), nil];
    });
    
    return [set containsObject:@(method)];
}

- (NSString *)p_HTTPMethod:(SGSHTTPMethod)method {
    switch (method) {
        case SGSHTTPMethodGET:    return @"GET";
        case SGSHTTPMethodPOST:   return @"POST";
        case SGSHTTPMethodHEAD:   return @"HEAD";
        case SGSHTTPMethodPUT:    return @"PUT";
        case SGSHTTPMethodPATCH:  return @"PATCH";
        case SGSHTTPMethodDELETE: return @"DELETE";
        default:                  return @"GET";
    }
}

- (void)p_httpSerializingWithMethod:(SGSHTTPMethod)method
                         parameters:(id)parameters
                     stringEncoding:(NSStringEncoding)encoding
            encodingParametersInURI:(BOOL)encodingParametersInURI
{
    self.HTTPMethod = [self p_HTTPMethod:method];
    
    if (encodingParametersInURI) {
        [self p_serializingWithParametersInURI:parameters];
    } else {
        if (parameters != nil) {
            NSString *query = [NSURL queryStringFromParameters:parameters];
            if (query == nil) query = @"";
            [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [self setHTTPBody:[query dataUsingEncoding:encoding]];
        }
    }
}

- (void)p_jsonSerializingWithMethod:(SGSHTTPMethod)method
                         parameters:(id)parameters
                     writingOptions:(NSJSONWritingOptions)writingOptions
            encodingParametersInURI:(BOOL)encodingParametersInURI
{
    self.HTTPMethod = [self p_HTTPMethod:method];
    
    if (encodingParametersInURI) {
        [self p_serializingWithParametersInURI:parameters];
    } else {
        if (parameters != nil) {
            [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [self setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:writingOptions error:NULL]];
        }
    }
}

- (void)p_plistSerializingWithMethod:(SGSHTTPMethod)method
                          parameters:(id)parameters
                         plistFormat:(NSPropertyListFormat)format
                      writingOptions:(NSPropertyListWriteOptions)writingOptions
             encodingParametersInURI:(BOOL)encodingParametersInURI
{
    self.HTTPMethod = [self p_HTTPMethod:method];
    
    if (encodingParametersInURI) {
        [self p_serializingWithParametersInURI:parameters];
    } else {
        if (parameters != nil) {
            [self setValue:@"application/x-plist" forHTTPHeaderField:@"Content-Type"];
            [self setHTTPBody:[NSPropertyListSerialization dataWithPropertyList:parameters format:format options:writingOptions error:NULL]];
        }
    }
}

- (void)p_serializingWithParametersInURI:(NSDictionary *)parameters {
    if (parameters != nil) {
        self.URL = [self.URL URLByAppendingQueryWithParameters:parameters];
    }
}

@end
