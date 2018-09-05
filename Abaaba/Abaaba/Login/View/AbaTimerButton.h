//
//  AbaTimerButton.h
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbaTimerButton : UIButton

- (void)setFormatString:(NSString *)formatString;

- (void)startTimer:(NSInteger)interval;

- (void)stopTimer;

@end
