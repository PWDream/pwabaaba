//
//  AbaRegisterParam.h
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//
 
#import <Foundation/Foundation.h>

@interface AbaRegisterParam : NSObject
/** 手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 密码 */
@property (nonatomic, copy) NSString *password;
/** 确认密码 */
@property (nonatomic, copy) NSString *rePassword;
/** 邮箱 */
@property (nonatomic, copy) NSString *email;
/** 短信验证码(调用“短信验证码接口1.1”获得，验证码将发送至该手机号码上(有延迟)) */
@property (nonatomic, copy) NSString *code;
/** 设备品牌与型号信息 */
@property (nonatomic, copy) NSString *ibeaconBrand;
/** 设备mac值 */
@property (nonatomic, copy) NSString *ibeaconMac;
/** 设备版本信息 */
@property (nonatomic, copy) NSString *ibeaconVersion;
/** 设备imsi值 */
@property (nonatomic, copy) NSString *ibeaconImsi;
/** 网络运营商 */
@property (nonatomic, copy) NSString *ibeaconOperator;

@end
