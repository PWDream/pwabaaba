//
//  ABAMainNavigationBar.h
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbaCommonBtnObject.h"

@interface ABAMainNavigationBar : UIView
/** 右边的按钮 */
@property (nonatomic, strong) AbaCommonBtnObject *rightBtnObj;
/** 左边的按钮 */
@property (nonatomic, strong) AbaCommonBtnObject *leftBtnObj;
/** 左边标题 */
@property (nonatomic, copy) NSString *leftTitle;
/** 标题的字体颜色 */
@property (nonatomic, copy) UIColor *titleColor;
/** 显示分割线 */
@property (nonatomic, assign) BOOL hideDivid;

@end
