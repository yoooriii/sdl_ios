//
//  SDLSupportedStreamingRange.m
//  SmartDeviceLink
//
//  Created on 6/11/20.
//

#import "SDLSupportedStreamingRange.h"
#import "SDLImageResolution.h"

@implementation SDLSupportedStreamingRange

- (instancetype)initWithResolutionsMinimum:(SDLImageResolution*)minResolution maximun:(SDLImageResolution*)maxResolution {
    if ((self = [super init])) {
        _minimumResolution = minResolution;
        _maximumResolution = maxResolution;
    }
    return self;
}

+ (instancetype)defaultPortraitRange {
    //TODO: decide what default values are
    SDLImageResolution *minResolution = [[SDLImageResolution alloc] initWithWidth:240 height:320];
    SDLImageResolution *maxResolution = [[SDLImageResolution alloc] initWithWidth:600 height:800];
    return [[self alloc] initWithResolutionsMinimum:minResolution maximun:maxResolution];
}

+ (instancetype)defaultLandscapeRange {
    SDLImageResolution *minResolution = [[SDLImageResolution alloc] initWithWidth:320 height:240];
    SDLImageResolution *maxResolution = [[SDLImageResolution alloc] initWithWidth:800 height:600];
    return [[self alloc] initWithResolutionsMinimum:minResolution maximun:maxResolution];
}

- (instancetype)copy {
    return [[self.class alloc] initWithResolutionsMinimum:self.minimumResolution maximun:self.maximumResolution];
}

- (BOOL)isInRange:(SDLImageResolution*)imageResolution {
    if (!imageResolution || !self.minimumResolution || !self.maximumResolution) {
        return NO;
    }

    const CGSize minSize = self.minimumResolution.makeSize;
    const CGSize maxSize = self.maximumResolution.makeSize;
    const CGSize size = imageResolution.makeSize;
    return (size.width >= minSize.width) && (size.width <= maxSize.width) &&
            (size.height >= minSize.height) && (size.height <= maxSize.height);
}

@end
