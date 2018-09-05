//
//  MeHeaderView.m
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "MeHeaderView.h"
#import "UserInfoView.h"

@interface MeHeaderView()
@property(weak,nonatomic) UIImageView *backgroundImageView;

@end

@implementation MeHeaderView

- (MeHeaderView *)initWithFrame:(CGRect)frame userInfoModel:(UserInfoModel *)userInfo{
    MeHeaderView *headerView = [self initWithFrame:frame];
    [headerView setupViewWithUserInfoModel:userInfo];
    return headerView;
}

- (void)setupViewWithUserInfoModel:(UserInfoModel *)userInfo{
    UIImageView *backgroundImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 204)];
    [backgroundImageView setImage:[UIImage imageNamed:@"me_background"]];
    [self addSubview:backgroundImageView];

    UserInfoView *userInfoView = [UserInfoView userInfoView];
    CGFloat userX = 20,userY = 60, userH = 212;
    CGFloat userW = self.width - 2 * userX;
    [userInfoView setFrame:CGRectMake(userX, userY, userW, userH)];
    userInfoView.userInfoModel = userInfo;
    [userInfoView setCornerWithRadius:5];
    userInfoView.layer.shadowColor = [UIColor grayColor].CGColor;
    userInfoView.layer.shadowOpacity = 0.5f;
    [self addSubview:userInfoView];
}

@end
