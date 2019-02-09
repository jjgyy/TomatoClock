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

@property (class, nonatomic, readonly, strong) TimeTool *sharedTimeTool;

- (NSString*)normalizedCountdownString: (NSInteger) seconds;

@end

NS_ASSUME_NONNULL_END
