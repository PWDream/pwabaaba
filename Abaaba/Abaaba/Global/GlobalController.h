//
//  GlobalController.h
//  Abaaba
//
//  Created by PW on 2018/8/13.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalController : NSObject

+(GlobalController *) shareInstance;

- (void)chooseRootViewController;
- (void)resetRootViewController;
- (void)resetRootViewController:(UIViewController *)viewController;
- (void)resetRootViewControllerForLogin;

@end
