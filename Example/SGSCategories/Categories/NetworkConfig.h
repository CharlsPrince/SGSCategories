/*!
 @header NetworkConfig.h
 
 @abstract
 
 @author Created by Lee on 16/9/19.
 
 @copyright 2016年 SouthGIS. All rights reserved.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static inline NSError * errorWithCode(NSInteger code, NSString *failedReason) {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:failedReason, NSLocalizedDescriptionKey, nil];
    
    return [NSError errorWithDomain:@"com.southgis.iMobile.categoriesExample.error" code:code userInfo:userInfo];
}


@interface NetworkConfig : NSObject

/*!
 *  @brief 湖南领导用图请求结果过滤
 */
+ (id _Nullable(^)(NSURLResponse *response, id _Nullable json))ldytResponseFilter;

@end

NS_ASSUME_NONNULL_END
