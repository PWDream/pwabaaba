//
//  ABAErrorHandler+Config.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "ABAErrorHandler+Config.h"
#import "ABABaseResponse.h"

@implementation ABAErrorHandler (Config)

+ (void)configErrorHandlers
{
    [[ABAErrorHandler defaultHandler] addHandler:[ABAErrorHandlerBlockWrapper wrapperWithBlock:^BOOL(NSError *error) {
        if ([error.domain isEqualToString:ABAResponseErrorDomain]) {

        }
        return NO;
    }] forIdentifier:ABAResponseErrorDomain];

#ifdef DEBUG
    [[ABAErrorHandler defaultHandler] addHandler:[ABAErrorHandlerBlockWrapper wrapperWithBlock:^BOOL(NSError *error) {
        NSLog(@"receive error:%@\n",error);
        return NO;
    }] forIdentifier:@"ABAErrorLogger"];
#endif
}


@end
