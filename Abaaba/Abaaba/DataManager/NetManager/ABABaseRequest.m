//
//  ABABaseRequest.m
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "ABABaseRequest.h"

@interface ABABaseRequest ()
@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, strong) id response;
@property (nonatomic, strong) NSError *error;// error
@end

@implementation ABABaseRequest

+ (AFHTTPSessionManager *)sessionManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                             @"application/json",
                                                             @"text/json",
                                                             @"text/javascript",
                                                             @"text/html",
                                                             @"text/plain", nil];
        [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    });
    return manager;
}

+ (instancetype)requestWithPath:(NSString *)path
                       finished:(void(^)(id response, NSError *error))finished
{
    return [self requestWithPath:path urlParams:nil finished:finished];
}

+ (instancetype)requestWithPath:(NSString *)path
                      urlParams:(NSDictionary *)urlParams
                       finished:(void(^)(id response, NSError *error))finished
{
    return [self requestWithPath:path urlParams:urlParams bodyParams:nil finished:finished];
}

+ (instancetype)requestWithPath:(NSString *)path
                      urlParams:(NSDictionary *)urlParams
                     bodyParams:(NSDictionary *)bodyParams
                       finished:(void(^)(id response, NSError *error))finished
{
    ABABaseRequest *request = [[self alloc] initWithPath:path urlParams:urlParams bodyParams:bodyParams finished:finished];
    return request;
}

- (instancetype)init
{
    self = [self initWithPath:nil urlParams:nil bodyParams:nil finished:nil];
    return self;
}

- (instancetype)initWithPath:(NSString *)path
                   urlParams:(NSDictionary *)urlParams
                  bodyParams:(NSDictionary *)bodyParams
                    finished:(void(^)(id response, NSError *error))finished
{
    self = [super init];
    if (self) {
        _relativePath = path;
        _urlParams = [NSMutableDictionary dictionary];
        [_urlParams setValuesForKeysWithDictionary:urlParams];
        _bodyParams = [NSMutableDictionary dictionary];
        [_bodyParams setValuesForKeysWithDictionary:bodyParams];
        _headerFields = [NSMutableDictionary dictionary];
        _finished = finished;
    }
    return self;
}

- (NSString *)method
{
    if (!_method) {
        // 如果不设置，则存在bodyParams认为为post请求。
        if (self.bodyParams.allKeys.count > 0) {
            return @"POST";
        } else {
            return @"GET";
        }
    }
    return _method;
}

- (void)cancel
{
    [self.task cancel];
}

- (void)start
{
    if (self.task && self.task.state == NSURLSessionTaskStateRunning) {
        return;
    }

    [self setupSessionTask];
    [self.task resume];
}

- (void)setupSessionTask {

    [[ABABaseRequestCenter defaultCenter] willSendRequest:self];
    if ([self.delegate respondsToSelector:@selector(willSendRequest:)]) {
        [self.delegate willSendRequest:self];
    }
    [self willSend];
    NSMutableURLRequest *request = [self URLRequest];

    AFHTTPSessionManager *sessionManager = [self.class sessionManager];
    NSURLSessionDataTask *task = [sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        id responseObjc = [self transformRawResponse:response responseObject:responseObject error:&error];
        [self handleResponse_:responseObjc error:error];
    }];
    self.task = task;
}

- (void)willSend
{
    //do nothing
}

- (NSMutableURLRequest *)URLRequest
{
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.headerFields enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    NSString *url = [(self.baseURL ?: @"") stringByAppendingString:self.relativePath];
    NSMutableURLRequest *request = nil;
    NSString *method = self.method;
    if (![requestSerializer.HTTPMethodsEncodingParametersInURI containsObject:method]) { //不是GET,HEAD,DELETE的方法
        if (self.urlParams.allKeys.count > 0) {
            NSURLRequest *getRequest = [requestSerializer requestWithMethod:@"GET" URLString:url parameters:self.urlParams error:nil];
            url = getRequest.URL.absoluteString;
        }
        request = [requestSerializer requestWithMethod:method URLString:url parameters:self.bodyParams error:nil];
    } else {
        request = [requestSerializer requestWithMethod:method URLString:url parameters:self.urlParams error:nil];
    }
    return request;
}

