//
//  MaxCountdownSettingView.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import "TomatoTimeSettingViewController.h"
#import "UserDefaultsUtil.h"
#import "ActionSheetPicker.h"

@interface TomatoTimeSettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *workTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *restTimeLabel;
@end

@implementation TomatoTimeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.workTimeLabel.text = [NSString stringWithFormat:@"%ld 分钟", [UserDefaultsUtil.sharedUserDefaultsUtil maxWorkSeconds] / 60];
    self.restTimeLabel.text = [NSString stringWithFormat:@"%ld 分钟", [UserDefaultsUtil.sharedUserDefaultsUtil maxRestSeconds] / 60];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self clickWorkTimeTableCell];
            break;
        case 1:
            [self clickRestTimeTableCell];
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


- (void)clickWorkTimeTableCell {
    NSArray *workTime = [NSArray arrayWithObjects:@"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", @"60", nil];
    NSUInteger initialSelection = [workTime indexOfObject: [NSString stringWithFormat:@"%ld", [UserDefaultsUtil.sharedUserDefaultsUtil maxWorkSeconds] / 60]];
    if (initialSelection == NSNotFound) {
        initialSelection = 0;
    }
    [ActionSheetStringPicker
     showPickerWithTitle:@"工作时间"
     rows:workTime
     initialSelection: initialSelection
     doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
         NSInteger workTime = [(NSString*)selectedValue integerValue] * 60;
         [UserDefaultsUtil.sharedUserDefaultsUtil setMaxWorkSeconds:workTime];
         self.workTimeLabel.text = [NSString stringWithFormat:@"%@ 分钟", (NSString*)selectedValue];
         [NSNotificationCenter.defaultCenter postNotificationName:@"resetTomatoTime" object:nil];
     }
     cancelBlock:^(ActionSheetStringPicker *picker) {}
     origin:self.view];
}


- (void)clickRestTimeTableCell {
    NSArray *restTime = [NSArray arrayWithObjects:@"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", @"60", nil];
    NSUInteger initialSelection = [restTime indexOfObject: [NSString stringWithFormat:@"%ld", [UserDefaultsUtil.sharedUserDefaultsUtil maxRestSeconds] / 60]];
    if (initialSelection == NSNotFound) {
        initialSelection = 0;
    }
    [ActionSheetStringPicker
     showPickerWithTitle:@"休息时间"
     rows:restTime
     initialSelection: initialSelection
     doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
         NSInteger restTime = [(NSString*)selectedValue integerValue] * 60;
         [UserDefaultsUtil.sharedUserDefaultsUtil setMaxRestSeconds:restTime];
         self.restTimeLabel.text = [NSString stringWithFormat:@"%@ 分钟", (NSString*)selectedValue];
         [NSNotificationCenter.defaultCenter postNotificationName:@"resetTomatoTime" object:nil];
     }
     cancelBlock:^(ActionSheetStringPicker *picker) {}
     origin:self.view];
}

@end
