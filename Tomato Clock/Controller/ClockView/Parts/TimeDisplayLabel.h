//
//  TimeDisplayLabel.h
//  Tomato Clock
//
//  Created by Apple on 2019/1/18.
//  Copyright © 2019 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeDisplayLabel : UILabel
{
    @private
    int _displayedSeconds;
}

@property int displayedSeconds;

@end

NS_ASSUME_NONNULL_END
