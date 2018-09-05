//
//  UIView+AbaXibLoad.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UIView+AbaXibLoad.h"

@implementation UIView (AbaXibLoad)

+ (NSString *)aba_xibName{
    return [self description];
}
+ (instancetype)aba_createViewFromXibWithOwner:(id)owner{
    return [[NSBundle mainBundle] loadNibNamed:[self aba_xibName] owner:owner options:nil].lastObject;
}

@end
