//
//  AbaForgetPwdViewController.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaForgetPwdViewController.h"
#import "LoginTool.h"

@interface AbaForgetPwdViewController ()
<UITextFieldDelegate>
@property(weak,nonatomic) UITextField *phoneTF;
@property(weak,nonatomic) UITextField *captTF;
@property(weak,nonatomic) UITextField *pwdTF;
@property(weak,nonatomic) UITextField *comfirmPwdTF;
@property(weak,nonatomic) UIButton *captButton;
@property(weak,nonatomic) UIButton *confirmButton;
@end

@implementation AbaForgetPwdViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpView{
    CGFloat defaultW = 250;
    CGFloat phoneTFY = CGRectGetMaxY(self.logoImageView.frame) + 12;
    self.phoneTF = [self setupTextField:0 y:phoneTFY w:defaultW placeholder:@"手机号" secureTextEntry:NO keybord:UIKeyboardTypeNumberPad];
    CGFloat captTFY = CGRectGetMaxY(self.phoneTF.frame) + 12;
    self.captTF = [self setupTextField:self.phoneTF.x y:captTFY w:175 placeholder:@"验证码" secureTextEntry:NO keybord:UIKeyboardTypeNumberPad];
    CGFloat captBtnX = CGRectGetMaxX(self.captTF.frame) + 1;
    CGFloat captBtnY = self.captTF.y + 10,captBtnW = 75,captBtnH = 30;
    CGRect catpBtnFrame = CGRectMake(captBtnX, captBtnY, captBtnW, captBtnH);
    self.captButton = [self button:@"发送验证码" frame:catpBtnFrame backgrounColor:[UIColor clearColor] fontSize:[UIFont systemFontOfSize:12] titleColor:[UIColor whiteColor] action:@selector(captClick)];
    self.captButton.backgroundColor = HEXCOLOR(0x00DDB9);
    self.captButton.alpha = 0.5;

    CGFloat pwdTFY = CGRectGetMaxY(self.captTF.frame) + 12;
    self.pwdTF = [self setupTextField:0 y:pwdTFY w:defaultW placeholder:@"密码" secureTextEntry:YES keybord:UIKeyboardTypeDefault];
    CGFloat confirmPwdTFY = CGRectGetMaxY(self.pwdTF.frame) + 12;
    self.pwdTF = [self setupTextField:0 y:confirmPwdTFY w:defaultW placeholder:@"确认密码" secureTextEntry:YES keybord:UIKeyboardTypeDefault];

    CGFloat btnX = 40,btnH = 50;
    CGFloat btnW = self.view.width - btnX * 2;
    CGFloat btnY = CGRectGetMaxY(self.pwdTF.frame) + 60;
    UIButton *confirmBtn = [self button:@"注册" frame:CGRectMake(btnX,btnY,btnW,btnH) backgrounColor:HEXCOLOR(0x9B9B9B) fontSize:[UIFont systemFontOfSize:24] titleColor:[UIColor whiteColor] action:@selector(confirmClick)];
    confirmBtn.enabled = NO;
    confirmBtn.layer.cornerRadius = 25;
    self.confirmButton = confirmBtn;

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

- (void)captClick{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)confirmClick{

}

#pragma --UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidChange:(NSNotification *)noti{
    UITextField * textField = (UITextField *)noti.object;
    if(textField.text.length){
        self.confirmButton.backgroundColor = KBaseColor;
        self.confirmButton.enabled = YES;
    }else{
        self.confirmButton.backgroundColor = HEXCOLOR(0x9B9B9B);
        self.confirmButton.enabled = NO;
    }
}

@end
