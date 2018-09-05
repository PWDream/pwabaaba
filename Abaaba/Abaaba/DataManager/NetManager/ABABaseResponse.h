//
//  ABABaseResponse.h
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>

// some base error code
typedef NS_ENUM(NSInteger, ABAResponseCode) {
    ABAResponseSuccess = 100,
    ABAResponseFail = 200,

    ABAResponseMissingAuthorization = 501,
    ABAResponseFaultAuthorization = 502,
    ABAResponseExpiredAuthorization = 503,
    ABAResponseLoginOtherDevice = 504,
    ABAResponseExitOrg = 505,

    ABAResponseSQL = 598,
    ABAResponseIO = 597,
    ABAResponseOther = 599,
};

@interface ABABaseResponse : NSObject
@property (nonatomic, assign) NSInteger   code;       //请求返回编码
@property (nonatomic, copy)   NSString    *message;   //请求返回信息
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger tips;
@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, strong) id          object;

@property (nonatomic, assign, readonly) BOOL status;     //code == ABAResponseSuccess

@property (nonatomic, strong) NSDictionary *responseOrigin;   //未解析的返回

@end

extern NSString *const ABAResponseErrorDomain;
extern NSString *const ABAResponseKey;
@interface NSError (ABAResponse)
+ (NSError *)errorWithResponse:(ABABaseResponse *)response;
@end

@interface NSError (ABAUtil)
- (NSString *)aba_message;
@end
