//
//  UserNotificationUtil.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/2.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UserNotificationUtil.h"

@implementation UserNotificationUtil

static UserNotificationUtil *_sharedUserNotificationTool;


+ (UserNotificationUtil *)sharedUserNotificationUtil {
    if (!_sharedUserNotificationTool) {
        _sharedUserNotificationTool = [UserNotificationUtil new];
    }
    return _sharedUserNotificationTool;
}


- (void)requestAuthorizationForFirstLaunch {
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    center.delegate = self;
    [center requestAuthorizationWithOptions: (UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge) completionHandler: ^(BOOL granted, NSError * _Nullable __strong error){
        // TODO: add something
    }];
}


- (void)addNotificationWithInterval:(NSInteger)seconds  title:(NSString *)title  identifier:(NSString *)identifier {
    if (seconds <= 0) { return; }
    UNMutableNotificationContent* content = [UNMutableNotificationContent new];
    content.title = [NSString localizedUserNotificationStringForKey: title arguments: nil];
    //content.body = [NSString localizedUserNotificationStringForKey:@"点击查看" arguments:nil];
    //content.badge = [NSNumber numberWithInteger: 1];
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:seconds repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier: identifier content:content trigger:trigger];
    
    [UNUserNotificationCenter.currentNotificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    }];
}


- (void)removeNotificationWithIdentifier:(NSString *)identifier {
    NSArray<NSString*> *identifiers = [[NSArray alloc] initWithObjects: identifier, nil];
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
