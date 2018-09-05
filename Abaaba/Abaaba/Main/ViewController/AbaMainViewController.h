//
//  AbaMainViewController.h
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbaNavigationBar.h"


@interface AbaMainViewController : UIViewController

@property (nonatomic, weak) AbaNavigationBar *navBar;

/**
 *  添加功能子视图
 *
 *  @param funcArray 功能数组
 *  @param position  位置
 */
- (void)addFunctionView:(NSArray *)funcArray position:(CGRect)position;


@end
