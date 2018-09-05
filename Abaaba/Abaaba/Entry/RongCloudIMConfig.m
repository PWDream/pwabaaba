//
//  RongCloudIMConfig.m
//  Abaaba
//
//  Created by 潘威 on 2018/9/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "RongCloudIMConfig.h"
#import <RongIMKit/RongIMKit.h>


#if defined(DEBUG)
#define RONGCLOUD_IM_APPKEY @"ik1qhw09ipt2p"
#else
#define RONGCLOUD_IM_APPKEY @"ik1qhw09ipt2p"
#endif

static RongCloudIMConfig *rongCloudIMConfig;

@implementation RongCloudIMConfig

+(RongCloudIMConfig *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rongCloudIMConfig = [[RongCloudIMConfig alloc]init];
    });
    return rongCloudIMConfig;
}

- (void)configAppKey
{
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
}

- (void)configSDK
{
    
    
}

@end