- (void)willStartSessionManager:(AFHTTPSessionManager *)manager {
    //DO nothing
}

- (void)handleResponse_:(id )response error:(NSError *)error
{
    self.response = response;
    self.error = error;
    [[ABABaseRequestCenter defaultCenter] request:self didReceiveResponse:response error:error];
    if ([self.delegate respondsToSelector:@selector(request:didReceiveResponse:error:)]) {
        [self.delegate request:self didReceiveResponse:response error:error];
    }
    if (self.finished) {
        self.finished(response, error);
    }
}

- (id)transformRawResponse:(NSURLResponse *)response responseObject:(id)objc error:(NSError * *)error {

    return objc;
}

@end

@implementation ABABaseRequestBlockDelegate

+ (instancetype)blockDelegateWithWill:(ABAWillSendRequest)willSendRequest
{
    return [self blockDelegateWithWill:willSendRequest didReceiveResponse:nil];
}

+ (instancetype)blockDelegateWithWill:(ABAWillSendRequest)willSendRequest didReceiveResponse:(ABADidReceiveResponse )didReceiveResponse
{
    ABABaseRequestBlockDelegate *delegate = [[self alloc] init];
    delegate.willSendRequest = willSendRequest;
    delegate.didReceiveResponse = didReceiveResponse;
    return delegate;
}

- (void)willSendRequest:(ABABaseRequest *)request
{
    if (self.willSendRequest) {
        self.willSendRequest(request);
    }
}

- (void)request:(ABABaseRequest *)request didReceiveResponse:(id)response error:(NSError *)error
{
    if (self.didReceiveResponse) {
        self.didReceiveResponse(request, response, error);
    }
}

@end

@interface ABABaseRequestCenter ()
@property (nonatomic, strong) NSArray *delegates;
@end

@implementation ABABaseRequestCenter

+ (instancetype)defaultCenter
{
    static ABABaseRequestCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[self alloc] init];
    });
    return center;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegates = @[];
    }
    return self;
}

- (void)addRequestDelegate:(id<ABABaseRequestDelegate>)delegate
{
    self.delegates = [self.delegates arrayByAddingObject:delegate];
}

- (void)removeRequestDelegate:(id<ABABaseRequestDelegate>)delegate
{
    NSMutableArray *delegates = [_delegates mutableCopy];
    [delegates removeObject:delegate];
    self.delegates = [delegates copy];
}

- (void)willSendRequest:(ABABaseRequest *)request
{
    for (id <ABABaseRequestDelegate>delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(willSendRequest:)]) {
            [delegate willSendRequest:request];
        }
    }
}

- (void)request:(ABABaseRequest *)request didReceiveResponse:(id)response error:(NSError *)error
{
    for (id<ABABaseRequestDelegate>delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(request:didReceiveResponse:error:)]) {
            [delegate request:request didReceiveResponse:response error:error];
        }
    }
}

@end

@interface ABADownloadTask () <NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, copy) ProgressPercent progres;
@property (nonatomic, copy) DownloadComplete downLoadCompelated;
@end
@implementation ABADownloadTask

+ (NSURLSession *)sessionManager {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 30;
        NSOperationQueue *queue = [NSOperationQueue mainQueue];
        session = [NSURLSession sessionWithConfiguration:config delegate:[[self alloc] init] delegateQueue:queue];
    });
    return session;
}

+ (instancetype)downFileWithPath:(NSString *)path progressPercent:(ProgressPercent)percent completed:(DownloadComplete)completed {

    NSURLSessionDownloadTask *downloadTask = [[self.class sessionManager] downloadTaskWithURL:[NSURL URLWithString:path]];
    return [[self alloc] initWith:downloadTask progressPercent:percent completed:completed];
}

- (instancetype)initWith:(NSURLSessionTask *)task progressPercent:(ProgressPercent)percent completed:(DownloadComplete)completed{
    if (self = [super init]) {
        self.task = task;
        self.downLoadCompelated = completed;
        self.progres = percent;
    }
    return self;
}

- (void)start {
    [self.task resume];
}

- (void)stop {
    [self.task cancel];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {

}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    CGFloat value = (CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite;
    self.progres ? self.progres(value * 100) : nil;
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    self.downLoadCompelated ? self.downLoadCompelated(nil, error) : nil;
}

@end
