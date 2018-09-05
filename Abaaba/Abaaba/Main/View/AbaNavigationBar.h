//
//  AbaNavigationBar.h
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbaCommonBtnObject.h"

@interface AbaNavigationBar : UIView

/** 右边的按钮 */
@property (nonatomic, strong) AbaCommonBtnObject *rightBtnObj;
/** 左边的按钮 */
@property (nonatomic, strong) AbaCommonBtnObject *leftBtnObj;
/** 中间的视图 */
@property (nonatomic, weak) UIView *titleView;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 标题的字体颜色 */
@property (nonatomic, copy) UIColor *titleColor;
/** 显示分割线 */
@property (nonatomic, assign) BOOL hideDivid;

@end
