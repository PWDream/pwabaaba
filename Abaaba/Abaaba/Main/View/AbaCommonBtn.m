//
//  AbaCommonBtn.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaCommonBtn.h"

#define KBtnImageScale 0.6

@implementation AbaCommonBtn

- (id)init
{
    if (self = [super init]) {
        //图片居中
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;

        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

        //文字的颜色
        [self setTitleColor:AbaColorWithAlpha(0x7b7b7b, 1) forState:UIControlStateNormal];

        //设置字体的颜色
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setCommItem:(AbaCommonBtnObject *)commItem
{
    _commItem = commItem;

    [self setTitle:commItem.title forState:UIControlStateNormal];
    [self setImage:[UIImage imageWithName:commItem.image] forState:UIControlStateNormal];
    //    [self setImage:[UIImage imageWithName:commItem.selectImage] forState:UIControlStateHighlighted];
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width;
    CGFloat h = self.height * KBtnImageScale;
    return CGRectMake(x, y, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 0;
    CGFloat y = self.height * KBtnImageScale;;
    CGFloat w = self.width;
    CGFloat h = self.height - y;
    return CGRectMake(x, y, w, h);
}

@end
