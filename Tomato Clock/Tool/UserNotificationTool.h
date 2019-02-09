//
//  UserNotificationTool.h
//  Tomato Clock
//
//  Created by Apple on 2019/2/2.
//  Copyright © 2019 Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserNotificationTool : NSObject<UNUserNotificationCenterDelegate>

@property (class, nonatomic, readonly, strong) UserNotificationTool *sharedUserNotificationTool;

- (void)requestAuthorizationForFirstLaunch;

- (void)addWorkOverNotificationWithInterval: (NSInteger)seconds;

- (void)removeWorkOverNotification;

- (void)addRestOverNotificationWithInterval: (NSInteger)seconds;

- (void)removeRestOverNotification;

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler;

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
