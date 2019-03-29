//
//  ClockViewController.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "ClockViewController.h"
#import "TimeDisplayLabel.h"
#import "UserDefaultsUtil.h"
#import "ClockNotificationTool.h"

@interface ClockViewController ()

typedef NS_ENUM(NSInteger, CountdownState) {
    IsReadyWork = 0,
    IsWorking = 1,
    IsReadyRest = 2,
    IsResting = 3
};
@property (nonatomic, assign) CountdownState countdownState;
@property (nonatomic, assign) NSInteger maxWorkSeconds;
@property (nonatomic, assign) NSInteger maxRestSeconds;
@property (nonatomic, assign) NSInteger leftCountdownSeconds;
@property (nonatomic, assign) BOOL isAutoTomato;
@property (nonatomic, strong) dispatch_source_t timer;

@property (weak, nonatomic) IBOutlet TimeDisplayLabel *timeDisplayLabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownStateLabel;
- (IBAction)clickStart:(UIButton *)sender;
- (IBAction)clickReset:(UIButton *)sender;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isAutoTomato = [UserDefaultsUtil.sharedUserDefaultsUtil isAutoTomato];
    self.maxWorkSeconds = [UserDefaultsUtil.sharedUserDefaultsUtil maxWorkSeconds];
    self.maxRestSeconds = [UserDefaultsUtil.sharedUserDefaultsUtil maxRestSeconds];
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidBecomeActive) name:@"applicationDidBecomeActive" object:nil];
//    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillResignActive) name:@"applicationWillResignActive" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(resetIsAutoTomato) name:@"resetIsAutoTomato" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(resetTomatoTime) name:@"resetTomatoTime" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(resetIsAllowingTomatoOverNotification) name:@"resetIsAllowingTomatoOverNotification" object:nil];
}

//- (void)applicationDidBecomeActive {
//    self->_countdownState = (CountdownState)[UserDefaultsUtil.sharedUserDefaultsTool countdownState];
//    if (self.countdownState == IsWorking || self.countdownState == IsResting) {
//        NSInteger leftCountdownSeconds = [UserDefaultsUtil.sharedUserDefaultsTool leftCountdownSeconds];
//        if (leftCountdownSeconds <= 0) {
//            if (self.countdownState == IsWorking) {
//                self.countdownState = IsReadyRest;
//                self.leftCountdownSeconds = self.maxRestSeconds;
//            }
//            if (self.countdownState == IsResting) {
//                self.countdownState = IsReadyWork;
//                self.leftCountdownSeconds = self.maxWorkSeconds;
//            }
//            [self setTimeDisplayWithSeconds: self.leftCountdownSeconds];
//        } else {
//            self.leftCountdownSeconds = leftCountdownSeconds;
//            [self startCountdown];
//        }
//    }
//    [self updateCountdownStateDisplay];
//}

//- (void)applicationWillResignActive {
//    //[self cancelTimer];
//}
- (void)resetTomatoTime {
    self.maxWorkSeconds = [UserDefaultsUtil.sharedUserDefaultsUtil maxWorkSeconds];
    self.maxRestSeconds = [UserDefaultsUtil.sharedUserDefaultsUtil maxRestSeconds];
}

- (void)resetIsAutoTomato {
    self.isAutoTomato = [UserDefaultsUtil.sharedUserDefaultsUtil isAutoTomato];
}

- (void)resetIsAllowingTomatoOverNotification {
    BOOL isAllowingTomatoOverNotification = [UserDefaultsUtil.sharedUserDefaultsUtil isAllowingTomatoOverNotification];
    if (isAllowingTomatoOverNotification) {
        if (self.countdownState == IsWorking) {
            [ClockNotificationTool.defaultClockNotificationTool addWorkOverNotificationWithInterval: self.leftCountdownSeconds];
        }
        if (self.countdownState == IsResting) {
            [ClockNotificationTool.defaultClockNotificationTool addRestOverNotificationWithInterval: self.leftCountdownSeconds];
        }
    } else {
        if (self.countdownState == IsWorking) {
            [ClockNotificationTool.defaultClockNotificationTool removeWorkOverNotification];
        }
        if (self.countdownState == IsResting) {
            [ClockNotificationTool.defaultClockNotificationTool removeRestOverNotification];
        }
    }
}



