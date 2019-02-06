//
//  MaxCountdownSettingView.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import "MaxCountdownSettingView.h"
#import "UserDefaultsTool.h"

@interface MaxCountdownSettingView ()
- (IBAction)click25:(UIButton *)sender;
- (IBAction)click30:(UIButton *)sender;
- (IBAction)click0010:(UIButton *)sender;

@end

@implementation MaxCountdownSettingView

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)postNotification {
    [NSNotificationCenter.defaultCenter postNotificationName:@"resetMaxCountdown" object:nil];
}

- (IBAction)click25:(UIButton *)sender {
    [UserDefaultsTool.sharedUserDefaultsTool setMaxCountdownSeconds: 25 * 60];
    [self postNotification];
}

- (IBAction)click30:(UIButton *)sender {
    [UserDefaultsTool.sharedUserDefaultsTool setMaxCountdownSeconds: 30 * 60];
    [self postNotification];
}

- (IBAction)click0010:(UIButton *)sender {
    [UserDefaultsTool.sharedUserDefaultsTool setMaxCountdownSeconds: 10];
    [self postNotification];
}
@end
