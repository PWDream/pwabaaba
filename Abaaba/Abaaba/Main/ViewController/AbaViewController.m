//
//  AbaViewController.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaViewController.h"
#import "AbaCommonBtn.h"


@interface AbaViewController ()

@end

@implementation AbaViewController

- (AbaNavigationBar *)navBar
{
    if (!_navBar) {
        AbaNavigationBar *navBar = [[AbaNavigationBar alloc] init];
        navBar.frame = self.navigationController.navigationBar.bounds;
        navBar.backgroundColor = AbaCustomNarBgColor;
        navBar.hideDivid = NO;
        [self.view addSubview:navBar];
        self.navBar = navBar;
    }
    return _navBar;
}

- (ABAMainNavigationBar *)mainNavBar
{
    if (!_mainNavBar) {
        ABAMainNavigationBar *navBar = [[ABAMainNavigationBar alloc] init];
        navBar.frame = self.navigationController.navigationBar.bounds;
        navBar.backgroundColor = AbaCustomNarBgColor;
        navBar.hideDivid = NO;
        [self.view addSubview:navBar];
        self.mainNavBar = navBar;
    }
    return _mainNavBar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (self.isMainVC) {
        self.mainNavBar.leftTitle = title ;
    }else{
        self.navBar.title = title;
    }
}

- (void)setIsMainVC:(BOOL)isMainVC{
    _isMainVC = isMainVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    AbaCommonBtnObject *obj = [AbaCommonBtnObject objWithImage:@"navigationbar_back"];
    obj.target = self;
    obj.action = @selector(backClicked);
    self.navBar.leftBtnObj = obj;

    self.view.backgroundColor = AbaCustomNarBgColor;

}

- (void)setFuncBtnArray:(NSArray *)funcBtnArray
{
    _funcBtnArray = funcBtnArray;

    //按钮的最大列数
    NSInteger maxCol = 4;
    NSInteger btnMargin = 8;
    //按钮的个数
    NSInteger btnCount = funcBtnArray.count;
    //总共的列数
    NSInteger tolCol = (btnCount > maxCol) ? maxCol : btnCount;
    //总共的行数
    NSInteger tolRow = btnCount/tolCol;

    if (btnCount%tolCol != 0) {
        tolRow ++;
    }

    CGFloat btnW = self.view.width/tolCol;
    CGFloat btnH = 70;

    for (NSInteger index = 0; index < btnCount; index++)
    {
        AbaCommonBtn *btn = [[AbaCommonBtn alloc] init];
        NSInteger col = index%tolCol;
        NSInteger row = index/tolCol;
        CGFloat btnX = col*btnW;
        CGFloat btnY = row*btnH + btnMargin + KNavBarH;
        if(index > tolCol - 1) btnY += 5;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.commItem = funcBtnArray[index];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [self.view addSubview:btn];
    }

}

- (void)backClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 按钮的点击事件

- (void)btnClicked:(AbaCommonBtn *)btn
{
    if (btn.commItem.destVC) {
        UIViewController *vc = [[btn.commItem.destVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (btn.commItem.operation) {
        btn.commItem.operation();
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
