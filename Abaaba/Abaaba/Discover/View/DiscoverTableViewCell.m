//
//  DiscoverTableViewCell.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DiscoverTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end

@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (DiscoverTableViewCell *)discoverCell{
    return [DiscoverTableViewCell aba_createViewXibName:@"DiscoverTableViewCell"];
}

- (void)setItem:(BannerItem *)item{
    _item = item;
    [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:item.mini_img] placeholderImage:nil];
    self.titleLable.text = item.title;
    self.contentLable.text = item.introduction;
    self.titleLable.text = [NSString stringWithFormat:@"发布时间：%@",item.published_time];
}

+ (CGFloat)cellHieght{
    return 100;
}

@end
