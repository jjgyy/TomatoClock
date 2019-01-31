//
//  TimeTool.h
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeTool : NSObject

+ (NSInteger) getHoursFromSeconds: (NSInteger) seconds;

+ (NSInteger) getMinutesRemainderFromSeconds: (NSInteger) seconds;

+ (NSInteger) getSecondsRemainderFromSeconds: (NSInteger) seconds;

+ (NSString*) getNormalizedCountdownString: (NSInteger) seconds;

@end

NS_ASSUME_NONNULL_END
