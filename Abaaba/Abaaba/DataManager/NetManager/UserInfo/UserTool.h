//
//  UserTool.h
//  Abaaba
//
//  Created by PW on 2018/8/18.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABABaseResponse.h"

@interface UserTool : NSObject

+ (void)getUserInfo:(NSDictionary *)params finished:(void(^)(ABABaseResponse *result, NSError *error))finished;

@end
