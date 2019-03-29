//
//  AppDelegate.m
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AppDelegate.h"
#import "UserDefaultsUtil.h"
#import "UserNotificationUtil.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
@property (nonatomic) dispatch_source_t badgeTimer;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UserDefaultsUtil.sharedUserDefaultsUtil initUserDefaultsForFirstLaunch];
    [UserNotificationUtil.sharedUserNotificationUtil requestAuthorizationForFirstLaunch];
    [self player];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [NSNotificationCenter.defaultCenter postNotificationName:@"applicationWillResignActive" object:nil];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //[self stratBadgeNumberCount];
    [self startBgTask];
    /** 播放声音 */
    [self.player play];
}

- (AVAudioPlayer *)player{
    if (!_player){
        NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"mute" ofType:@"mp3"];
        NSURL *URLPath = [[NSURL alloc] initFileURLWithPath:musicPath];
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL: URLPath error:nil];
        [_player prepareToPlay];
        //一直循环播放
        _player.numberOfLoops = -1;
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [session setActive:YES error:nil];
    }
    return _player;
}


- (void)startBgTask{
    UIApplication *application = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        //这里延迟的系统时间结束
        [application endBackgroundTask: bgTask];
        NSLog(@"%f",application.backgroundTimeRemaining);
    }];
    
}

- (void)stratBadgeNumberCount{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    _badgeTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_badgeTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_badgeTimer, ^{
        
        [UIApplication sharedApplication].applicationIconBadgeNumber++;
        //        appleLocationManager = [[CLLocationManager alloc] init];
        //        appleLocationManager.allowsBackgroundLocationUpdates = YES;
        //        appleLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //        appleLocationManager.delegate = self;
        //        [appleLocationManager requestAlwaysAuthorization];
        //        [appleLocationManager startUpdatingLocation];
        
    });
    dispatch_resume(_badgeTimer);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [NSNotificationCenter.defaultCenter postNotificationName:@"applicationDidBecomeActive" object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
