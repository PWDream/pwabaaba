//
//  MeHeaderView.h
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoModel;
@interface MeHeaderView : UIView
- (MeHeaderView *)initWithFrame:(CGRect)frame userInfoModel:(UserInfoModel *)userInfo;
@end
