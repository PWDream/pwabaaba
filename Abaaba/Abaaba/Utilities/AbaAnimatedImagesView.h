//
//  AbaAnimatedImagesView.h
//  Abaaba
//
//  Created by PW on 2018/8/4.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kJSAnimatedImagesViewDefaultTimePerImage 20.0f

@protocol AnimatedImagesViewDelegate;


@interface AbaAnimatedImagesView : UIView

@property(nonatomic, weak) id<AnimatedImagesViewDelegate> delegate;

@property(nonatomic, assign) NSTimeInterval timePerImage;

- (void)startAnimating;
- (void)stopAnimating;

- (void)reloadData;

@end

@protocol AnimatedImagesViewDelegate
- (NSUInteger)animatedImagesNumberOfImages:(AbaAnimatedImagesView *)animatedImagesView;
- (UIImage *)animatedImagesView:(AbaAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index;
@end

