
//
//  FriendVC.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "FriendVC.h"

@interface FriendVC ()

@end

@implementation FriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView{
    self.mainNavBar.frame = CGRectMake(0, 0, self.view.width, 65);
    self.mainNavBar.leftTitle = @"好友";
    self.mainNavBar.hideDivid = YES;
}

@end
