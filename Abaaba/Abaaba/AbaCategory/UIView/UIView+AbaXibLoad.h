//
//  UIView+AbaXibLoad.h
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AbaXibLoad)
+ (NSString *)aba_xibName;
+ (instancetype)aba_createViewFromXibWithOwner:(id)owner;
@end
