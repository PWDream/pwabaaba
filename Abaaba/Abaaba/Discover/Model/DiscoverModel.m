//
//  DiscoverModel.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel

@end


@implementation BannerItem

@end

@implementation DiscoverModel (JSON)

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"banner":[BannerItem  class],
             @"content":[BannerItem class],};
}

@end

