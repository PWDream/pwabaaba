//
//  AbaNavigationBar.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaNavigationBar.h"

//离左边还有右边屏幕的间距
#define KBtnMargin 8
//按钮的字体
#define KBtnFont [UIFont systemFontOfSize:15]
//标题的字体
#define KTitleFont [UIFont systemFontOfSize:18]
//按钮的最大宽度
#define KBtnMaxW 60

@interface AbaNavigationBar()
/** 中间视图 */
@property (nonatomic, weak) UIView *navTilteView;
/** 右边按钮 */
@property (nonatomic, weak) UIButton *rightBtn;
/** 左边按钮 */
@property (nonatomic, weak) UIButton *leftBtn;
/** 分割线 */
@property (nonatomic, weak) UIView *dividView;
/** 标题 */
@property (nonatomic, weak) UILabel *titlelb;

@end

@implementation AbaNavigationBar

- (UILabel *)titlelb
{
    if (!_titlelb) {
        UILabel *titlelb = [[UILabel alloc] init];
        titlelb.backgroundColor = [UIColor clearColor];
        titlelb.textAlignment = NSTextAlignmentCenter;
        titlelb.font = KTitleFont;
        [self.navTilteView addSubview:titlelb];
        self.titlelb = titlelb;
    }
    return _titlelb;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
/**
 *  设置子视图
 */
- (void)setupView
{
    UIButton *rightBtn = [[UIButton alloc] init];
    [self addSubview:rightBtn];
    self.rightBtn = rightBtn;

    UIButton *leftBtn = [[UIButton alloc] init];
    [self addSubview:leftBtn];
    self.leftBtn = leftBtn;

    UIView *tilteView = [[UIView alloc] init];
    [self addSubview:tilteView];
    self.navTilteView = tilteView;

    UIView *dividView = [[UIView alloc] init];
    dividView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:dividView];
    self.dividView = dividView;
}

/**
 *  设置右边按钮
 */
- (void)setRightBtnObj:(AbaCommonBtnObject *)rightBtnObj
{
    _rightBtnObj = rightBtnObj;

    [self setBtn:self.rightBtn obj:rightBtnObj isLeft:NO];
}
/**
 *  设置左边按钮
 */
- (void)setLeftBtnObj:(AbaCommonBtnObject *)leftBtnObj
{
    _leftBtnObj = leftBtnObj;

    [self setBtn:self.leftBtn obj:leftBtnObj isLeft:YES];
}
/**
 *  设置按钮
 */
- (void)setBtn:(UIButton *)btn obj:(AbaCommonBtnObject *)obj isLeft:(BOOL)isLeft
{
    [btn setTitle:obj.title forState:UIControlStateNormal];
    [btn.titleLabel setFont:KBtnFont];
    if(obj.image)
        [btn setImage:[UIImage imageWithName:obj.image] forState:UIControlStateNormal];
    if(obj.hightImage)
        [btn setImage:[UIImage imageWithName:obj.hightImage] forState:UIControlStateHighlighted];
    if(obj.selectImage)
        [btn setImage:[UIImage imageWithName:obj.selectImage] forState:UIControlStateSelected];

    [btn addTarget:obj.target action:obj.action forControlEvents:UIControlEventTouchUpInside];

    CGFloat btnY = isLeft ? KStatueBarH + 5 : KStatueBarH + 8;
    CGFloat btnW = 35;
    CGFloat btnH = 35;
    CGFloat btnX = isLeft ? (KBtnMargin - 5) : (self.width - btnW - KBtnMargin);

    if (obj.title) {
        CGSize size = [obj.title sizeWithFont:KBtnFont];
        if (size.width > KBtnMaxW) {
            size.width = KBtnMaxW;
        }
        btnX = isLeft ? KBtnMargin : self.width - size.width - KBtnMargin;
        btnW = size.width;
        [btn setTitleColor:obj.titleColor forState:UIControlStateNormal];
    }

    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
}
/**
 *  设置中间视图
 */

- (void)setTitleView:(UIView *)titleView
{
    _titleView = titleView;
    [self.navTilteView addSubview:titleView];
    [self setNeedsLayout];
}

/**
 *  设置标题
 */
- (void)setTitle:(NSString *)title
{
    _title  = title;

    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:KTitleFont}];
    self.titlelb.size = size;
//    [self.titlelb sizeToFit];
    self.titlelb.text = title;
}
/**
 *  设置标题的颜色
 */
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titlelb.textColor = titleColor;
}

/**
 *  分割线
 */
- (void)setHideDivid:(BOOL)hideDivid
{
    _hideDivid = hideDivid;
    self.dividView.hidden = hideDivid;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.height = KNavBarH;
    self.dividView.frame = CGRectMake(0, self.height - 1, self.width, 0.5);

    //设置titleView的位置
    CGFloat titleViewX = KBtnMaxW;
    CGFloat titleViewY = KStatueBarH;
    CGFloat titleViewW = self.width - 2*KBtnMaxW;
    CGFloat titleViewH = self.height - KStatueBarH;
    self.navTilteView.frame = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH);
    //设置tilteView子控件的位置
    for (UIView *view in self.navTilteView.subviews)
    {
        view.centreX = titleViewW/2;
        view.centreY = titleViewH/2;
    }
}

@end
