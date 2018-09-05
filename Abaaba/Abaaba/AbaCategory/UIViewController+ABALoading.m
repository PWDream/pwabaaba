//
//  UIViewController+ABALoading.m
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UIViewController+ABALoading.h"
#import <MBProgressHUD.h>
#import <objc/runtime.h>
#import <ALToastView.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (ABALoading)

- (MBProgressHUD *)HUD
{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD
{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/**
 *  显示加载
 *
 *  @param view 加载到视图
 *  @param text 加载时显示的文字
 */
- (void)showHudInView:(UIView *)view text:(NSString *)text{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = text;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

/**
 *  隐藏菊花旋转
 */
- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}
/**
 *  提示内容
 */
- (void)showToast:(NSString *)content
{
    [ALToastView toastInView:self.view withText:content];
}
/**
 *  弹框提示
 *
 */
- (void)showAlertView:(NSString *)title
{
    
}

@end
