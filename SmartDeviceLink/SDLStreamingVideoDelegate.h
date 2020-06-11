//
//  SDLStreamingVideoDelegate.h
//  SmartDeviceLink
//
//  Created on 6/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SDLStreamingVideoDelegate <NSObject>

- (void)videoStreamingSizeDidUpdate:(CGSize)displaySize;
- (void)videoStreamingSizeDoesNotMatch;

@end

NS_ASSUME_NONNULL_END
