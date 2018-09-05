//
//  AbaBarButton.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaBarButton.h"

#define KBatBtnImageScale 0.6

@implementation AbaBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //图片居中
        self.imageView.contentMode = UIViewContentModeCenter;

        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

        //文字的颜色
        [self setTitleColor:AbaColorWithAlpha(kBaseTabbarColor,1) forState:UIControlStateSelected];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        //设置字体的颜色
        self.titleLabel.font = [UIFont systemFontOfSize:12];

    }
    return self;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;

    [self setTitle:item.title forState:UIControlStateNormal];

    [self setImage:item.image forState:UIControlStateNormal];

    [self setImage:item.selectedImage forState:UIControlStateSelected];

}



- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width;
    CGFloat h = self.height * KBatBtnImageScale;
    return CGRectMake(x, y, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 0;
    CGFloat y = self.height * KBatBtnImageScale;;
    CGFloat w = self.width;
    CGFloat h = self.height - y;
    return CGRectMake(x, y, w, h);
}

//去除高亮
- (void)setHighlighted:(BOOL)highlighted{ }

@end
