/*!
 *  @header NSURL+SGS.m
 *
 *  @author Created by Lee on 16/9/19.
 *
 *  @copyright 2016年 SouthGIS. All rights reserved.
 */

#import "NSURL+SGS.h"

@interface p_QueryItem : NSObject
+ (instancetype)queryItemWithName:(id)name value:(id)value;
- (NSString *)nameValuePairString;
@end

@implementation p_QueryItem {
    id _name;
    id _value;
}

+ (instancetype)queryItemWithName:(id)name value:(id)value {
    p_QueryItem *item = [[p_QueryItem alloc] init];
    item->_name = name;
    item->_value = value;
    return item;
}

- (NSString *)nameValuePairString {
    if ((_value == nil) || [_value isEqual:[NSNull null]]) {
        return [_name description];
    } else {
        return [NSString stringWithFormat:@"%@=%@", [_name description], [_value description]];
    }
}

@end



@implementation NSURL (SGS)

+ (instancetype)URLWithString:(NSString *)URLString parameters:(NSDictionary *)parameters {
    NSURL *url = [NSURL URLWithString:URLString];
    url = [url URLByAppendingQueryWithParameters:parameters];
    
    return url;
}

+ (instancetype)URLWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL parameters:(NSDictionary *)parameters {
    NSURL *url = [NSURL URLWithString:URLString relativeToURL:baseURL];
    url = [url URLByAppendingQueryWithParameters:parameters];
    
    return url;
}

- (NSURL *)URLByAppendingQueryWithParameters:(NSDictionary *)parameters {
    if (parameters == nil) return self;
    
    NSURL *result = self;
    NSString *query = [NSURL queryStringFromParameters:parameters];
    if ((query != nil) && (query.length > 0)) {
        result = [NSURL URLWithString:[self.absoluteString stringByAppendingFormat:self.query ? @"&%@" : @"?%@", query]];
    }
    
    return result;
}

+ (NSString *)queryStringFromParameters:(NSDictionary *)parameters {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    NSArray *queryStringPairs = [self p_queryStringPairsFromKey:nil value:parameters];
    for (p_QueryItem *pair in queryStringPairs) {
        [mutablePairs addObject:[pair nameValuePairString]];
    }
    
    NSString *queryString = [mutablePairs componentsJoinedByString:@"&"];
    
    return [queryString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSArray *)p_queryStringPairsFromKey:(NSString *)key value:(id)value {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = dictionary[nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:[self p_queryStringPairsFromKey:(key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey) value:nestedValue]];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:[self p_queryStringPairsFromKey:[NSString stringWithFormat:@"%@[]", key] value:nestedValue]];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:[self p_queryStringPairsFromKey:key value:obj]];
        }
    } else {
        [mutableQueryStringComponents addObject:[p_QueryItem queryItemWithName:key value:value]];
    }
    
    return mutableQueryStringComponents;
}

@end
