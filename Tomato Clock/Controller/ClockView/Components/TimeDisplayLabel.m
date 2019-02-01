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

- (void)setDisplayedSeconds:(NSInteger)seconds {
    _displayedSeconds = seconds;
    self.text = [TimeTool normalizedCountdownString: seconds];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"TimeDisplayLabel countDown: %lu", self.displayedSeconds];
}

@end
