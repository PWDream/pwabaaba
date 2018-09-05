//
//  AbaUser.h
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface AbaUser : NSObject
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *password;//传给服务器的密码，非原始密码

@property (nonatomic, strong) UserInfoModel *userInfo;         //用户信息
@end


@interface AbaUser(Current)

+ (instancetype)currentUser;
+ (void)setCurrentUser:(AbaUser *)user postNotification:(NSString *) notification;
//helper
+ (NSString *)currentUserID;
@end

