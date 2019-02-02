//
//  UserNotificationTool.m
//  Tomato Clock
//
//  Created by Apple on 2019/2/2.
//  Copyright © 2019 Young. All rights reserved.
//

#import "UserNotificationTool.h"
#import <UserNotifications/UserNotifications.h>

@implementation UserNotificationTool

+(void) requestAuthorizationForFirstLaunch {
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    [center requestAuthorizationWithOptions: (UNAuthorizationOptionAlert | UNAuthorizationOptionSound) completionHandler: ^(BOOL granted, NSError * _Nullable __strong error){
        // TODO: add something
    }];
}

@end
