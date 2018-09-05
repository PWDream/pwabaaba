//
//  ABABaseResponse.m
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "ABABaseResponse.h"

@implementation ABABaseResponse

- (BOOL)status
{
    return self.code == 200; //100 code success
}

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context
{
    ABABaseResponse *response = [super mj_objectWithKeyValues:keyValues context:context];
    response.responseOrigin = keyValues;
    return response;
}

@end

NSString *const ABAResponseErrorDomain = @"com.abaaba.response.errordomain";
NSString *const ABAResponseKey = @"com.abaaba.response.key";

@implementation NSError (ABAResponse)

+ (NSError *)errorWithResponse:(ABABaseResponse *)response
{
    if (!response) {
        return nil;
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (response.message) {
        userInfo[NSLocalizedDescriptionKey] = response.message;
    }
    userInfo[ABAResponseKey] = response;
    return [NSError errorWithDomain:ABAResponseErrorDomain code:response.code userInfo:[userInfo copy]];
}

@end

@implementation NSError (ABAUtil)

- (NSString *)aba_message
{
    if ([self.domain isEqualToString:ABAResponseErrorDomain]) {
        return self.localizedDescription;
    } else {
        return @"网络异常";
    }
}

@end
