//
//  DiscoverTool.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "DiscoverTool.h"
#import "ABaseRequest.h"
#import "DiscoverModel.h"

@implementation DiscoverTool

+ (void)getDiscoverContent:(NSDictionary *)params finished:(void(^)(DiscoverModel *result, NSError *error))finished{
    ABaseRequest *requset = [ABaseRequest requestWithPath:KDiscoverUrl urlParams:nil bodyParams:params finished:^(ABABaseResponse *response, NSError *error) {
        if (response.responseOrigin) {
            DiscoverModel *model = [DiscoverModel mj_objectWithKeyValues:response.responseOrigin];
            finished(model,error);
        }
    }];
    requset.method = @"GET";
    [requset start];
}

@end
