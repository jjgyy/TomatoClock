//
//  UserDefaultsTool.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UserDefaultsTool.h"

@implementation UserDefaultsTool


+(void)initUserDefaultsForFirstLaunch {
    Boolean hasFirstLaunched = [NSUserDefaults.standardUserDefaults boolForKey: @"hasFirstLaunched"];
    if (!hasFirstLaunched) {
        [NSUserDefaults.standardUserDefaults setBool: true forKey: @"hasFirstLaunched"];
        [NSUserDefaults.standardUserDefaults setInteger: 25 * 60 forKey: @"maxCountdownSeconds"];
    }
}


+(void)setMaxCountdownSeconds: (NSInteger) maxCountdownSeconds {
    if (maxCountdownSeconds <= 0) {
        NSLog(@"maxCountdownSeconds = %ld, should be positive.", maxCountdownSeconds);
        return;
    }
    [NSUserDefaults.standardUserDefaults setInteger: maxCountdownSeconds forKey: @"maxCountdownSeconds"];
}


+(NSInteger)maxCountdownSeconds {
    return [NSUserDefaults.standardUserDefaults integerForKey: @"maxCountdownSeconds"];
}

@end
