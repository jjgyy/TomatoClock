//
//  MaxCountdownSettingView.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import "MaxCountdownSettingView.h"
#import "SettingTool.h"

@interface MaxCountdownSettingView ()
- (IBAction)click25:(UIButton *)sender;
- (IBAction)click30:(UIButton *)sender;
- (IBAction)click45:(UIButton *)sender;

@end

@implementation MaxCountdownSettingView

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)postNotification {
    [NSNotificationCenter.defaultCenter postNotificationName:@"resetMaxCountdown" object:nil];
}

- (IBAction)click25:(UIButton *)sender {
    [SettingTool setMaxCountdownSeconds: 25 * 60];
    [self postNotification];
}

- (IBAction)click30:(UIButton *)sender {
    [SettingTool setMaxCountdownSeconds: 30 * 60];
    [self postNotification];
}

- (IBAction)click45:(UIButton *)sender {
    [SettingTool setMaxCountdownSeconds: 45 * 60];
    [self postNotification];
}
@end
