//
//  DiscoverModel.h
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSArray *banner;
@property (nonatomic, strong) NSArray *content;
@end

@interface BannerItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *large_img;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *mini_img;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *published_time;
@property (nonatomic, assign) NSInteger type;

@end

@interface DiscoverModel (JSON)

@end
