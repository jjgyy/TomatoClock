//
//  ClockViewController.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "ClockViewController.h"
#import "TimeDisplayLabel.h"
#import "UserDefaultsTool.h"
#import "UserNotificationTool.h"

@interface ClockViewController ()

typedef enum {
    IsReadyWork = 0,
    IsWorking = 1,
    IsReadyRest = 2,
    IsResting = 3
} CountdownState;
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
    self.isAutoTomato = [UserDefaultsTool.sharedUserDefaultsTool isAutoTomato];
    self.maxWorkSeconds = [UserDefaultsTool.sharedUserDefaultsTool maxWorkSeconds];
    self.maxRestSeconds = [UserDefaultsTool.sharedUserDefaultsTool maxRestSeconds];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidBecomeActive) name:@"applicationDidBecomeActive" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillResignActive) name:@"applicationWillResignActive" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(resetIsAutoTomato) name:@"resetIsAutoTomato" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(resetTomatoTime) name:@"resetTomatoTime" object:nil];
}

- (void)applicationDidBecomeActive {
    self.countdownState = (CountdownState)[UserDefaultsTool.sharedUserDefaultsTool countdownState];
    if (self.countdownState == IsWorking || self.countdownState == IsResting) {
        NSInteger leftCountdownSeconds = [UserDefaultsTool.sharedUserDefaultsTool leftCountdownSeconds];
        if (leftCountdownSeconds <= 0) {
            if (self.countdownState == IsWorking) {
                self.countdownState = IsReadyRest;
                self.leftCountdownSeconds = self.maxRestSeconds;
            }
            if (self.countdownState == IsResting) {
                self.countdownState = IsReadyWork;
                self.leftCountdownSeconds = self.maxWorkSeconds;
            }
            [self setTimeDisplayWithSeconds: self.leftCountdownSeconds];
        } else {
            self.leftCountdownSeconds = leftCountdownSeconds;
            [self startCountdown];
        }
    }
    [self updateCountdownStateDisplay];
}

- (void)applicationWillResignActive {
    [self cancelTimer];
}

- (void)resetIsAutoTomato {
    self.isAutoTomato = [UserDefaultsTool.sharedUserDefaultsTool isAutoTomato];
}

- (void)resetTomatoTime {
    self.maxWorkSeconds = [UserDefaultsTool.sharedUserDefaultsTool maxWorkSeconds];
    self.maxRestSeconds = [UserDefaultsTool.sharedUserDefaultsTool maxRestSeconds];
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
    [UserDefaultsTool.sharedUserDefaultsTool setCountdownState: countdownState];
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


- (void)startWork {
    self.countdownState = IsWorking;
    [self updateCountdownStateDisplay];
    [UserNotificationTool.sharedUserNotificationTool addWorkOverNotificationWithInterval: self.leftCountdownSeconds];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
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
                    [self startRest];
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

- (void)startRest {
    self.countdownState = IsResting;
    [self updateCountdownStateDisplay];
    [UserNotificationTool.sharedUserNotificationTool addRestOverNotificationWithInterval: self.leftCountdownSeconds];
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
                    [self startWork];
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
        [self startWork];
    }
    if (self.countdownState == IsReadyRest) {
        [self startRest];
    }
}


- (void)endCountdown {
    [self cancelTimer];
    if (self.countdownState == IsWorking) {
        [UserNotificationTool.sharedUserNotificationTool removeWorkOverNotification];
    }
    if (self.countdownState == IsResting) {
        [UserNotificationTool.sharedUserNotificationTool removeRestOverNotification];
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
