//
//  MySectionView.h
//  Abaaba
//
//  Created by PW on 2018/8/12.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionViewDelegate <NSObject>

@optional

- (void)sectionItemClicked:(NSInteger)key;

@end

@interface MySectionView : UIView

@property (nonatomic, weak) id <SectionViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame sections:(NSArray *)sections;

@end
