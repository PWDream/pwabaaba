//
//  UIView+Aba.h
//  Abaaba
//
//  Created by PW on 2018/8/4.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Aba)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centreX;

@property (nonatomic, assign) CGFloat centreY;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

- (UIViewController*)viewController;

/**
 *  设置顶部圆角
 */
- (void)setCornerOnTop;
/**
 *  设置底部圆角
 */
- (void)setCornerOnBottom;
/**
 *  设置所有圆角
 */
- (void)setAllCorner;
/**
 *  设置没有圆角
 */
- (void)setNoneCorner;
/**
 *  设置左边圆角
 */
- (void)setCornerOnLeft;
/**
 *  设置右边圆角
 */
- (void)setCornerOnRight;
- (void)setCorner:(UIRectCorner)corners size:(CGSize)size;
- (void)setBottomLine:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
- (void)setBorderWithView:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
/**
 *  设置圆角的弧度
 */
- (void)setCornerWithRadius:(CGFloat)radius;

/**
 *  晃动提醒动画
 */
-(void)shakeWithtTanslation:(CGFloat)translation;
/**
 *  显示提示框
 *
 *  @param text 提示框内容
 */
- (void)showToastView:(NSString *)text;

- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

@end

@interface UIView (AbaLine)
+ (instancetype)aba_lineWithColor:(UIColor *)color;
+ (instancetype)aba_lineWithColor:(UIColor *)color width:(CGFloat)width;
+ (instancetype)aba_lineWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;
@end

@interface UIView (AbaXibCreate)

+ (instancetype)aba_createViewXibName:(NSString *)name;

+ (instancetype)aba_createViewXibName:(NSString *)name restorationId:(NSString *)identifier;

@end

@interface UIView (Refresh)

- (void)addHeaderRefresh:(UITableView *)tableView;

- (void)addNormalFooterRefresh:(UITableView *)tableView;

- (void)addAutomaticallyChangeAlphaHeaderRefresh:(UITableView *)tableView;

- (void)addAutomaticallyChangeAlphaFooterRefresh:(UITableView *)tableView;

- (void)headerRefreshing:(UITableView *)tableView;

- (void)footerRefreshing:(UITableView *)tableView;

- (void)headerEndRefreshing:(UITableView *)tableView;

- (void)footerEndRefreshing:(UITableView *)tableView;

- (void)removeRefresh:(UITableView *)tableViewh;

- (void)removeHeaderRefresh:(UITableView *)tableView;

- (void)removeFooterRefresh:(UITableView *)tableView;

- (void)headerStartRefresh:(UITableView *)tableView;

- (void)footerStartRefresh:(UITableView *)tableView;

@end
