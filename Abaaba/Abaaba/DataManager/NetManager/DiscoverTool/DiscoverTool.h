//
//  DiscoverTool.h
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABABaseResponse.h"
@class DiscoverModel;

@interface DiscoverTool : NSObject

+ (void)getDiscoverContent:(NSDictionary *)params finished:(void(^)(DiscoverModel *result, NSError *error))finished;

@end
