//
//  TimeTool.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

+ (int)getHoursFromSeconds:(int)seconds {
    return seconds / 3600;
}

+ (int)getMinutesRemainderFromSeconds:(int)seconds {
    return (seconds % 3600) / 60;
}

+ (int)getSecondsRemainderFromSeconds:(int)seconds {
    return (seconds % 3600) % 60;
}

+ (NSString *)getNormalizedCountdownString:(int)seconds {
    int hours = [self getHoursFromSeconds:seconds];
    int minutesRemainder = [self getMinutesRemainderFromSeconds:seconds];
    int secondsRemainder = [self getSecondsRemainderFromSeconds:seconds];
    NSString *result = @"";
    
    if (hours > 0) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%d:", hours]];
    }
    
    if (minutesRemainder >= 10) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%d", minutesRemainder]];
    } else if (minutesRemainder > 0 && hours > 0) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"0%d", minutesRemainder]];
    } else if (minutesRemainder > 0 && hours == 0) {
        result = [NSString stringWithFormat:@"%d", minutesRemainder];
    }
    
    if (secondsRemainder < 10) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@":0%d", secondsRemainder]];
    } else {
        result = [result stringByAppendingString:[NSString stringWithFormat:@":%d", secondsRemainder]];
    }
    return result;
}

@end
