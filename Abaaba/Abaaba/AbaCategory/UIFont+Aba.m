//
//  UIFont+Aba.m
//  Abaaba
//
//  Created by PW on 2018/8/4.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UIFont+Aba.h"

@implementation UIFont (Aba)

+ (UIFont *)moneyFontOfSize:(CGFloat)fontSize{
    if ([UIDevice currentDevice].systemVersion.floatValue < 9.0) {
        return  [UIFont fontWithName:@"Century Gothic" size:fontSize];
    }else{
        return [UIFont systemFontOfSize:fontSize];
    }
}

@end
