//
//  AbaNavigationController.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaNavigationController.h"
#import "UIBarButtonItem+Aba.h"


@interface AbaNavigationController ()

@end

@implementation AbaNavigationController

//这个方法只会调用一次
+ (void)initialize
{

    //设置导航条的主题
    //    [self setNavUpTheme];

    //设置导航栏按钮的主题
    //    [self setNavUpBtnTheme];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (IOS7) {
        //清空手势识别器的代理, 就能恢复以前滑动移除控制器的功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    self.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];

}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
