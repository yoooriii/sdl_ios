//
//  SDLLockScreenIconCache.h
//  SmartDeviceLink
//
//  Created by James Lapinski on 3/10/20.
//  Copyright © 2020 smartdevicelink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDLLockScreenIconCache : NSObject <NSSecureCoding>

@property (nonatomic) NSString *iconUrl;
@property (nonatomic) NSString *iconFilePath;
@property (nonatomic) NSDate *lastModifiedDate;

- (instancetype)initWithIconUrl:(NSString *)iconUrl iconFilePath:(NSString *)iconFilePath lastModifiedDate:(NSDate *)lastModifiedDate;

@end

NS_ASSUME_NONNULL_END
