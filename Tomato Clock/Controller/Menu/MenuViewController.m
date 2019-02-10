//
//  MenuViewController.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/9.
//  Copyright © 2019 Young. All rights reserved.
//

#import "MenuViewController.h"
#import "UserDefaultsUtil.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *autoTomatoSwitch;
- (IBAction)clickAutoTomatoSwitch:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UISwitch *allowTomatoOverNotificationSwitch;
- (IBAction)clickAllowTomatoOverNotificationSwitch:(UISwitch *)sender;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.autoTomatoSwitch setOn: [UserDefaultsUtil.sharedUserDefaultsUtil isAutoTomato]];
    [self.allowTomatoOverNotificationSwitch setOn: [UserDefaultsUtil.sharedUserDefaultsUtil isAllowingTomatoOverNotification]];
}

- (IBAction)clickAutoTomatoSwitch:(UISwitch *)sender {
    BOOL isAutoTomato = self.autoTomatoSwitch.isOn;
    NSLog(@"自动番茄循环：%d",isAutoTomato);
    [UserDefaultsUtil.sharedUserDefaultsUtil setIsAutoTomato: isAutoTomato];
    [NSNotificationCenter.defaultCenter postNotificationName: @"resetIsAutoTomato" object:nil];
}

- (IBAction)clickAllowTomatoOverNotificationSwitch:(UISwitch *)sender {
    BOOL isAllowingTomatoOverNotification = self.allowTomatoOverNotificationSwitch.isOn;
    NSLog(@"允许番茄时结束通知：%d",isAllowingTomatoOverNotification);
    [UserDefaultsUtil.sharedUserDefaultsUtil setIsAllowingTomatoOverNotification: isAllowingTomatoOverNotification];
    [NSNotificationCenter.defaultCenter postNotificationName: @"resetIsAllowingTomatoOverNotification" object: nil];
}
@end
