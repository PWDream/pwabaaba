//
//  AbaViewController.h
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbaNavigationBar.h"
#import "ABAMainNavigationBar.h"

@interface AbaViewController : UIViewController

@property (nonatomic, weak) AbaNavigationBar *navBar;
@property (nonatomic, weak) ABAMainNavigationBar *mainNavBar;
/** 存放子功能的数组 */
@property (nonatomic, strong) NSArray *funcBtnArray;
@property (nonatomic, assign) BOOL isMainVC;

- (void)backClicked;

@end
