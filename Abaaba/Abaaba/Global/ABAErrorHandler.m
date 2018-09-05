//
//  ABAErrorHandler.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "ABAErrorHandler.h"

@interface ABAErrorHandlerBlockWrapper ()
@property (nonatomic, copy) ABAErrorHandlerBlock handler;
@end

@implementation ABAErrorHandlerBlockWrapper

+ (instancetype)wrapperWithBlock:(ABAErrorHandlerBlock)block
{
    ABAErrorHandlerBlockWrapper *wrapper = [[self alloc] init];
    wrapper.handler = block;
    return wrapper;
}

- (BOOL)handleError:(NSError *)error
{
    if (self.handler) {
        return self.handler(error);
    }
    return NO;
}

@end

@interface ABAErrorHandler()
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSMutableDictionary *handlers;
@end

@implementation ABAErrorHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        _handlers = [NSMutableDictionary dictionary];
        _lock = [[NSLock alloc] init];
    }
    return self;
}

- (void)addHandler:(id)handler forIdentifier:(NSString *)identifier
{
    [_lock lock];
    [_handlers setObject:handler forKey:identifier];
    [_lock unlock];
}

- (void)removeHandlerForIdentifier:(NSString *)identifier
{
    [_lock lock];
    [_handlers removeObjectForKey:identifier];
    [_lock unlock];
}

- (BOOL)handleError:(NSError *)error
{
    // don't use lock
    NSArray *handlers = [_handlers.allValues copy];
    for (id handler in handlers) {
        if ([handler respondsToSelector:@selector(handleError:)]) {
            if ([handler handleError:error]) {
                return YES;
            }
        }
    }
    return NO;
}

@end

NSString *const ABAErrorNotification = @"com.aba.error.notification";

@implementation ABAErrorHandler (Default)

+ (instancetype)defaultHandler
{
    static ABAErrorHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[self alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveError:)
                                                     name:ABAErrorNotification
                                                   object:nil];
    });
    return handler;
}

+ (void)didReceiveError:(NSNotification *)notification
{
    NSError *error = (NSError *)notification.object;
    if (error) {
        [[self defaultHandler] handleError:error];
    }
}

@end
