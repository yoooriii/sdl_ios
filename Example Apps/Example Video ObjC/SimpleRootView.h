//
//  SimpleRootView.h
//  SmartDeviceLink-Example-ObjC
//
//  Copyright © 2018 Luxoft. All rights reserved
//

#import <UIKit/UIKit.h>
#import "TouchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimpleRootView : UIView
@property (strong, nonatomic, nullable) TouchModel *singleTap;
@property (strong, nonatomic, nullable) TouchModel *doubleTap;
@end

NS_ASSUME_NONNULL_END
