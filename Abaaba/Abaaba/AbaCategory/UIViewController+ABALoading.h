//
//  UIViewController+ABALoading.h
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ABALoading)

/**
 *  显示加载
 *
 *  @param view 加载到视图
 *  @param text 加载时显示的文字
 */
- (void)showHudInView:(UIView *)view text:(NSString *)text;
/**
 *  隐藏菊花旋转
 */
- (void)hideHud;
/**
 *  提示内容
 */
- (void)showToast:(NSString *)content;

/**
 *  弹框提示
 *
 */
- (void)showAlertView:(NSString *)title;

@end
