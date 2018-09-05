//
//  ABAHTTPRequestConfig.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "ABAHTTPRequestConfig.h"
#import "DeviceUtil.h"
#import "NSBundle+ABA.h"
#import "ABAErrorHandler.h"

@implementation ABAHTTPRequestConfig

- (void)willSendRequest:(ABABaseRequest *)request
{
    if ([request isKindOfClass:[ABaseRequest class]]) {
        request.baseURL = KBaseUrl;
        if ([AbaUser currentUser].token) {
            [request.headerFields setValue:[AbaUser currentUser].token forKey:@"Token"];
            [request.bodyParams setValue:[AbaUser currentUserID] forKey:@"userId"];
        }

        NSString *cookieStr = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:ABAHTTPCOOKIENAME]];
        if (cookieStr && cookieStr.length) {
            [request.headerFields setValue:cookieStr forKey:@"Cookie"];
        }

        [request.bodyParams setValue:@"1.0.0" forKey:@"dbversion"];

        [request.urlParams setValue:[UIDevice currentDevice].systemName forKey:@"os"];
        [request.urlParams setValue:[UIDevice currentDevice].systemVersion forKey:@"osver"];
        [request.urlParams setValue:[NSBundle mainBundleShortVersion] forKey:@"version"];
        [request.urlParams setValue:[DeviceUtil hardwareString] forKey:@"hw"];//获取设备的型号，eg:iPod5,1:iPod5第一代
        [request.urlParams setValue:@(1) forKey:@"platform"];//平台
    }
}

- (void)request:(ABABaseRequest *)request didReceiveResponse:(id)response error:(NSError *)error
{
    if (error) {
//        DDLogError(@"EKBLOG: \nrequest: %@ \nerror:%@",request.URLRequest,error);
        if ([request isKindOfClass:[ABaseRequest class]]) {
            [[ABAErrorHandler defaultHandler] handleError:error]; //转交给error处理中心处理
        }
    }
}

@end
