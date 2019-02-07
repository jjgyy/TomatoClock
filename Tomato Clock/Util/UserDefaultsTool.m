//
//  UserDefaultsTool.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UserDefaultsTool.h"

@implementation UserDefaultsTool

static UserDefaultsTool *_sharedUserDefaultsTool;

+ (UserDefaultsTool *)sharedUserDefaultsTool {
    if (!_sharedUserDefaultsTool) {
        _sharedUserDefaultsTool = [UserDefaultsTool new];
    }
    return _sharedUserDefaultsTool;
}


- (void)initUserDefaultsForFirstLaunch {
    BOOL hasFirstLaunched = [NSUserDefaults.standardUserDefaults boolForKey: @"hasFirstLaunched"];
    if (!hasFirstLaunched) {
        [NSUserDefaults.standardUserDefaults setBool: YES forKey: @"hasFirstLaunched"];
        [NSUserDefaults.standardUserDefaults setInteger: 25 * 60 forKey: @"maxCountdownSeconds"];
    }
}



- (void)setMaxCountdownSeconds: (NSInteger) maxCountdownSeconds {
    if (maxCountdownSeconds <= 0) {
        NSLog(@"maxCountdownSeconds = %ld, should be positive.", maxCountdownSeconds);
        return;
    }
    [NSUserDefaults.standardUserDefaults setInteger: maxCountdownSeconds forKey: @"maxCountdownSeconds"];
}

- (NSInteger)maxCountdownSeconds {
    return [NSUserDefaults.standardUserDefaults integerForKey: @"maxCountdownSeconds"];
}



- (void)setCountdownState: (NSInteger) countdownState {
    [NSUserDefaults.standardUserDefaults setInteger: countdownState forKey: @"countdownState"];
}

- (NSInteger)countdownState {
    return [NSUserDefaults.standardUserDefaults integerForKey: @"countdownState"];
}



- (void)setCountdownOverDate: (NSDate *) countdownOverDate {
    NSTimeInterval timeInterval = [countdownOverDate timeIntervalSince1970];
    [NSUserDefaults.standardUserDefaults setDouble: timeInterval forKey: @"countdownOverDate"];
}

- (NSDate *)countdownOverDate {
    NSTimeInterval timeInterval = [NSUserDefaults.standardUserDefaults doubleForKey: @"countdownOverDate"];
    return [NSDate dateWithTimeIntervalSince1970: timeInterval];
}

@end
