//
//  ABaseRequest.m
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "ABaseRequest.h"

@implementation ABaseRequest

- (id)transformRawResponse:(NSURLResponse *)response responseObject:(id)objc error:(NSError * *)error {

    ABABaseResponse *responseObjc = [ABABaseResponse mj_objectWithKeyValues:objc];
    if (!responseObjc.status) {
        *error = [NSError errorWithResponse:responseObjc] ? : *error;
    }
    return responseObjc;
}

@end
