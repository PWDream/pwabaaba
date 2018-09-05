//
//  UIColor+Aba.h
//  Abaaba
//
//  Created by PW on 2018/8/4.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Aba)
/**
 *  根据16进制字符串生成UIColor对象
 *
 *  @param hex 十六进制字符串，支持6字符和8字符，8字符时最后两个字符表示alpha
 *
 *  @return 生成的color对象
 */
+ (instancetype)aba_colorWithHexString:(NSString *)hex;
@end
