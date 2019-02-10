//
//  TimeUtil.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil

static TimeUtil *_sharedTimeTool;

+ (TimeUtil *)sharedTimeUtil {
    if (!_sharedTimeTool) {
        _sharedTimeTool = [TimeUtil new];
    }
    return _sharedTimeTool;
}

- (NSString *)normalizedCountdownString:(NSInteger)seconds {
    NSInteger minutes = seconds / 60;
    NSInteger secondsRemainder = seconds % 60;
    NSString *result = @"";
    
    if (minutes >= 10) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%ld", minutes]];
    } else if (minutes > 0) {
        result = [NSString stringWithFormat:@"%ld", minutes];
    }
    
    if (secondsRemainder < 10) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@":0%ld", secondsRemainder]];
    } else {
        result = [result stringByAppendingString:[NSString stringWithFormat:@":%ld", secondsRemainder]];
    }
    return result;
}

@end
