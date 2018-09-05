//
//  BaseLoginViewController.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "BaseLoginViewController.h"
#import "AbaAnimatedImagesView.h"

@interface BaseLoginViewController ()
<AnimatedImagesViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,retain) AbaAnimatedImagesView *animatedImagesView;
@end

@implementation BaseLoginViewController

- (AbaAnimatedImagesView *)animatedImagesView{
    if (!_animatedImagesView) {
        self.animatedImagesView = [[AbaAnimatedImagesView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    }
    return _animatedImagesView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDynamicView];
    self.view.backgroundColor = [UIColor grayColor];
    [self setupContainer];
    [self setupLogo:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.animatedImagesView startAnimating];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.animatedImagesView stopAnimating];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [self setAnimatedImagesView:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLogo:(BOOL)isShowLogo{
    if (isShowLogo) {
        CGFloat w = 160,h = 137,y = 80;
        CGFloat x = (self.view.width - w) / 2;
        UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        logoImageView.image = [UIImage imageNamed:@"login_logo"];
        [self.containerView addSubview:logoImageView];
        self.logoImageView = logoImageView;
    }
}


- (void)loadDynamicView {
    [self.view addSubview:self.animatedImagesView];
    self.animatedImagesView.delegate = self;
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void)setupContainer{
    TPKeyboardAvoidingScrollView *container = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    container.alwaysBounceVertical = YES;
    [self.view addSubview:container];
    self.containerView = container;
}

#pragma ---滚动试图委托

- (NSUInteger)animatedImagesNumberOfImages:(AbaAnimatedImagesView *)animatedImagesView {
    return 2;
}

- (UIImage *)animatedImagesView:(AbaAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index {
    return [UIImage imageNamed:@"login_background.png"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
