//
//  MaxCountdownSettingView.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import "TomatoTimeSettingViewController.h"
#import "UserDefaultsTool.h"

@interface TomatoTimeSettingViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *smallTomatoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *middleTomatoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *bigTomatoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *customizedTomatoCell;

@end

@implementation TomatoTimeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCheckmarkWithUserDefaults];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self chooseSmallTomato];
            break;
        case 1:
            [self chooseMiddleTomato];
            break;
        case 2:
            [self chooseBigTomato];
            break;
        default:
            break;
    }
}

- (void)postNotification {
    [NSNotificationCenter.defaultCenter postNotificationName:@"resetTomatoTime" object:nil];
}

- (void)setCheckmarkWithUserDefaults {
    NSInteger maxCountdownSeconds = [UserDefaultsTool.sharedUserDefaultsTool maxWorkSeconds];
    switch (maxCountdownSeconds) {
        case 2:
            self.smallTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 3:
            self.middleTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 4:
            self.bigTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        default:
            self.customizedTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
    }
}

- (void)clearAllCheckmark {
    self.smallTomatoCell.accessoryType = UITableViewCellAccessoryNone;
    self.middleTomatoCell.accessoryType = UITableViewCellAccessoryNone;
    self.bigTomatoCell.accessoryType = UITableViewCellAccessoryNone;
    self.customizedTomatoCell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)chooseSmallTomato {
    [self clearAllCheckmark];
    self.smallTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [UserDefaultsTool.sharedUserDefaultsTool setMaxWorkSeconds: 2];
    [UserDefaultsTool.sharedUserDefaultsTool setMaxRestSeconds: 5];
    [self postNotification];
}

- (void)chooseMiddleTomato {
    [self clearAllCheckmark];
    self.middleTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [UserDefaultsTool.sharedUserDefaultsTool setMaxWorkSeconds: 3];
    [UserDefaultsTool.sharedUserDefaultsTool setMaxRestSeconds: 10];
    [self postNotification];
}

- (void)chooseBigTomato {
    [self clearAllCheckmark];
    self.bigTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [UserDefaultsTool.sharedUserDefaultsTool setMaxWorkSeconds: 4];
    [UserDefaultsTool.sharedUserDefaultsTool setMaxRestSeconds: 15];
    [self postNotification];
}

@end
