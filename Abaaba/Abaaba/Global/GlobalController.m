//
//  GlobalController.m
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "GlobalController.h"
#import "AbaLoginViewController.h"
#import "AbaTabBarController.h"
#import "AbaUser.h"

static GlobalController *globalCtrl;

@implementation GlobalController

+(GlobalController *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalCtrl = [[GlobalController alloc]init];
    });
    return globalCtrl;
}

- (void)chooseRootViewController
{
    if ([AbaUser currentUserID].length) {
        [self resetRootViewController];
    } else {
        [self resetRootViewControllerForLogin];
    }
}

- (void)resetRootViewController
{
    [UIApplication sharedApplication].delegate.window.rootViewController = [[AbaTabBarController alloc] init];
}

- (void)resetRootViewControllerForLogin
{
    AbaLoginViewController *logVC = [[AbaLoginViewController alloc] init];
    UINavigationController *logNC = [[UINavigationController alloc] initWithRootViewController:logVC];
    [UIApplication sharedApplication].delegate.window.rootViewController = logNC;
}

- (void)resetRootViewController:(UIViewController *)viewController {
    [UIApplication sharedApplication].delegate.window.rootViewController = viewController;
}

- (void)cleanWindowSubview
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in window.subviews) {
        if ([view isMemberOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
}

@end
