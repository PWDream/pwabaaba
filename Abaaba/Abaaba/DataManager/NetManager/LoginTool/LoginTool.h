//
//  LoginTool.h
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABABaseResponse.h"

@interface LoginTool : NSObject

+ (void)checkPhoneNum:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished;

+ (void)getCaptcha:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished;

+ (void)checkCaptcha:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished;

+ (void)registerUser:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished;

+ (void)login:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished;

+ (void)getToken:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished;

@end
