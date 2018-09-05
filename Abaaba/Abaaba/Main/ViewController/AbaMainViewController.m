//
//  AbaMainViewController.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaMainViewController.h"
#import "AbaCommonBtn.h"


@interface AbaMainViewController ()

@end

@implementation AbaMainViewController

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navBar.titleColor = [UIColor blackColor];
}

/**
 *  添加功能子视图
 *
 *  @param funcArray 功能数组
 *  @param position  位置
 */
- (void)addFunctionView:(NSArray *)funcArray position:(CGRect)position
{
    //按钮的最大列数
    NSInteger maxCol = 4;
    NSInteger btnMargin = 8;
    //按钮的个数
    NSInteger btnCount = funcArray.count;
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
        CGFloat btnY = row*btnH + btnMargin + position.origin.y;
        if(index > tolCol - 1) btnY += 5;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.commItem = funcArray[index];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [self.view addSubview:btn];
    }

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
