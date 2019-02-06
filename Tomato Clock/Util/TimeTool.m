//
//  TimeTool.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

static TimeTool *_sharedTimeTool;

+ (TimeTool *)sharedTimeTool {
    if (!_sharedTimeTool) {
        _sharedTimeTool = [TimeTool new];
    }
    return _sharedTimeTool;
}

- (NSInteger)hoursFromSeconds:(NSInteger)seconds {
    return seconds / 3600;
}

- (NSInteger)minutesRemainderFromSeconds:(NSInteger)seconds {
    return (seconds % 3600) / 60;
}

- (NSInteger)secondsRemainderFromSeconds:(NSInteger)seconds {
    return (seconds % 3600) % 60;
}

- (NSString *)normalizedCountdownString:(NSInteger)seconds {
    NSInteger hours = [self hoursFromSeconds:seconds];
    NSInteger minutesRemainder = [self minutesRemainderFromSeconds:seconds];
    NSInteger secondsRemainder = [self secondsRemainderFromSeconds:seconds];
    NSString *result = @"";
    
    if (hours > 0) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%ld:", hours]];
    }
    
    if (minutesRemainder >= 10) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%ld", minutesRemainder]];
    } else if (minutesRemainder > 0 && hours > 0) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@"0%ld", minutesRemainder]];
    } else if (minutesRemainder > 0 && hours == 0) {
        result = [NSString stringWithFormat:@"%ld", minutesRemainder];
    }
    
    if (secondsRemainder < 10) {
        result = [result stringByAppendingString:[NSString stringWithFormat:@":0%ld", secondsRemainder]];
    } else {
        result = [result stringByAppendingString:[NSString stringWithFormat:@":%ld", secondsRemainder]];
    }
    return result;
}

@end
