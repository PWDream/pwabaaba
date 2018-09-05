//
//  AbaUrlDefine.h
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#ifndef AbaUrlDefine_h
#define AbaUrlDefine_h

#pragma mark ==Server API URL==

#define KBaseUrl    @"http://www.abaaba.com/"
#define KBaseUrlWallet  @"http://www.abaaba.com:8762"

#define KSecondBaseUrl @""    //二级

//登录注册相关
#define KCheckPhoneAvailableUrl    @"user/check_phone_available"   //检查手机是否被注册
#define KSendCodeUrl    @"user/send_code"   //发送验证码
#define KVerifyCodeUrl    @"user/verify_code"   //验证验证码是否正确
#define KRegisterUrl    @"user/register"   //注册
#define KLoginUrl    @"user/login"   //登录
#define KTokenUrl    @"user/get_token"   //Token

#define KGetUserInfo @"user/"   //Token

//发现页接口
#define KDiscoverUrl    @"misc/discover"   //Token


#endif /* AbaUrlDefine_h */
