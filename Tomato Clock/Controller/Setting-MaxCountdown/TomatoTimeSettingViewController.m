//
//  MaxCountdownSettingView.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import "TomatoTimeSettingViewController.h"
#import "UserDefaultsUtil.h"

@interface TomatoTimeSettingViewController ()
@end

@implementation TomatoTimeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)postNotification {
    [NSNotificationCenter.defaultCenter postNotificationName:@"resetTomatoTime" object:nil];
}

@end
