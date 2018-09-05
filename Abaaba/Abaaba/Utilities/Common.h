//
//  Common.h
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#define KScreenH [UIScreen mainScreen].bounds.size.height               //屏幕的高度
#define KScreenW [UIScreen mainScreen].bounds.size.width                //屏幕的宽带
//配置参数
#define ToastDuration 2.0f      //Toast动画执行时间
#define ToastOffset 50.0f       //Toast偏移量

//颜色宏定义
#define AbaColorWithAlpha(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >>16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:alphaValue]      //16进制宏定义
#define KBaseColor AbaColorWithAlpha(KBaseColorStr,1)                                             //应用程序的基本主色调
#define KBaseColorStr 0x00DDB9//应用主色调16进制

#define AbaNavBarColor 0x4A4A4A

#define kBaseTabbarColor 0xff689a

#define IOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)

//状态栏的高度
#define KStatueBarH (IOS7 ? 20 : 0)
//导航栏的高度
#define KNavBarH (KStatueBarH + 44)
//自定义导航栏的颜色
#define AbaCustomNarBgColor AbaColorWithAlpha(0xf6f6f6, 1)

#define ABAHTTPCOOKIENAME @"ABAHTTPCOOKIE"


#import <UIKit/UIKit.h>

@interface Common : UIView

@end
