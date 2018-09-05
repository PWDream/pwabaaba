//
//  LoginRequest.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (id)transformRawResponse:(NSURLResponse *)response responseObject:(id)objc error:(NSError * *)error {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *header = [httpResponse allHeaderFields];
    NSString *cookies = header[@"Set-Cookie"];
    NSData * cookiesData = [NSKeyedArchiver archivedDataWithRootObject: cookies];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey:ABAHTTPCOOKIENAME];
    [defaults synchronize];


    ABABaseResponse *responseObjc = [ABABaseResponse mj_objectWithKeyValues:objc];
    if (!responseObjc.status) {
        *error = [NSError errorWithResponse:responseObjc] ? : *error;
    }
    return responseObjc;
}


@end
