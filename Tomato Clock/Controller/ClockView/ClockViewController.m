//
//  ClockViewController.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "ClockViewController.h"
#import "TimeDisplayLabel.h"
#import "SettingTool.h"

@interface ClockViewController ()

typedef enum {
    IsReady,
    IsRunning,
    IsPaused,
    IsOver
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
    self.countdownState = IsReady;
    [self setMaxCountdownSecondsWithSetting];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setMaxCountdownSecondsWithSetting) name:@"resetMaxCountdown" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCountdownMaxSecondsWithNotification:) name:@"setCountdownMaxSeconds" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"setCountdownMaxSeconds" object:@{@"countdownMaxSeconds": [NSNumber numberWithInt:20*60]}];
}


- (void)setMaxCountdownSecondsWithSetting {
    self.maxCountdownSeconds = [SettingTool maxCountdownSeconds];
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


- (void)startCountdown {
    self.countdownState = IsRunning;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        if (self.leftCountdownSeconds <= 0) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self setLabelDisplayedSeconds: self.leftCountdownSeconds];
                self.countdownState = IsOver;
            });
            dispatch_source_cancel(self.timer);
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self setLabelDisplayedSeconds: self.leftCountdownSeconds];
            });
            self.leftCountdownSeconds --;
        }
    });
    dispatch_resume(self.timer);
}

- (void)pauseCountdown {
    self.countdownState = IsPaused;
    dispatch_source_cancel(self.timer);
}

- (void)endCountdown {
    self.countdownState = IsOver;
    dispatch_source_cancel(self.timer);
    self.leftCountdownSeconds = 0;
    [self setLabelDisplayedSeconds: 0];
}

- (void)resetCountdown {
    self.countdownState = IsReady;
    dispatch_source_cancel(self.timer);
    self.leftCountdownSeconds = self.maxCountdownSeconds;
    [self setLabelDisplayedSeconds: self.maxCountdownSeconds];
}


//- (void)setCountdownMaxSecondsWithNotification: (NSNotification *) notification {
//    NSDictionary *notificationDic = [notification object];
//    NSNumber *newCountdownMaxSeconds = [notificationDic valueForKey:@"countdownMaxSeconds"];
//    [self setCountdownMaxSeconds:[newCountdownMaxSeconds intValue]];
//}

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
