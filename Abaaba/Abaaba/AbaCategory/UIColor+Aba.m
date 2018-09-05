//
//  UIColor+Aba.m
//  Abaaba
//
//  Created by PW on 2018/8/4.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UIColor+Aba.h"

@implementation UIColor (Aba)

/**
 *  根据16进制字符串生成UIColor对象
 *
 *  @param hex 十六进制字符串，支持6字符和8字符，8字符时最后两个字符表示alpha
 *
 *  @return 生成的color对象
 */
+ (instancetype)aba_colorWithHexString:(NSString *)hex{
    if (!hex) {//当HEX为空的时候默认返回白色
        return [UIColor whiteColor];
    }
    hex = [hex stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"^[0-9a-f]+$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger matchCount = [regularExpression numberOfMatchesInString:hex options:NSMatchingReportCompletion range:NSMakeRange(0, hex.length)];
    if (matchCount == 0) {
        return nil;
    }
    unsigned long long value = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexLongLong:&value];
    if (hex.length == 8) {
        return [self colorWithRed:((value >> 24) & 0xff)/255.0f green:((value >> 16) & 0xff)/255.0f blue:((value >> 8) & 0xff)/255.0f alpha:(value & 0xff)/255.0f];
    } else if(hex.length == 6) {
        return [self colorWithRed:((value >> 16) & 0xff)/255.0f green:((value >> 8) & 0xff)/255.0f blue:(value & 0xff)/255.0f alpha:1];
    } else {
        return nil;
    }
}

@end
