//
//  SDLSupportedStreamingRange.h
//  SmartDeviceLink
//
//  Created on 6/11/20.
//

#import <Foundation/Foundation.h>

@class SDLImageResolution;

NS_ASSUME_NONNULL_BEGIN

@interface SDLSupportedStreamingRange : NSObject

// The minimum resolution to support
@property (nonatomic, strong, nullable) SDLImageResolution *minimumResolution;

// The maximum resolution to support
@property (nonatomic, strong, nullable) SDLImageResolution *maximumResolution;

- (BOOL)isInRange:(SDLImageResolution*)imageResolution;

+ (instancetype)defaultPortraitRange;

+ (instancetype)defaultLandscapeRange;

- (instancetype)initWithResolutionsMinimum:(SDLImageResolution*)minResolution maximun:(SDLImageResolution*)maxResolution;

@end

NS_ASSUME_NONNULL_END
