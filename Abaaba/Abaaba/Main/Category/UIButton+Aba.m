//
//  UIButton+Aba.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UIButton+Aba.h"

@implementation UIButton (Aba)

+ (instancetype)itmeWitImage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:hightImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
