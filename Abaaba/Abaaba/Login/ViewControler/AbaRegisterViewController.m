//
//  AbaRegisterViewController.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaRegisterViewController.h"
#import "AbaLoginViewController.h"
#import "AbaTimerButton.h"
#import "LoginTool.h"
#import "GlobalController.h"

@interface AbaRegisterViewController ()
<UITextFieldDelegate>
@property(weak,nonatomic) UITextField *nikeNameTF;
@property(weak,nonatomic) UITextField *phoneTF;
@property(weak,nonatomic) UITextField *captTF;
@property(weak,nonatomic) UITextField *pwdTF;
@property(weak,nonatomic) AbaTimerButton *captButton;
@property(weak,nonatomic) UIButton *registerButton;
@property(weak,nonatomic) UIButton *loginButton;
@property (strong, nonatomic) NSString *verification_token;
@end

@implementation AbaRegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)setUpView{
    CGFloat defaultW = 250;
    CGFloat nikeNameTFY = CGRectGetMaxY(self.logoImageView.frame) + 60;
    self.nikeNameTF = [self setupTextField:0 y:nikeNameTFY w:defaultW placeholder:@"昵称" secureTextEntry:NO keybord:UIKeyboardTypeDefault];
    CGFloat phoneTFY = CGRectGetMaxY(self.nikeNameTF.frame) + 12;
    self.phoneTF = [self setupTextField:0 y:phoneTFY w:defaultW placeholder:@"手机号" secureTextEntry:NO keybord:UIKeyboardTypeNumberPad];
    CGFloat captTFY = CGRectGetMaxY(self.phoneTF.frame) + 12;
    self.captTF = [self setupTextField:self.phoneTF.x y:captTFY w:175 placeholder:@"验证码" secureTextEntry:NO keybord:UIKeyboardTypeNumberPad];
    CGFloat captBtnX = CGRectGetMaxX(self.captTF.frame) + 1;
    CGFloat captBtnY = self.captTF.y + 10,captBtnW = 75,captBtnH = 30;
    CGRect catpBtnFrame = CGRectMake(captBtnX, captBtnY, captBtnW, captBtnH);
    AbaTimerButton *captBtn = [[AbaTimerButton alloc] initWithFrame:catpBtnFrame];
    [captBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [captBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [captBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [captBtn addTarget:self action:@selector(captClick:) forControlEvents:UIControlEventTouchUpInside];
    [captBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self.containerView addSubview:captBtn];
    captBtn.backgroundColor = HEXCOLOR(0x00DDB9);
    self.captButton = captBtn;

    CGFloat pwdTFY = CGRectGetMaxY(self.captTF.frame) + 12;
    self.pwdTF = [self setupTextField:0 y:pwdTFY w:defaultW placeholder:@"密码" secureTextEntry:YES keybord:UIKeyboardTypeDefault];
    CGFloat btnX = 40,btnH = 50;
    CGFloat btnW = self.view.width - btnX * 2;
    CGFloat btnY = CGRectGetMaxY(self.pwdTF.frame) + 60;
    UIButton *registerBtn = [self button:@"注册" frame:CGRectMake(btnX,btnY,btnW,btnH) backgrounColor:HEXCOLOR(0x9B9B9B) fontSize:[UIFont systemFontOfSize:24] titleColor:[UIColor whiteColor] action:@selector(registerClick)];
    registerBtn.enabled = NO;
    registerBtn.layer.cornerRadius = 25;
    self.registerButton = registerBtn;
    CGFloat registerBtnW = 140,registerBtnH = 18;
    CGFloat registerBtnY = self.view.height - registerBtnH - 40;
    CGFloat registerBtnX = (self.view.width - registerBtnW) / 2;
    CGRect registerBtnFrame = CGRectMake(registerBtnX, registerBtnY, registerBtnW, registerBtnH);
    [self button:@"已有账号？登录" frame:registerBtnFrame backgrounColor:[UIColor clearColor] fontSize:[UIFont systemFontOfSize:12] titleColor:[UIColor whiteColor] action:@selector(loginClick)];

}

- (UITextField *)setupTextField:(CGFloat)x y:(CGFloat)y w:(CGFloat)w placeholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry keybord:(UIKeyboardType)keybord{
    CGFloat h = 40;
    CGFloat xx = x > 0 ? x : (self.view.width - w ) / 2;
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(xx,y, w, h)];
    tf.borderStyle = UITextBorderStyleNone;
    [tf setPlaceholder:placeholder];
    [tf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [tf setBottomLine:HEXCOLOR(0x9B9B9B) borderWidth:1];
    [tf setTextColor:[UIColor whiteColor]];
    [tf setTintColor:[UIColor whiteColor]];
    [tf setKeyboardType:keybord];
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;//设置首字母小写
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

#pragma --点击事件

- (void)loginClick{
    AbaLoginViewController *temp = [[AbaLoginViewController alloc] init];
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;        //可更改为其他方式
    transition.subtype = kCATransitionFromLeft; //可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:temp animated:NO];
}

- (void)captClick:(AbaTimerButton *)btn{
    if (self.phoneTF.text.length < 1) {
        return;
    }
    [self showHudInView:self.view text:nil];
    [btn startTimer:60];
    [LoginTool getCaptcha:@{@"region":@"86",@"phone":self.phoneTF.text} finished:^(ABABaseResponse *result, NSError *error) {
        [self hideHud];
        if (result.status) {
            [self showToast:@"发送成功"];
        }else{
            [self showToast:result.message];
        }
    }];
}

- (void)registerClick{
    if(![self validate]){
        return;
    }
    [self showHudInView:self.view text:nil];
    NSDictionary *checkPhoneParam = @{@"phone":self.phoneTF.text,
                                      @"region":@"86",
                                      @"code":self.captTF.text
                                      };
    [LoginTool checkCaptcha:checkPhoneParam finished:^(ABABaseResponse *result, NSError *error) {
        if (result.status) {
            NSDictionary *params = @{@"nickname":self.nikeNameTF.text,
                                     @"verification_token":result.responseOrigin[@"result"][@"verification_token"],
                                     @"password":self.pwdTF.text,
                                     };
            [LoginTool registerUser:params finished:^(ABABaseResponse *result, NSError *error) {
                if (result.status) {
                    AbaUser *user = [[AbaUser alloc] init];
                    user.userInfo = [[UserInfoModel alloc] init];
                    user.userInfo.userId = [NSString stringWithFormat:@"%@",result.responseOrigin[@"result"][@"id"]];
                    user.userInfo.phone = self.phoneTF.text;
                    user.userInfo.pwd = self.pwdTF.text;
                    [AbaUser setCurrentUser:user postNotification:nil];
                    [self showToast:@"注册成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self showToast:result.message];
                }
                [self hideHud];
            }];
        }else{
            [self showToast:result.message];
            [self hideHud];
        }
    }];
}

- (BOOL)validate{

    if(self.nikeNameTF.text.length < 1){
        [self.nikeNameTF becomeFirstResponder];
        return NO;
    }
    if(self.phoneTF.text.length < 6){
        [self.phoneTF becomeFirstResponder];
        return NO;
    }
    if(self.pwdTF.text.length < 6){
        [self.pwdTF becomeFirstResponder];
        return NO;
    }
    if(self.captTF.text.length < 1){
        [self.captTF becomeFirstResponder];
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneTF && textField.text.length > 1) {
        [LoginTool checkPhoneNum:@{@"phone":textField.text,@"region":@"86"} finished:^(ABABaseResponse *result, NSError *error) {
            if (!result.status) {
                [self showToast:result.message];
            }
        }];
    }
}


- (void)textFieldDidChange:(NSNotification *)noti{
    UITextField * textField = (UITextField *)noti.object;
    if(textField.text.length){
        self.registerButton.backgroundColor = KBaseColor;
        self.registerButton.enabled = YES;
    }else{
        self.registerButton.backgroundColor = HEXCOLOR(0x9B9B9B);
        self.registerButton.enabled = NO;
    }
}


@end
