//
//  DiscoverTableViewCell.h
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"

@interface DiscoverTableViewCell : UITableViewCell

@property (nonatomic, strong) BannerItem *item;

+ (DiscoverTableViewCell *)discoverCell;
+ (CGFloat)cellHieght;

@end
