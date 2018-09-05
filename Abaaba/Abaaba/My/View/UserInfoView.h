//
//  UserInfoView.h
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@class UserInfoView,UserInfoModel;

@protocol UserInfoViewDelegate <NSObject>

@optional

- (void)editUserClicked:(UserInfoModel *)userInfoModel;

@end

@interface UserInfoView : UIView

@property (nonatomic, strong) UserInfoModel *userInfoModel;
@property (nonatomic, weak) id <UserInfoViewDelegate> delegate;

+ (UserInfoView *)userInfoView;

@end