- (void)setMaxWorkSeconds:(NSInteger)maxWorkSeconds {
    self->_maxWorkSeconds = maxWorkSeconds;
    if (self->_countdownState == IsReadyWork) {
        self->_leftCountdownSeconds = maxWorkSeconds;
        [self setTimeDisplayWithSeconds: maxWorkSeconds];
    }
}

- (void)setMaxRestSeconds:(NSInteger)maxRestSeconds {
    self->_maxRestSeconds = maxRestSeconds;
    if (self->_countdownState == IsReadyRest) {
        self->_leftCountdownSeconds = maxRestSeconds;
        [self setTimeDisplayWithSeconds: maxRestSeconds];
    }
}

- (void)setCountdownState:(CountdownState)countdownState {
    self->_countdownState = countdownState;
    [UserDefaultsUtil.sharedUserDefaultsUtil setCountdownState: countdownState];
}

- (void)setTimeDisplayWithSeconds:(NSInteger)seconds {
    self.timeDisplayLabel.displayedSeconds = seconds;
}

- (void)updateCountdownStateDisplay {
    switch (self.countdownState) {
        case IsReadyWork:
            self.countdownStateLabel.text = @"等待工作";
            break;
        case IsWorking:
            self.countdownStateLabel.text = @"正在工作";
            break;
        case IsReadyRest:
            self.countdownStateLabel.text = @"等待休息";
            break;
        case IsResting:
            self.countdownStateLabel.text = @"正在休息";
            break;
        default:
            NSLog(@"错误的countdownState");
            break;
    }
}


- (void)startWorkWithNotification {
    self.countdownState = IsWorking;
    [self updateCountdownStateDisplay];
    [ClockNotificationTool.defaultClockNotificationTool addWorkOverNotificationWithInterval: self.leftCountdownSeconds];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self cancelTimer];
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        self.leftCountdownSeconds --;
        if (self.leftCountdownSeconds < 0) {
            self.countdownState = IsReadyRest;
            self.leftCountdownSeconds = self.maxRestSeconds;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self setTimeDisplayWithSeconds: self.maxRestSeconds];
                [self updateCountdownStateDisplay];
                [self cancelTimer];
                if (self.isAutoTomato) {
                    [self startRestWithNotification];
                }
            });
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self setTimeDisplayWithSeconds: self.leftCountdownSeconds];
            });
        }
    });
    dispatch_resume(self.timer);
}

- (void)startRestWithNotification {
    self.countdownState = IsResting;
    [self updateCountdownStateDisplay];
    [ClockNotificationTool.defaultClockNotificationTool addRestOverNotificationWithInterval: self.leftCountdownSeconds];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        self.leftCountdownSeconds --;
        if (self.leftCountdownSeconds < 0) {
            self.countdownState = IsReadyWork;
            self.leftCountdownSeconds = self.maxWorkSeconds;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self setTimeDisplayWithSeconds: self.maxWorkSeconds];
                [self updateCountdownStateDisplay];
                [self cancelTimer];
                if (self.isAutoTomato) {
                    [self startWorkWithNotification];
                }
            });
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self setTimeDisplayWithSeconds: self.leftCountdownSeconds];
            });
        }
    });
    dispatch_resume(self.timer);
}

- (void)cancelTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}


- (void)startCountdown {
    if (self.leftCountdownSeconds <= 0) { return; }
    if (self.countdownState == IsReadyWork) {
        [self startWorkWithNotification];
    }
    if (self.countdownState == IsReadyRest) {
        [self startRestWithNotification];
    }
}


- (void)endCountdown {
    [self cancelTimer];
    if (self.countdownState == IsWorking) {
        [ClockNotificationTool.defaultClockNotificationTool removeWorkOverNotification];
    }
    if (self.countdownState == IsResting) {
        [ClockNotificationTool.defaultClockNotificationTool removeRestOverNotification];
    }
    self.countdownState = IsReadyWork;
    self.leftCountdownSeconds = self.maxWorkSeconds;
    [self setTimeDisplayWithSeconds: self.maxWorkSeconds];
}


- (IBAction)clickStart:(UIButton *)sender {
    [self startCountdown];
}

- (IBAction)clickReset:(UIButton *)sender {
    [self endCountdown];
}
@end
