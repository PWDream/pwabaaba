//
//  AbaUser.m
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaUser.h"
#import "NSObject+Aba.h"

@implementation AbaUser


@end

static AbaUser *currentUser = nil;
static NSDictionary *currentUserInfoDictionary = nil;
static NSLock *userLock = nil;
@implementation AbaUser (Current)

+ (void)load
{
    userLock = [[NSLock alloc] init];
}

+ (instancetype)currentUser
{
    [userLock lock];
    if (!currentUser) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"token"]) {
            currentUser = [[AbaUser alloc] init];
            currentUser.token = [userDefaults objectForKey:@"token"];
            currentUser.password = [userDefaults objectForKey:@"password"];

            // 用户信息
            NSDictionary *userInfoDictionary = [[userDefaults objectForKey:@"UserInfo"] objectFromJSONString];
            UserInfoModel *userInfo = [[UserInfoModel alloc] init];
            [userInfo mj_setKeyValues:userInfoDictionary];
            currentUser.userInfo = userInfo;
            currentUserInfoDictionary = userInfo.mj_keyValues;
        }
    }
    [userLock unlock];
    return currentUser;
}

+ (NSString *)currentUserID
{
    AbaUser *user = [self currentUser];
    return user.userInfo.userId;
}

+ (void)setCurrentUser:(AbaUser *)user postNotification:(NSString *) postNotification
{
    [userLock lock];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (currentUser) { // if exists, clean old
        [userDefaults removeObjectForKey:@"token"];
        [userDefaults removeObjectForKey:@"UserInfo"];
    }
    currentUser = user;
    currentUserInfoDictionary = user.userInfo.mj_keyValues;
    if (user) {
        [userDefaults setObject:user.token forKey:@"token"];
        if (user.userInfo) {
            [userDefaults setObject:[[user.userInfo mj_keyValues] AbaJSONString] forKey:@"UserInfo"];
        }
    }
    [userDefaults synchronize];
    [userLock unlock];
    if (postNotification && postNotification.length > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:postNotification object:user];
    }
}

@end
