//
//  UIImage+Aba.h
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Aba)

+ (UIImage *)imageWithName:(NSString *)imageName;

+ (UIImage *)resizeWithName:(NSString *)imageName;

+ (UIImage *)resizeWithName:(NSString *)imageName leftRate:(CGFloat)leftRate topRatio:(CGFloat)topRatio;

@end
