//
//  MaxCountdownSettingView.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import "MaxCountdownSettingViewController.h"
#import "UserDefaultsTool.h"

@interface MaxCountdownSettingViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *smallTomatoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *middleTomatoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *bigTomatoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *customizedTomatoCell;

@end

@implementation MaxCountdownSettingViewController

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
    [NSNotificationCenter.defaultCenter postNotificationName:@"resetMaxCountdown" object:nil];
}

- (void)setCheckmarkWithUserDefaults {
    NSInteger maxCountdownSeconds = [UserDefaultsTool.sharedUserDefaultsTool maxCountdownSeconds];
    switch (maxCountdownSeconds) {
        case 25*60:
            self.smallTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 45*60:
            self.middleTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 60*60:
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
    [UserDefaultsTool.sharedUserDefaultsTool setMaxCountdownSeconds: 25 * 60];
    [self postNotification];
}

- (void)chooseMiddleTomato {
    [self clearAllCheckmark];
    self.middleTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [UserDefaultsTool.sharedUserDefaultsTool setMaxCountdownSeconds: 45 * 60];
    [self postNotification];
}

- (void)chooseBigTomato {
    [self clearAllCheckmark];
    self.bigTomatoCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [UserDefaultsTool.sharedUserDefaultsTool setMaxCountdownSeconds: 60 * 60];
    [self postNotification];
}

@end
