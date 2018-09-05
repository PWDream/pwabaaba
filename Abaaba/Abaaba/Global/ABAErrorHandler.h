//
//  ABAErrorHandler.h
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ABAErrorHandler <NSObject>

- (BOOL)handleError:(NSError *)error;

@end

typedef BOOL(^ABAErrorHandlerBlock)(NSError *error);

@interface ABAErrorHandlerBlockWrapper : NSObject <ABAErrorHandler>
+ (instancetype)wrapperWithBlock:(ABAErrorHandlerBlock)block;

@property (nonatomic, copy, readonly) ABAErrorHandlerBlock handler;

@end

@interface ABAErrorHandler : NSObject <ABAErrorHandler>

- (void)addHandler:(id<ABAErrorHandler>)handler forIdentifier:(NSString *)identifier;
- (void)removeHandlerForIdentifier:(NSString *)identifier;

@end

extern NSString *const ABAErrorNotification;

@interface ABAErrorHandler (Default)
+ (instancetype)defaultHandler;
@end

