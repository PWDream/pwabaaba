//
//  AbaTimerButton.m
//  Abaaba
//
//  Created by PW on 2018/8/5.
//  Copyright © 2018年 PW. All rights reserved.
//

#import "AbaTimerButton.h"

@interface AbaTimerButton()
{
    NSInteger _timerInterval;
    NSTimer *_timer;
    NSString *_formatString;
}
@end

@implementation AbaTimerButton

- (void)startTimer:(NSInteger)interval
{
    [self setTitleColor:KBaseColor forState:UIControlStateNormal];

    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    if (interval > 0) {
        _timerInterval = interval;
        self.enabled = NO;
        [self updateButtonState];

        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(timeOut:)
                                                userInfo:nil
                                                 repeats:YES];
    }

}

- (void)stopTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        _timerInterval = 0;
    }
    [self updateButtonState];
}

- (void)timeOut:(NSTimer *)timer
{
    _timerInterval--;
    if (_timerInterval > 0) {
    }
    else {
        [self stopTimer];
    }
    [self updateButtonState];
}

- (void)setFormatString:(NSString *)formatString
{
    _formatString = formatString;
}

- (void)updateButtonState
{
    if (_timerInterval > 0) {
        [self setTitle:[NSString stringWithFormat:@"%zd秒", _timerInterval] forState:UIControlStateDisabled];
    }
    else {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.enabled = YES;
    }
}

@end
