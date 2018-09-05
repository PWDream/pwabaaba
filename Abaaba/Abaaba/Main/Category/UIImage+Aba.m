//
//  UIImage+Aba.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "UIImage+Aba.h"

@implementation UIImage (Aba)

+ (UIImage *)imageWithName:(NSString *)imageName
{
    UIImage *image = nil;
    
    if (IOS7)
    {
        NSString *ios7Image = [imageName stringByAppendingString:@"_os7"];
        image = [self imageNamed:ios7Image];
    }

    if (image == nil) {
        image = [self imageNamed:imageName];
    }

    return image;
}

+ (UIImage *)resizeWithName:(NSString *)imageName
{
    return [self resizeWithName:imageName leftRate:0.5 topRatio:0.5];
}

+ (UIImage *)resizeWithName:(NSString *)imageName leftRate:(CGFloat)leftRate topRatio:(CGFloat)topRatio
{
    UIImage *image = [self imageWithName:imageName];
    CGFloat left = image.size.width * leftRate;
    CGFloat top = image.size.height * topRatio;
    return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}

@end
