//
//  AbaCommonBtnObject.h
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbaCommonBtnObject : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 标题颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 图片 */
@property (nonatomic, copy) NSString *image;
/** 高亮的图片 */
@property (nonatomic, copy) NSString *hightImage;
/** 选中的图片 */
@property (nonatomic, copy) NSString *selectImage;
/** 对象 */
@property (nonatomic, strong) id target;
/** 事件 */
@property (nonatomic) SEL action;
/** 要调往的类 */
@property (nonatomic, assign) Class destVC;
/** 操作 */
@property (nonatomic, copy) void (^operation)();

+ (instancetype)objWithTilte:(NSString *)title;

+ (instancetype)objWithImage:(NSString *)image;

+ (instancetype)objWithTilte:(NSString *)title image:(NSString *)image;

+ (instancetype)objWithTilte:(NSString *)title image:(NSString *)image hightImage:(NSString *)hightImage;

+ (instancetype)objWithTilte:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage;

@end
