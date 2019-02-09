//
//  MenuViewController.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/9.
//  Copyright © 2019 Young. All rights reserved.
//

#import "MenuViewController.h"
#import "UserDefaultsTool.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *autoTomatoSwitch;
- (IBAction)clickAutoTomatoSwitch:(UISwitch *)sender;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.autoTomatoSwitch setOn: [UserDefaultsTool.sharedUserDefaultsTool isAutoTomato]];
}

- (IBAction)clickAutoTomatoSwitch:(UISwitch *)sender {
    BOOL isAutoTomato = [UserDefaultsTool.sharedUserDefaultsTool isAutoTomato];
    [UserDefaultsTool.sharedUserDefaultsTool setIsAutoTomato: !isAutoTomato];
    [self.autoTomatoSwitch setOn: !isAutoTomato];
}

@end
