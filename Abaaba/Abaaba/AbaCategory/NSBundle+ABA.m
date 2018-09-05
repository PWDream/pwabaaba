//
//  NSBundle+ABA.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "NSBundle+ABA.h"

@implementation NSBundle (ABA)

+ (NSString *)mainBundleShortVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end
