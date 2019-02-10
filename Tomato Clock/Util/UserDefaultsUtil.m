//
//  UserDefaultsUtil.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UserDefaultsUtil.h"

@implementation UserDefaultsUtil

static UserDefaultsUtil *_sharedUserDefaultsTool;

+ (UserDefaultsUtil *)sharedUserDefaultsUtil {
    if (!_sharedUserDefaultsTool) {
        _sharedUserDefaultsTool = [UserDefaultsUtil new];
    }
    return _sharedUserDefaultsTool;
}


- (void)initUserDefaultsForFirstLaunch {
//    BOOL hasFirstLaunched = [NSUserDefaults.standardUserDefaults boolForKey: @"hasFirstLaunched"];
//    if (!hasFirstLaunched) {
//        [NSUserDefaults.standardUserDefaults setBool: YES forKey: @"hasFirstLaunched"];
//        [NSUserDefaults.standardUserDefaults setInteger: 25 * 60 forKey: @"maxWorkSeconds"];
//        [NSUserDefaults.standardUserDefaults setInteger: 5 * 60 forKey: @"maxRestSeconds"];
//    }
    if (![self maxWorkSeconds]) {
        [self setMaxWorkSeconds: 25*60];
    }
    if (![self maxRestSeconds]) {
        [self setMaxRestSeconds: 5*60];
    }
}



- (void)setMaxWorkSeconds: (NSInteger) maxWorkSeconds {
    if (maxWorkSeconds <= 0) {
        NSLog(@"maxWorkSeconds = %ld, should be positive.", maxWorkSeconds);
        return;
    }
    [NSUserDefaults.standardUserDefaults setInteger: maxWorkSeconds forKey: @"maxWorkSeconds"];
}

- (NSInteger)maxWorkSeconds {
    return [NSUserDefaults.standardUserDefaults integerForKey: @"maxWorkSeconds"];
}



- (void)setMaxRestSeconds: (NSInteger) maxRestSeconds {
    if (maxRestSeconds <= 0) {
        NSLog(@"maxRestSeconds = %ld, should be positive.", maxRestSeconds);
        return;
    }
    [NSUserDefaults.standardUserDefaults setInteger: maxRestSeconds forKey: @"maxRestSeconds"];
}

- (NSInteger)maxRestSeconds {
    return [NSUserDefaults.standardUserDefaults integerForKey: @"maxRestSeconds"];
}



- (void)setCountdownState: (NSInteger) countdownState {
    [NSUserDefaults.standardUserDefaults setInteger: countdownState forKey: @"countdownState"];
}

- (NSInteger)countdownState {
    return [NSUserDefaults.standardUserDefaults integerForKey: @"countdownState"];
}



- (void)setLeftCountdownSeconds: (NSInteger) leftCountdownSeconds {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: leftCountdownSeconds];
    NSInteger timeIntervalSince1970 = [date timeIntervalSince1970];
    [NSUserDefaults.standardUserDefaults setInteger: timeIntervalSince1970 forKey: @"leftCountdownSeconds"];
}

- (NSInteger) leftCountdownSeconds {
    NSInteger timeIntervalSince1970 = [NSUserDefaults.standardUserDefaults integerForKey: @"leftCountdownSeconds"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeIntervalSince1970];
    return [date timeIntervalSinceNow];
}

- (void)setIsAutoTomato: (BOOL) isAutoTomato {
    [NSUserDefaults.standardUserDefaults setBool: isAutoTomato forKey: @"isAutoTomato"];
}

- (BOOL)isAutoTomato {
    return [NSUserDefaults.standardUserDefaults boolForKey: @"isAutoTomato"];
}

- (void)setIsAllowingTomatoOverNotification: (BOOL) isAllowingTomatoOverNotification {
    [NSUserDefaults.standardUserDefaults setBool: isAllowingTomatoOverNotification forKey: @"isAllowingTomatoOverNotification"];
}

- (BOOL)isAllowingTomatoOverNotification {
    return [NSUserDefaults.standardUserDefaults boolForKey: @"isAllowingTomatoOverNotification"];
}


@end
