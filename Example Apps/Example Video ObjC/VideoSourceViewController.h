//
//  VideoSourceViewController.h
//  SmartDeviceLink-iOS
//
//  Copyright © 2018 Luxoft. All rights reserved
//

#import <UIKit/UIKit.h>
#import "SDLStreamingMediaDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoSourceViewController<SDLStreamingMediaDelegate> : UIViewController

+ (instancetype)createInstance;

@end

NS_ASSUME_NONNULL_END
