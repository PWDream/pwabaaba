//
//  AbaLoginViewController.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaLoginViewController.h"
#import "AbaRegisterViewController.h"
#import "AbaForgetPwdViewController.h"
#import "LoginTool.h"
#import "UserTool.h"
#import "GlobalController.h"

@interface AbaLoginViewController ()
<UITextFieldDelegate>
@property(weak,nonatomic) UITextField *phoneTF;
@property(weak,nonatomic) UITextField *pwdTF;
@property(weak,nonatomic) UIButton *loginButton;
@end

@implementation AbaLoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"忘记密码" style:UIBarButtonItemStylePlain target:nil action:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];

    AbaUser *user = [AbaUser currentUser];
    self.phoneTF.text = user.userInfo.phone;
    self.pwdTF.text = user.userInfo.pwd;

}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)setUpView{
    CGFloat phoneTFY = CGRectGetMaxY(self.logoImageView.frame) + 60;
    self.phoneTF = [self setupTextField:phoneTFY placeholder:@"手机号" secureTextEntry:NO keybord:UIKeyboardTypeNumberPad];
    CGFloat pwdTFY = CGRectGetMaxY(self.phoneTF.frame) + 12;
    self.pwdTF = [self setupTextField:pwdTFY placeholder:@"密码" secureTextEntry:YES keybord:UIKeyboardTypeDefault];
    CGFloat btnX = 40,btnH = 50;
    CGFloat btnW = self.view.width - btnX * 2;
    CGFloat btnY = CGRectGetMaxY(self.pwdTF.frame) + 60;
    UIButton *loginBtn = [self button:@"登 录" frame:CGRectMake(btnX,btnY,btnW,btnH) backgrounColor:HEXCOLOR(0x9B9B9B) fontSize:[UIFont systemFontOfSize:24] titleColor:[UIColor whiteColor] action:@selector(loginClick)];
    loginBtn.enabled = NO;
    loginBtn.layer.cornerRadius = 25;
    self.loginButton = loginBtn;
    CGFloat forgetBtnW = 50,forgetBtnH = 18;
    CGFloat forgetBtnY = CGRectGetMaxY(self.loginButton.frame) + 20;
    CGFloat forgetBtnX = (self.view.width - forgetBtnW) / 2;
    CGRect forgetBtnFrame = CGRectMake(forgetBtnX, forgetBtnY, forgetBtnW, forgetBtnH);
    [self button:@"忘记密码" frame:forgetBtnFrame backgrounColor:[UIColor clearColor] fontSize:[UIFont systemFontOfSize:12] titleColor:HEXCOLOR(0x9B9B9B) action:@selector(forgetClick)];
    CGFloat registerBtnW = 140,registerBtnH = 18;
    CGFloat registerBtnY = self.view.height - registerBtnH - 60;
    CGFloat registerBtnX = (self.view.width - registerBtnW) / 2;
    CGRect registerBtnFrame = CGRectMake(registerBtnX, registerBtnY, registerBtnW, registerBtnH);
    [self button:@"还没有账号？注册新账号" frame:registerBtnFrame backgrounColor:[UIColor clearColor] fontSize:[UIFont systemFontOfSize:12] titleColor:[UIColor whiteColor] action:@selector(registerClick)];

}

- (UITextField *)setupTextField:(CGFloat)y placeholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry keybord:(UIKeyboardType)keybord{
    CGFloat w = 250,h = 40;
    CGFloat x = (self.view.width - w ) / 2;
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(x,y, w, h)];
    tf.borderStyle = UITextBorderStyleNone;
    [tf setPlaceholder:placeholder];
    [tf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setBottomLine:HEXCOLOR(0x9B9B9B) borderWidth:1];
    [tf setTextColor:[UIColor whiteColor]];
    [tf setTintColor:[UIColor whiteColor]];
    [tf setKeyboardType:keybord];
    tf.secureTextEntry = secureTextEntry;
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:tf];
    [self.containerView addSubview:tf];
    return tf;
}

- (UIButton *)button:(NSString *)title frame:(CGRect)frame backgrounColor:(UIColor *)bgColor fontSize:(UIFont *)fontSize titleColor:(UIColor *)titleColor action:(SEL)action{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:fontSize];
    [btn setBackgroundColor:bgColor];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:btn];
    return btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --点击事件

- (void)loginClick{
    if (![self validate]) {
        return;
    }
    [self showHudInView:self.view text:nil];
    [LoginTool login:@{@"phone":self.phoneTF.text,
                       @"password":self.pwdTF.text,
                       @"region":@"86",
                       } finished:^(ABABaseResponse *result, NSError *error) {
                           [self hideHud];
                           if (result.status) {
                               AbaUser *user = [[AbaUser alloc] init];
                               user.userInfo = [[UserInfoModel alloc] init];
                               user.token = result.responseOrigin[@"result"][@"token"];
                               user.userInfo.userId = result.responseOrigin[@"result"][@"id"];
                               user.userInfo.phone = self.phoneTF.text;
                               user.userInfo.pwd = self.pwdTF.text;
                               [AbaUser setCurrentUser:user postNotification:nil];
                               [UserTool getUserInfo:@{@"userId":user.userInfo.userId} finished:^(ABABaseResponse *result, NSError *error) {
                                   if (result.status) {
                                       user.userInfo.nikeName = result.responseOrigin[@"result"][@"nickname"];
                                       [AbaUser setCurrentUser:user postNotification:nil];
                                       [[GlobalController shareInstance] resetRootViewController];
                                   }
                               }];
                           }
                       }];
}

- (void)forgetClick{
    AbaForgetPwdViewController *forgetVC = [[AbaForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (void)registerClick{
    AbaRegisterViewController *registVC = [[AbaRegisterViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

- (BOOL)validate
{
    if (self.phoneTF.text.length < 1 || self.pwdTF.text.length < 1) {
        return NO;
    }
    return YES;
}

#pragma --UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidChange:(NSNotification *)noti{
    UITextField * textField = (UITextField *)noti.object;
    if(textField.text.length){
        self.loginButton.backgroundColor = KBaseColor;
        self.loginButton.enabled = YES;
    }else{
        self.loginButton.backgroundColor = HEXCOLOR(0x9B9B9B);
        self.loginButton.enabled = NO;
    }
}

@end
