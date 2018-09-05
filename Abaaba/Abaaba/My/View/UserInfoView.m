//
//  UserInfoView.m
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UserInfoView.h"

@interface UserInfoView()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *btcLabel;
@property (weak, nonatomic) IBOutlet UILabel *cnyLabel;
@property (nonatomic,assign) BOOL watch;
@end

@implementation UserInfoView

+ (UserInfoView *)userInfoView{
    return [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:nil options:nil] lastObject];;
}

- (void)setUserInfoModel:(UserInfoModel *)userInfoModel{
    _userInfoModel = userInfoModel;
    self.avatarImageView.image = [UIImage imageWithName:userInfoModel.avatar];
    self.nameLabel.text = userInfoModel.name;
    self.nikeLabel.text = userInfoModel.nikeName;
    self.btcLabel.text = userInfoModel.btc;
    self.cnyLabel.text = userInfoModel.cny;
}

- (IBAction)editAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(editUserClicked:)]){
        [self.delegate editUserClicked:self.userInfoModel];
    }
}

- (IBAction)watchAction:(id)sender {
    if(self.watch){
        self.btcLabel.text = self.userInfoModel.btc;
        self.cnyLabel.text = self.userInfoModel.cny;
    }else{
        self.btcLabel.text = @"*";
        self.cnyLabel.text = @"*";
    }
    self.watch = !self.watch;
}


@end
