//
//  ClockViewController.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "ClockViewController.h"
#import "TimeDisplayLabel.h"

@interface ClockViewController ()

@property (weak, nonatomic) IBOutlet TimeDisplayLabel *timeDisplayLabel;
@property Boolean isRunning;
@property int countdownMaxSeconds;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isRunning = false;
    
    int settingCountdownMaxSeconds = 20 * 60;
    self.countdownMaxSeconds = settingCountdownMaxSeconds;
    [self setLabelDisplayedSeconds: settingCountdownMaxSeconds];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCountdownMaxSecondsWithNotification:) name:@"setCountdownMaxSeconds" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"setCountdownMaxSeconds" object:@{@"countdownMaxSeconds": [NSNumber numberWithInt:20*60]}];
}


- (void)setLabelDisplayedSeconds: (int) seconds {
    self.timeDisplayLabel.displayedSeconds = seconds;
}


- (void)startCountdown {
    
}


//- (void)setCountdownMaxSecondsWithNotification: (NSNotification *) notification {
//    NSDictionary *notificationDic = [notification object];
//    NSNumber *newCountdownMaxSeconds = [notificationDic valueForKey:@"countdownMaxSeconds"];
//    [self setCountdownMaxSeconds:[newCountdownMaxSeconds intValue]];
//}

@end
