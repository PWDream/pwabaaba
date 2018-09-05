//
//  AbaTabBarController.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaTabBarController.h"
#import "AbaNavigationController.h"
#import "AbaCustomTabBar.h"
#import "AbaBarButton.h"
#import "../../Message/MessageVC.h"
#import "../../Friend/FriendVC.h"
#import "../../Discover/DiscoverVC.h"
#import "../../My/MyVC.h"

@interface AbaTabBarController ()
<AbaCustomTabBarDelegate>
@property (weak, nonatomic) AbaCustomTabBar *customTabBar;

@end

@implementation AbaTabBarController

- (AbaCustomTabBar *)customTabBar
{
    if (!_customTabBar)
    {
        AbaCustomTabBar *customTabBar = [[AbaCustomTabBar alloc] init];
        customTabBar.frame = self.tabBar.bounds;
        customTabBar.delegate = self;
        [self.view addSubview:customTabBar];
        self.customTabBar = customTabBar;

        [self.tabBar addSubview:self.customTabBar];

    }
    return _customTabBar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //设置子视图
        [self setChildVC];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    for (UIView *view in self.tabBar.subviews)
    {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//设置子视图
- (void)setChildVC
{
    //消息
    MessageVC *home = [[MessageVC alloc] init];
    [self addOneChild:home title:@"消息" imageName:@"message" selectedImageName:@"message"];

    //朋友
    FriendVC *friend = [[FriendVC alloc] init];
    [self addOneChild:friend title:@"好友" imageName:@"friend" selectedImageName:@"friend"];

    //发现
    DiscoverVC *discover = [[DiscoverVC alloc] init];
    [self addOneChild:discover title:@"发现" imageName:@"discover" selectedImageName:@"discory_selected"];

    //我的
    MyVC *my = [[MyVC alloc] init];
    [self addOneChild:my title:@"我的" imageName:@"my" selectedImageName:@"my_selected"];

}

- (void)addOneChild:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imagName selectedImageName:(NSString *)selectedImageName
{
    viewController.title = title;
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageWithName:imagName];
    //去掉图片的渲染效果
    UIImage *selectImage = [UIImage imageWithName:selectedImageName];
    if (IOS7) {
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    viewController.tabBarItem.selectedImage = selectImage;

    AbaNavigationController *nav = [[AbaNavigationController alloc] initWithRootViewController:viewController];

    [self addChildViewController:nav];

    [self.customTabBar addBarButton:viewController.tabBarItem];
}

#pragma mark - WBCustomTabBar 委托

- (void)tabBarClicked:(AbaCustomTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
