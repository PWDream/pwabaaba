//
//  RongCloudIMConfig.h
//  Abaaba
//
//  Created by 潘威 on 2018/9/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RongCloudIMConfig : NSObject

+ (RongCloudIMConfig *)shareInstance;

- (void)configAppKey;

- (void)configSDK;

@end
