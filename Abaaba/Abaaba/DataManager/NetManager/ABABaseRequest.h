//
//  ABABaseRequest.h
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@protocol ABABaseRequestDelegate;

@interface ABABaseRequest : NSObject

+ (instancetype)requestWithPath:(NSString *)path
                       finished:(void(^)(id response, NSError *error))finished;

+ (instancetype)requestWithPath:(NSString *)path
                      urlParams:(NSDictionary *)urlParams
                       finished:(void(^)(id response, NSError *error))finished;

+ (instancetype)requestWithPath:(NSString *)path
                      urlParams:(NSDictionary *)urlParams
                     bodyParams:(NSDictionary *)bodyParams
                       finished:(void(^)(id response, NSError *error))finished;

/**
 *  The designated initializer
 *
 *  @param path       相对路径
 *  @param urlParams  get 请求的参数，会拼接到URL的query上
 *  @param bodyParams post请求参数
 *  @param finished   网络请求完成回调
 *
 *  @return 返回HOSBaseRequest实例对象
 */
- (instancetype)initWithPath:(NSString *)path
                   urlParams:(NSDictionary *)urlParams
                  bodyParams:(NSDictionary *)bodyParams
                    finished:(void(^)(id response, NSError *error))finished;

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *relativePath;
@property (nonatomic, strong) NSString *method;

@property (nonatomic, strong) NSMutableDictionary *headerFields;

@property (nonatomic, strong) NSMutableDictionary *urlParams;
@property (nonatomic, strong) NSMutableDictionary *bodyParams;

@property (nonatomic, copy) void(^finished)(id response, NSError *error);
@property (nonatomic, strong, readonly) id response;//KVO
@property (nonatomic, strong, readonly) NSError *error;// error

- (void)cancel;
- (void)start;

- (void)willSend;
//生成NSMutableURLRequest方法，子类可以重写该方法，使用自己的生成规则
- (NSMutableURLRequest *)URLRequest;
//子类可以修改manager的行为
- (void)willStartSessionManager:(AFHTTPSessionManager *)manager;
//默认行为直接返回objc, 不产生error
- (id)transformRawResponse:(NSURLResponse *)response responseObject:(id)objc error:(NSError * *)error;

// delegate方法的触发时机都晚于HOSBaseRequestCenter中方法的触发时机
// 先于自身子类复写方法
@property (nonatomic, weak) id<ABABaseRequestDelegate>delegate;

@end


/**
 *  请求的生命周期的代理协议
 */
@protocol ABABaseRequestDelegate <NSObject>
- (void)willSendRequest:(ABABaseRequest *)request;
@optional
- (void)request:(ABABaseRequest *)request didReceiveResponse:(id)response error:(NSError *)error;
@end

typedef void(^ABAWillSendRequest)(ABABaseRequest *request);
typedef void(^ABADidReceiveResponse)(ABABaseRequest *request,id response, NSError *error);

@interface ABABaseRequestBlockDelegate : NSObject <ABABaseRequestDelegate>
@property (nonatomic, copy) ABAWillSendRequest willSendRequest;
@property (nonatomic, copy) ABADidReceiveResponse didReceiveResponse;
+ (instancetype)blockDelegateWithWill:(ABAWillSendRequest)willSendRequest didReceiveResponse:(ABADidReceiveResponse )didReceiveResponse;
+ (instancetype)blockDelegateWithWill:(ABAWillSendRequest)willSendRequest;
@end

@interface ABABaseRequestCenter : NSObject <ABABaseRequestDelegate>

+ (instancetype)defaultCenter;
@property (nonatomic, strong, readonly) NSArray *delegates;

- (void)addRequestDelegate:(id<ABABaseRequestDelegate>)delegate;
- (void)removeRequestDelegate:(id<ABABaseRequestDelegate>)delegate;

@end

typedef void(^ProgressPercent)(CGFloat percent);
typedef void(^DownloadComplete)(NSString *locationPath, NSError *error);
@interface ABADownloadTask : NSObject

+ (instancetype)downFileWithPath:(NSString *)path progressPercent:(ProgressPercent)percent completed:(DownloadComplete)completed;
- (void)start;
- (void)stop;

@end
