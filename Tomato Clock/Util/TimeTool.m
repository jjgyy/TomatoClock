//
//  TimeTool.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

+ (NSInteger)getHoursFromSeconds:(NSInteger)seconds {
    return seconds / 3600;
}

+ (NSInteger)getMinutesRemainderFromSeconds:(NSInteger)seconds {
    return (seconds % 3600) / 60;
}

+ (NSInteger)getSecondsRemainderFromSeconds:(NSInteger)seconds {
    return (seconds % 3600) % 60;
}

+ (NSString *)getNormalizedCountdownString:(NSInteger)seconds {
    NSInteger hours = [self getHoursFromSeconds:seconds];
    NSInteger minutesRemainder = [self getMinutesRemainderFromSeconds:seconds];
    NSInteger secondsRemainder = [self getSecondsRemainderFromSeconds:seconds];
    NSString *result = @"";
    
    if (hours > 0) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%lu:", hours]];
    }
    
    if (minutesRemainder >= 10) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%lu", minutesRemainder]];
    } else if (minutesRemainder > 0 && hours > 0) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"0%lu", minutesRemainder]];
    } else if (minutesRemainder > 0 && hours == 0) {
        result = [NSString stringWithFormat:@"%lu", minutesRemainder];
    }
    
    if (secondsRemainder < 10) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@":0%lu", secondsRemainder]];
    } else {
        result = [result stringByAppendingString:[NSString stringWithFormat:@":%lu", secondsRemainder]];
    }
    return result;
}

@end
