//
//  UIBarButtonItem+Aba.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UIBarButtonItem+Aba.h"

@implementation UIBarButtonItem (Aba)

+ (instancetype)itmeWitImage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton itmeWitImage:image hightImage:hightImage target:target action:action];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
