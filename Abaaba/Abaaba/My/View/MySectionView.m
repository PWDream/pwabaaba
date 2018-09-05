//
//  MySectionView.m
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "MySectionView.h"
#import "SettingItemView.h"

@implementation MySectionView

- (instancetype)initWithFrame:(CGRect)frame sections:(NSArray *)sections{
    MySectionView *sectionView = [[MySectionView alloc] initWithFrame:frame];
    for(NSInteger index = 0;index < sections.count;index ++){
        NSDictionary *dic = sections[index];
        SettingItemView *itemView = [SettingItemView settingItemView];
        itemView.frame = CGRectMake(0, index * 50, frame.size.width, 50);
        itemView.itemDic = dic;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:sectionView action:@selector(itemClicked:)];
        itemView.userInteractionEnabled = YES;
        [itemView addGestureRecognizer:tap];
        [sectionView addSubview:itemView];
    }
    sectionView.userInteractionEnabled = YES;
    return sectionView;
}

- (void)itemClicked:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    SettingItemView *itemView = (SettingItemView *)tap.view;
    if([self.delegate respondsToSelector:@selector(sectionItemClicked:)]){
        NSInteger key = [itemView.itemDic[@"key"] integerValue];
        [self.delegate sectionItemClicked:key];
    }
}


@end
