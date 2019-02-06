//
//  UserNotificationTool.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/2.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UserNotificationTool.h"

@implementation UserNotificationTool

static UserNotificationTool *_sharedUserNotificationTool;


+ (UserNotificationTool *)sharedUserNotificationTool {
    if (!_sharedUserNotificationTool) {
        _sharedUserNotificationTool = [UserNotificationTool new];
    }
    return _sharedUserNotificationTool;
}


- (void)requestAuthorizationForFirstLaunch {
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    center.delegate = (UserNotificationTool *)self;
    [center requestAuthorizationWithOptions: (UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge) completionHandler: ^(BOOL granted, NSError * _Nullable __strong error){
        // TODO: add something
    }];
}


- (void)addCountdownOverNotificationWithInterval: (NSInteger)seconds {
    UNMutableNotificationContent* content = [UNMutableNotificationContent new];
    content.title = [NSString localizedUserNotificationStringForKey:@"完成番茄时" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"点击查看" arguments:nil];
    //content.badge = [NSNumber numberWithInteger: 1];
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:seconds repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"countdownOver" content:content trigger:trigger];
    
    [UNUserNotificationCenter.currentNotificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    }];
}


- (void)removeCountdownOverNotification {
    NSArray<NSString*> *identifiers = [[NSArray alloc] initWithObjects:@"countdownOver", nil];
    [UNUserNotificationCenter.currentNotificationCenter removePendingNotificationRequestsWithIdentifiers: identifiers];
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert + UNNotificationPresentationOptionSound + UNNotificationPresentationOptionBadge);
    NSLog(@"TODO : willPresentNotification");
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    completionHandler();
    NSLog(@"TODO : didReceiveNotificationResponse");
}


@end
