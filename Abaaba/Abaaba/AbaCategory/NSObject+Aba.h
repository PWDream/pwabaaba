//
//  NSObject+Aba.h
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AbaJson)
- (NSString *)JSONStringWithOptions:(NSJSONWritingOptions)options error:(NSError **)error;
@end

@interface NSArray (AbaJson)
- (NSString *)JSONString; //override MJExtentsion JSONString method
@end

@interface NSDictionary (AbaJson)
- (NSString *)AbaJSONString;
@end

@interface NSString (AbaJson)
- (id)objectFromJSONString;
- (id)objectFromJSONStringWithOptions:(NSJSONReadingOptions)options;
- (id)objectFromJSONStringWithOptions:(NSJSONReadingOptions)options error:(NSError * __autoreleasing *)error;
@end
