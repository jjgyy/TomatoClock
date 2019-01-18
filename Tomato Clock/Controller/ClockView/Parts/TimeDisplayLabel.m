//
//  TimeDisplayLabel.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "TimeDisplayLabel.h"
#import "TimeTool.h"

@implementation TimeDisplayLabel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self->_displayedSeconds = 25 * 60;
    }
    return self;
}

- (void)setDisplayedSeconds:(int)seconds {
    _displayedSeconds = seconds;
    self.text = [TimeTool getNormalizedCountdownString: seconds];
}

- (int)displayedSeconds {
    return _displayedSeconds;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"TimeDisplayLabel countDown: %d", self.displayedSeconds];
}

@end
