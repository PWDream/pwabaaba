//
//  LoginTool.m
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "LoginTool.h"
#import "LoginRequest.h"

@implementation LoginTool

+ (void)checkPhoneNum:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished{
    [[ABaseRequest requestWithPath:KCheckPhoneAvailableUrl urlParams:nil bodyParams:params finished:finished] start];
}

+ (void)getCaptcha:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished{
    [[ABaseRequest requestWithPath:KSendCodeUrl urlParams:nil bodyParams:params finished:finished] start];
}

+ (void)checkCaptcha:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished{
    [[ABaseRequest requestWithPath:KVerifyCodeUrl urlParams:nil bodyParams:params finished:finished] start];
}

+ (void)registerUser:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished{
    [[ABaseRequest requestWithPath:KRegisterUrl urlParams:nil bodyParams:params finished:finished] start];
}

+ (void)login:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished{
    [[LoginRequest requestWithPath:KLoginUrl urlParams:nil bodyParams:params finished:finished] start];
}

@end
