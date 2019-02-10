//
//  ClockNotificationTool.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/10.
//  Copyright © 2019 Young. All rights reserved.
//

#import "ClockNotificationTool.h"
#import "UserNotificationUtil.h"
#import "UserDefaultsUtil.h"

@implementation ClockNotificationTool

static ClockNotificationTool *_defaultClockNotificationTool;

+ (ClockNotificationTool *)defaultClockNotificationTool {
    if (!_defaultClockNotificationTool) {
        _defaultClockNotificationTool = [ClockNotificationTool new];
    }
    return _defaultClockNotificationTool;
}

- (void)addWorkOverNotificationWithInterval:(NSInteger)seconds {
    if (![UserDefaultsUtil.sharedUserDefaultsUtil isAllowingTomatoOverNotification]) { return; }
    [UserNotificationUtil.sharedUserNotificationUtil addNotificationWithInterval:seconds title:@"完成番茄时" identifier:@"workOver"];
}

- (void)removeWorkOverNotification {
    [UserNotificationUtil.sharedUserNotificationUtil removeNotificationWithIdentifier:@"workOver"];
}

- (void)addRestOverNotificationWithInterval:(NSInteger)seconds {
    if (![UserDefaultsUtil.sharedUserDefaultsUtil isAllowingTomatoOverNotification]) { return; }
    [UserNotificationUtil.sharedUserNotificationUtil addNotificationWithInterval:seconds title:@"休息时间结束" identifier:@"restOver"];
}

- (void)removeRestOverNotification {
    [UserNotificationUtil.sharedUserNotificationUtil removeNotificationWithIdentifier:@"restOver"];
}

@end
