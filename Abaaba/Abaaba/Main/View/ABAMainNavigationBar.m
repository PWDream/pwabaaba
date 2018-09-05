//
//  ABAMainNavigationBar.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "ABAMainNavigationBar.h"

//离左边还有右边屏幕的间距
#define KBtnMargin 8
//按钮的字体
#define KBtnFont [UIFont systemFontOfSize:15]
//标题的字体
#define KTitleFont [UIFont systemFontOfSize:30]
//按钮的最大宽度
#define KBtnMaxW 60

@interface ABAMainNavigationBar()
/** 右边按钮 */
@property (nonatomic, weak) UIButton *rightBtn;
/** 分割线 */
@property (nonatomic, weak) UIView *dividView;
/** 标题 */
@property (nonatomic, weak) UILabel *titlelb;

@end

@implementation ABAMainNavigationBar

- (UILabel *)titlelb
{
    if (!_titlelb) {
        UILabel *titlelb = [[UILabel alloc] init];
        titlelb.backgroundColor = [UIColor clearColor];
        titlelb.textAlignment = NSTextAlignmentCenter;
        titlelb.font = KTitleFont;
        titlelb.textColor = HEXCOLOR(0x4A4A4A);
        [self addSubview:titlelb];
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


    UIView *dividView = [[UIView alloc] init];
    dividView.backgroundColor = [UIColor grayColor];
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
        CGSize size = [obj.title sizeWithAttributes:@{NSFontAttributeName:KBtnFont}];
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
 *  设置标题
 */
- (void)setLeftTitle:(NSString *)leftTitle
{
    _leftTitle  = leftTitle;
    CGSize size = [leftTitle sizeWithAttributes:@{NSFontAttributeName:KTitleFont}];
    self.titlelb.size = size;
    self.titlelb.text = leftTitle;
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

//    self.height = KNavBarH;
    CGSize lableSize = [self.titlelb.text sizeWithAttributes:@{NSFontAttributeName:self.titlelb.font}];
    self.titlelb.frame = CGRectMake(15, 5, lableSize.width, 70);
    self.dividView.frame = CGRectMake(0, self.height - 1, self.width, 1);
}

@end
