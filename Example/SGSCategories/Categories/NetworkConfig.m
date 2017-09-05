/*!
 @header NetworkConfig.m
  
 @author Created by Lee on 16/9/19.
 
 @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NetworkConfig.h"

@implementation NetworkConfig

+ (id  _Nullable (^)(NSURLResponse * _Nonnull, id _Nullable))ldytResponseFilter {
    return ^id(NSURLResponse *response, NSData *data) {
        if ((data == nil) || (data.length == 0)) return nil;
        
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error != nil) return error;
        
        NSInteger state = [[json objectForKey:@"code"] integerValue];
        if (state != 200) {
            NSString *desc = [json objectForKey:@"description"];
            return errorWithCode(state, desc);;
        }
        
        return [json objectForKey:@"results"];
    };
}

@end
