//
//  ABAScrollView.h
//  Abaaba
//
//  Created by PW on 2018/8/19.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABAScrollView;

@protocol ABAscrollViewViewDelegate <NSObject>

@optional
- (void)didClickPage:(ABAScrollView *)view atIndex:(NSInteger)index;

@end


@interface ABAScrollView : UIView
@property (nonatomic, weak) id <ABAscrollViewViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

-(void)shouldAutoShow:(BOOL)shouldStart;

@end
