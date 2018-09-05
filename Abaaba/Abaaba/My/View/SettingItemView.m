//
//  SettingItemView.m
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "SettingItemView.h"

@interface SettingItemView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SettingItemView

+ (SettingItemView *)settingItemView{
    return [[[NSBundle mainBundle] loadNibNamed:@"SettingItemView" owner:nil options:nil] lastObject];;
}

- (void)setItemDic:(NSDictionary *)itemDic{
    _itemDic = itemDic;
    self.iconImageView.image = [UIImage imageNamed:itemDic[@"icon"]];
    self.label.text = itemDic[@"label"];
}

@end
