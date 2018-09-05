//
//  UIView+Aba.m
//  Abaaba
//
//  Created by PW on 2018/8/4.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UIView+Aba.h"
#import <MJRefresh/MJRefresh.h>
#import "OMGToast.h"

@implementation UIView (Aba)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCentreX:(CGFloat)centreX
{
    CGPoint center = self.center;
    center.x = centreX;
    self.center = center;

}

- (CGFloat)centreX
{
    return self.center.x;
}


- (void)setCentreY:(CGFloat)centreY
{
    CGPoint center = self.center;
    center.y = centreY;
    self.center = center;
}

- (CGFloat)centreY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 设置视图圆角

/**
 *  设置顶部圆角
 */
- (void)setCornerOnTop
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}
/**
 *  设置底部圆角
 */
- (void)setCornerOnBottom
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}
/**
 *  设置所有圆角
 */
- (void)setAllCorner
{
    [self setCornerWithRadius:10];
}
/**
 *  设置没有圆角
 */
- (void)setNoneCorner
{
    self.layer.mask = nil;
}
/**
 *  设置左边圆角
 */
- (void)setCornerOnLeft
{
    [self setCorner:(UIRectCornerTopLeft | UIRectCornerBottomLeft) size:CGSizeMake(5.0f, 5.0f)];
}
/**
 *  设置右边圆角
 */
- (void)setCornerOnRight
{
    [self setCorner:(UIRectCornerTopRight | UIRectCornerBottomRight) size:CGSizeMake(5.0f, 5.0f)];
}

- (void)setCorner:(UIRectCorner)corners size:(CGSize)size
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:corners
                                           cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setBottomLine:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    [self setBorderWithView:false left:false bottom:YES right:false borderColor:borderColor borderWidth:borderWidth];
}

- (void)setBorderWithView:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.height - width, self.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.width - width, 0, width, self.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

/**
 *  设置圆角的弧度
 */
- (void)setCornerWithRadius:(CGFloat)radius{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                          cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


/**
 *  晃动提醒动画
 */
-(void)shakeWithtTanslation:(CGFloat)translation{

    if (translation) {
        [self.layer removeAllAnimations];
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        CGFloat currentTx = self.transform.tx;

        animation.duration = 0.5;
        animation.values = @[ @(currentTx), @(currentTx + translation), @(currentTx-translation*0.5), @(currentTx + translation*0.5), @(currentTx) ];
        animation.keyTimes = @[ @(0), @(0.25), @(0.5), @(0.75), @(1) ];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:animation forKey:@"shake"];
    }
}

/**
 *  显示提示框
 *
 *  @param text 提示框内容
 */
- (void)showToastView:(NSString *)text
{
    [OMGToast showWithText:text bottomOffset:ToastOffset duration:ToastDuration];
}



@end


@implementation UIView (AbaLine)

+ (instancetype)aba_lineWithColor:(UIColor *)color
{
    return [self aba_lineWithColor:color width:[UIScreen mainScreen].bounds.size.width];
}

+ (instancetype)aba_lineWithColor:(UIColor *)color width:(CGFloat)width
{
    return [self aba_lineWithColor:color width:width height:1/[UIScreen mainScreen].scale];
}

+ (instancetype)aba_lineWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = color;
    return view;
}

@end


@implementation UIView (AbaXibCreate)

+ (instancetype)aba_createViewXibName:(NSString *)name {
    UIView *view = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].firstObject;
    return view;
}

+ (instancetype)aba_createViewXibName:(NSString *)name restorationId:(NSString *)identifier
{
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
    NSArray *views = [objects bk_select:^BOOL(id obj) {
        return [obj isKindOfClass:[UIView class]];
    }];
    UIView *resultView;
    for (UIView *view in views) {
        if ([view.restorationIdentifier isEqualToString:identifier]) {
            NSLog(@"%@",view.restorationIdentifier);
            resultView = view;
            break;
        }
    }
    return resultView;
}

@end

@implementation UIView(Refresh)

- (void)addHeaderRefresh:(UITableView *)tableView
{
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing:)];
}

- (void)addNormalFooterRefresh:(UITableView *)tableView
{
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing:)];
}

- (void)addAutomaticallyChangeAlphaFooterRefresh:(UITableView *)tableView
{
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing:)];
    tableView.footer.automaticallyChangeAlpha = YES;
}

- (void)addAutomaticallyChangeAlphaHeaderRefresh:(UITableView *)tableView
{
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing:)];
    tableView.header.automaticallyChangeAlpha = YES;
}

- (void)headerRefreshing:(UITableView *)tableView
{

}

- (void)footerRefreshing:(UITableView *)tableView
{

}

- (void)headerEndRefreshing:(UITableView *)tableView
{
    if (tableView.header.isRefreshing) {
        [tableView.header endRefreshing];
    }
}

- (void)footerEndRefreshing:(UITableView *)tableView
{
    if (tableView.footer.isRefreshing) {
        [tableView.footer endRefreshing];
    }
}

- (void)removeRefresh:(UITableView *)tableView
{
    tableView.header = nil;
    tableView.footer = nil;
}

- (void)removeHeaderRefresh:(UITableView *)tableView
{
    tableView.header = nil;
}

- (void)removeFooterRefresh:(UITableView *)tableView
{
    tableView.footer = nil;
}

- (void)headerStartRefresh:(UITableView *)tableView
{
    [tableView.header beginRefreshing];
}

- (void)footerStartRefresh:(UITableView *)tableView
{
    [tableView.footer beginRefreshing];
}

@end
