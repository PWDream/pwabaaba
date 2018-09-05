//
//  NSObject+Aba.m
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "NSObject+Aba.h"

@implementation NSObject (AbaJson)

- (NSString *)JSONStringWithOptions:(NSJSONWritingOptions)options error:(NSError **)error
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:options error:error];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end

@implementation NSArray (AbaJson)

- (NSString *)JSONString
{
    return [self JSONStringWithOptions:0 error:nil];
}

@end

@implementation NSDictionary (AbaJson)

- (NSString *)AbaJSONString
{
    NSError *err;
    NSData *jsonData = [NSJSONSerialization  dataWithJSONObject:self options:0 error:&err];
    return  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    return [self JSONStringWithOptions:0 error:nil];
}

@end

@implementation NSString (AbaJson)

- (id)objectFromJSONString
{
    return [self objectFromJSONStringWithOptions:0];
}

- (id)objectFromJSONStringWithOptions:(NSJSONReadingOptions)options
{
    return [self objectFromJSONStringWithOptions:options error:nil];
}

- (id)objectFromJSONStringWithOptions:(NSJSONReadingOptions)options error:(NSError * __autoreleasing*)error
{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:options error:error];
}

@end
