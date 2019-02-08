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
    IsReady = 0,
    IsRunning = 1,
    IsPaused = 2,
    IsOver = 3
} CountdownState;
@property (nonatomic, assign) CountdownState countdownState;
@property (nonatomic, assign) NSInteger maxCountdownSeconds;
@property (nonatomic, assign) NSInteger leftCountdownSeconds;
@property (nonatomic, strong) dispatch_source_t timer;

@property (weak, nonatomic) IBOutlet TimeDisplayLabel *timeDisplayLabel;
- (IBAction)clickStart:(UIButton *)sender;
- (IBAction)clickPause:(UIButton *)sender;
- (IBAction)clickEnd:(UIButton *)sender;
- (IBAction)clickReset:(UIButton *)sender;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMaxCountdownSecondsWithUserDefaults];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidBecomeActive) name:@"applicationDidBecomeActive" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillResignActive) name:@"applicationWillResignActive" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setMaxCountdownSecondsWithUserDefaults) name:@"resetMaxCountdown" object:nil];
}


- (void)applicationDidBecomeActive {
    self.countdownState = (CountdownState)[UserDefaultsTool.sharedUserDefaultsTool countdownState];
    if (self.countdownState == IsRunning) {
        NSInteger leftCountdownSeconds = [UserDefaultsTool.sharedUserDefaultsTool leftCountdownSeconds];
        if (leftCountdownSeconds <= 0) {
            self.countdownState = IsOver;
            self.leftCountdownSeconds = 0;
            [self setLabelDisplayedSeconds: 0];
        } else {
            self.leftCountdownSeconds = leftCountdownSeconds;
            [self startCountdown];
        }
    }
}


- (void)applicationWillResignActive {
    [self cancelTimer];
}


- (void)setMaxCountdownSecondsWithUserDefaults {
    self.maxCountdownSeconds = [UserDefaultsTool.sharedUserDefaultsTool maxCountdownSeconds];
}

- (void)setMaxCountdownSeconds:(NSInteger)maxCountdownSeconds {
    self->_maxCountdownSeconds = maxCountdownSeconds;
    if (self.countdownState == IsReady) {
        self.leftCountdownSeconds = maxCountdownSeconds;
        [self setLabelDisplayedSeconds: maxCountdownSeconds];
    }
}

- (void)setLabelDisplayedSeconds:(NSInteger)seconds {
    self.timeDisplayLabel.displayedSeconds = seconds;
}


- (void)startTimer {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        self.leftCountdownSeconds --;
        if (self.leftCountdownSeconds <= 0) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self setLabelDisplayedSeconds: self.leftCountdownSeconds];
                self.countdownState = IsOver;
            });
            [self cancelTimer];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self setLabelDisplayedSeconds: self.leftCountdownSeconds];
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
    self.countdownState = IsRunning;
    [UserDefaultsTool.sharedUserDefaultsTool setCountdownState: self.countdownState];
    [UserDefaultsTool.sharedUserDefaultsTool setLeftCountdownSeconds: self.leftCountdownSeconds];
    [UserNotificationTool.sharedUserNotificationTool addCountdownOverNotificationWithInterval: self.leftCountdownSeconds];
    [self startTimer];
}


- (void)pauseCountdown {
    self.countdownState = IsPaused;
    [UserDefaultsTool.sharedUserDefaultsTool setCountdownState: IsPaused];
    [UserNotificationTool.sharedUserNotificationTool removeCountdownOverNotification];
    [self cancelTimer];
}


- (void)endCountdown {
    self.countdownState = IsOver;
    [UserDefaultsTool.sharedUserDefaultsTool setCountdownState: IsOver];
    [self cancelTimer];
    self.leftCountdownSeconds = 0;
    [self setLabelDisplayedSeconds: 0];
}


- (void)resetCountdown {
    self.countdownState = IsReady;
    [UserDefaultsTool.sharedUserDefaultsTool setCountdownState: IsReady];
    [self cancelTimer];
    self.leftCountdownSeconds = self.maxCountdownSeconds;
    [self setLabelDisplayedSeconds: self.maxCountdownSeconds];
}


- (IBAction)clickStart:(UIButton *)sender {
    [self startCountdown];
}

- (IBAction)clickPause:(UIButton *)sender {
    [self pauseCountdown];
}

- (IBAction)clickEnd:(UIButton *)sender {
    [self endCountdown];
}

- (IBAction)clickReset:(UIButton *)sender {
    [self resetCountdown];
}
@end
