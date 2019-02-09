//
//  UserDefaultsTool.h
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultsTool : NSObject

@property (class, nonatomic, readonly, strong) UserDefaultsTool *sharedUserDefaultsTool;

- (void)initUserDefaultsForFirstLaunch;

- (void)setMaxWorkSeconds: (NSInteger) maxWorkSeconds;

- (NSInteger)maxWorkSeconds;

- (void)setMaxRestSeconds: (NSInteger) maxRestSeconds;

- (NSInteger)maxRestSeconds;

- (void)setCountdownState: (NSInteger) countdownState;

- (NSInteger)countdownState;

- (void)setLeftCountdownSeconds: (NSInteger) leftCountdownSeconds;

- (NSInteger) leftCountdownSeconds;

- (void)setIsAutoTomato: (BOOL) isAutoTomato;

- (BOOL)isAutoTomato;

@end

NS_ASSUME_NONNULL_END
