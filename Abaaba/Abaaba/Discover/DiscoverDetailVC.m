//
//  DiscoverDetailVC.m
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "DiscoverDetailVC.h"
#import "AbaNavigationBar.h"

@interface DiscoverDetailVC ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation DiscoverDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadData];
}

- (void)setupView{
    AbaNavigationBar *navBar = [[AbaNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 65)];
    navBar.title = self.detail.title;
    AbaCommonBtnObject *leftBtn = [AbaCommonBtnObject objWithImage:@"back-icon"];
    leftBtn.action = @selector(backClick);
    leftBtn.target = self;
    navBar.leftBtnObj = leftBtn;
    navBar.backgroundColor = KBaseColor;
    [self.view addSubview:navBar];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(navBar.frame), self.view.width, self.view.height - navBar.height)];
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)loadData{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.detail.location]];
    [self.webView loadRequest:request];
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
