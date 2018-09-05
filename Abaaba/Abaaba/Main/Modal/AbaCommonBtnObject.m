//
//  AbaCommonBtnObject.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaCommonBtnObject.h"

@implementation AbaCommonBtnObject

+ (instancetype)objWithTilte:(NSString *)title
{
    return [self objWithTilte:title image:nil];
}

+ (instancetype)objWithImage:(NSString *)image
{
    return [self objWithTilte:nil image:image];
}

+ (instancetype)objWithTilte:(NSString *)title image:(NSString *)image
{
    return [self objWithTilte:title image:image selectImage:nil];
}

+ (instancetype)objWithTilte:(NSString *)title image:(NSString *)image hightImage:(NSString *)hightImage
{
    AbaCommonBtnObject *comm = [[self alloc] init];
    comm.title = title;
    comm.image = image;
    comm.hightImage = hightImage;
    return comm;
}

+ (instancetype)objWithTilte:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    AbaCommonBtnObject *comm = [[self alloc] init];
    comm.title = title;
    comm.image = image;
    comm.selectImage = selectImage;
    return comm;
}

@end
