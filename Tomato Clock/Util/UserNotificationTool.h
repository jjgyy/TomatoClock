//
//  UserNotificationTool.h
//  Tomato Clock
//
//  Created by Apple on 2019/2/2.
//  Copyright © 2019 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserNotificationTool : NSObject

+(void) requestAuthorizationForFirstLaunch;

+(void) addCountdownOverNotificationWithInterval: (NSInteger)seconds;

+(void) removeCountdownOverNotification;

@end

NS_ASSUME_NONNULL_END
