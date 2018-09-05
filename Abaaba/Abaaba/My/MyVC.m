//
//  MyVC.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "MyVC.h"
#import "UserInfoModel.h"
#import "MeHeaderView.h"
#import "MySectionView.h"
#import "MyEnum.h"

@interface MyVC ()
<SectionViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSDictionary *settingData;
@end

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView{
    [self setupHeaderView];
    [self setupSectionView];
}

- (void)setupHeaderView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = HEXCOLOR(0xf9f9f9);
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    UserInfoModel *userModel = [[UserInfoModel alloc] init];
    userModel.name = @"潘威";
    userModel.nikeName = @"DayDream";
    userModel.avatar = @"defaultAvatar.png";
    userModel.btc = @"2000000.00";
    userModel.cny = @"1123.00";

    MeHeaderView *header = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 300) userInfoModel:userModel];
    [scrollView addSubview:header];
}

- (void)setupSectionView{
    NSDictionary *settingData = @{
                                  @"wallet":@[@{@"label":@"钱包",@"icon":@"wallet.png",@"key":@(WALLET)}],
                                  @"others":@[@{@"label":@"设置",@"icon":@"setting.png",@"key":@(SETTING)},
                                              @{@"label":@"意见反馈",@"icon":@"feedback.png",@"key":@(FEEDBACK)},
                                              @{@"label":@"关于我们",@"icon":@"about.png",@"key":@(ABOUT)}]
                                  };
    NSArray *allKeys = @[@"wallet",@"others"];
    for(NSInteger index = 0;index < allKeys.count;index++){
        NSString *key = allKeys[index];
        NSArray *sections = [settingData objectForKey:key];
        CGFloat h = sections.count * 50;
        UIView *lastView  = [self.scrollView.subviews lastObject];
        CGFloat y = CGRectGetMaxY(lastView.frame) + 20;
        CGFloat x = 20,w = self.view.width - 2*x;
        MySectionView *sectionView = [[MySectionView alloc] initWithFrame:CGRectMake(x, y, w, h) sections:sections];
        sectionView.delegate = self;
        sectionView.backgroundColor = [UIColor whiteColor];
        [sectionView setCornerWithRadius:5];
        sectionView.layer.shadowColor = [UIColor grayColor].CGColor;
        sectionView.layer.shadowOpacity = 0.5f;
        [self.scrollView addSubview:sectionView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark-- 点击事件

- (void)walletClicked{
    NSLog(@"walletClicked");
}

- (void)settingClicked{
    NSLog(@"settingClicked");
}

- (void)feedbackClicked{
    NSLog(@"feedbackClicked");
}

- (void)aboutClicked{
    NSLog(@"aboutClicked");
}

#pragma mark-- 委托事件

- (void)sectionItemClicked:(NSInteger)key{
    switch (key) {
            case WALLET:
            [self walletClicked];
            break;
            case SETTING:
            [self settingClicked];
            break;
            case FEEDBACK:
            [self feedbackClicked];
            break;
            case ABOUT:
            [self aboutClicked];
            break;
        default:
            break;
    }
}

@end
