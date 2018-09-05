//
//  UserTool.m
//  Abaaba
//
//  Created by PW on 2018/8/18.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UserTool.h"
#import "ABaseRequest.h"

@implementation UserTool

+ (void)getUserInfo:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished
{
    NSString *url = [NSString stringWithFormat:@"%@%@",KGetUserInfo,params[@"userId"]];
    ABaseRequest *requset = [ABaseRequest requestWithPath:url urlParams:nil bodyParams:nil finished:finished];
    requset.method = @"GET";
    [requset start];
}

+ (void)getToken:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished{
    [[ABaseRequest requestWithPath:KTokenUrl urlParams:nil bodyParams:params finished:finished] start];
}

@end
