//
//  SettingTool.h
//  Tomato Clock
//
//  Created by Apple on 2019/2/1.
//  Copyright © 2019 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingTool : NSObject

+(void) initSettingForFirstLaunch;

+(void) setMaxCountdownSeconds: (NSInteger) maxCountdownSeconds;

+(NSInteger) maxCountdownSeconds;

@end

NS_ASSUME_NONNULL_END
