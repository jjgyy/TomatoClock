//
//  ClockNotificationTool.h
//  Tomato Clock
//
//  Created by Apple on 2019/2/10.
//  Copyright © 2019 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClockNotificationTool : NSObject

@property (class, nonatomic, readonly, strong) ClockNotificationTool *defaultClockNotificationTool;

- (void)addWorkOverNotificationWithInterval:(NSInteger)seconds;

- (void)removeWorkOverNotification;

- (void)addRestOverNotificationWithInterval:(NSInteger)seconds;

- (void)removeRestOverNotification;

@end

NS_ASSUME_NONNULL_END
