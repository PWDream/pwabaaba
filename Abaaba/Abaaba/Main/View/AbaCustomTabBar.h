//
//  AbaCustomTabBar.h
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AbaCustomTabBar;

@protocol AbaCustomTabBarDelegate <NSObject>

@optional

- (void)tabBarClicked:(AbaCustomTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to;

@end

@interface AbaCustomTabBar : UIView

@property (nonatomic, weak) id<AbaCustomTabBarDelegate> delegate;

- (void)addBarButton:(UITabBarItem *)item;

@end
