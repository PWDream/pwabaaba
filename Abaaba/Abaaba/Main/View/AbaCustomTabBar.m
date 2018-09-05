//
//  AbaCustomTabBar.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaCustomTabBar.h"
#import "AbaBarButton.h"

@interface AbaCustomTabBar()

//按钮数组
@property (nonatomic, strong) NSMutableArray *barBtns;

//上一个选中的按钮
@property (nonatomic, strong) AbaBarButton *lastSelectedBtn;

@end

@implementation AbaCustomTabBar

- (NSMutableArray *)barBtns
{
    if (!_barBtns) {
        self.barBtns = [NSMutableArray array];
    }
    return _barBtns;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBg];
    }
    return self;
}

//设置背景颜色
- (void)setBg
{
    self.backgroundColor = [UIColor whiteColor];
}

//设置按钮
- (void)addBarButton:(UITabBarItem *)item
{
    AbaBarButton *btn = [[AbaBarButton alloc] init];
    btn.item = item;
    btn.tag = self.barBtns.count;
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    [self.barBtns addObject:btn];
    [self addSubview:btn];

    if (self.barBtns.count == 1) {
        [self btnClicked:btn];
    }

}

- (void)btnClicked:(AbaBarButton *)btn
{

    if ([_delegate respondsToSelector:@selector(tabBarClicked:from:to:)]) {
        [_delegate tabBarClicked:self from:_lastSelectedBtn.tag to:btn.tag];
    }

    _lastSelectedBtn.selected = NO;

    btn.selected = YES;

    _lastSelectedBtn = btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

//    //添加按钮
//    NSInteger btnCount = self.barBtns.count;
//    CGFloat w = self.width/ btnCount;
//    CGFloat h = self.height;
//    CGFloat y = 0;
//    for (NSInteger index = 0; index < btnCount; index++)
//    {
//        AbaBarButton *btn = _barBtns[index];
//        CGFloat x = index*w;
//        btn.frame = CGRectMake(x, y, w, h);
//    }
}

@end
