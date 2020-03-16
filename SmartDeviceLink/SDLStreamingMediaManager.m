//
//  SDLStreamingDataManager.m
//  SmartDeviceLink-iOS
//
//  Created by Joel Fischer on 8/11/15.
//  Copyright (c) 2015 smartdevicelink. All rights reserved.
//

#import "SDLStreamingMediaManager.h"

#import "SDLAudioStreamManager.h"
#import "SDLConfiguration.h"
#import "SDLConnectionManagerType.h"
#import "SDLStreamingAudioLifecycleManager.h"
#import "SDLStreamingVideoLifecycleManager.h"
#import "SDLStreamingVideoScaleManager.h"
#import "SDLTouchManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface SDLStreamingMediaManager ()

@property (strong, nonatomic) SDLStreamingAudioLifecycleManager *audioLifecycleManager;
@property (strong, nonatomic) SDLStreamingVideoLifecycleManager *videoLifecycleManager;
@property (assign, nonatomic) BOOL audioStarted;
@property (assign, nonatomic) BOOL videoStarted;

@end


@implementation SDLStreamingMediaManager

#pragma mark - Public
#pragma mark Lifecycle

- (instancetype)initWithConnectionManager:(id<SDLConnectionManagerType>)connectionManager configuration:(SDLConfiguration *)configuration systemCapabilityManager:(nullable SDLSystemCapabilityManager *)systemCapabilityManager {
    self = [super init];
    if (!self) {
        return nil;
    }

    _audioLifecycleManager = [[SDLStreamingAudioLifecycleManager alloc] initWithConnectionManager:connectionManager configuration:configuration systemCapabilityManager:systemCapabilityManager];
    _videoLifecycleManager = [[SDLStreamingVideoLifecycleManager alloc] initWithConnectionManager:connectionManager configuration:configuration systemCapabilityManager:systemCapabilityManager];

    return self;
}

- (instancetype)initWithConnectionManager:(id<SDLConnectionManagerType>)connectionManager configuration:(SDLConfiguration *)configuration {
    return [self initWithConnectionManager:connectionManager configuration:configuration systemCapabilityManager:nil];
}

- (void)dealloc {
    [_audioLifecycleManager stop];
    [_videoLifecycleManager stop];
}

- (void)startWithProtocol:(SDLProtocol *)protocol {
    [self startAudioWithProtocol:protocol];
    [self startVideoWithProtocol:protocol];
}

- (void)startAudioWithProtocol:(SDLProtocol *)protocol {
    [self.audioLifecycleManager startWithProtocol:protocol];
    self.audioStarted = YES;
}

- (void)startVideoWithProtocol:(SDLProtocol *)protocol {
    [self.videoLifecycleManager startWithProtocol:protocol];
    self.videoStarted = YES;
}

- (void)stop {
    [self stopAudio];
    [self stopVideo];
}

- (void)stopAudio {
    [self.audioLifecycleManager stop];
    self.audioStarted = NO;
}

- (void)stopVideo {
    [self.videoLifecycleManager stop];
    self.videoStarted = NO;
}

- (BOOL)sendVideoData:(CVImageBufferRef)imageBuffer {
    return [self.videoLifecycleManager sendVideoData:imageBuffer];
}

- (BOOL)sendVideoData:(CVImageBufferRef)imageBuffer presentationTimestamp:(CMTime)presentationTimestamp {
    return [self.videoLifecycleManager sendVideoData:imageBuffer presentationTimestamp:presentationTimestamp];
}

- (BOOL)sendAudioData:(NSData*)audioData {
    return [self.audioLifecycleManager sendAudioData:audioData];
}


#pragma mark - Getters

- (SDLTouchManager *)touchManager {
    return self.videoLifecycleManager.touchManager;
}

- (SDLAudioStreamManager *)audioManager {
    return self.audioLifecycleManager.audioManager;
}

- (nullable UIViewController *)rootViewController {
    return self.videoLifecycleManager.rootViewController;
}

- (nullable id<SDLFocusableItemLocatorType>)focusableItemManager {
    return self.videoLifecycleManager.focusableItemManager;
}

- (BOOL)isStreamingSupported {
    // The flag is the same between the video and audio managers so just one needs to be returned.
    return self.videoLifecycleManager.isStreamingSupported;
}

- (BOOL)isAudioConnected {
    return self.audioLifecycleManager.isAudioConnected;
}

- (BOOL)isVideoConnected {
    return self.videoLifecycleManager.isVideoConnected;
}

- (BOOL)isAudioEncrypted {
    return self.audioLifecycleManager.isAudioEncrypted;
}

- (BOOL)isVideoEncrypted {
    return self.videoLifecycleManager.isVideoEncrypted;
}
    
- (BOOL)isVideoStreamingPaused {
    return self.videoLifecycleManager.isVideoStreamingPaused;
}

- (CGSize)screenSize {
    return self.videoLifecycleManager.videoScaleManager.displayViewportResolution;
}

- (nullable SDLVideoStreamingFormat *)videoFormat {
    return self.videoLifecycleManager.videoFormat;
}

- (NSArray<SDLVideoStreamingFormat *> *)supportedFormats {
    return self.videoLifecycleManager.supportedFormats;
}

- (CVPixelBufferPoolRef __nullable)pixelBufferPool {
    return self.videoLifecycleManager.pixelBufferPool;
}

- (SDLStreamingEncryptionFlag)requestedEncryptionType {
    // both audio and video managers should have same type
    return self.videoLifecycleManager.requestedEncryptionType;
}

- (BOOL)showVideoBackgroundDisplay {
    // both audio and video managers should have same type
    return self.videoLifecycleManager.showVideoBackgroundDisplay;
}

#pragma mark - Setters
- (void)setRootViewController:(nullable UIViewController *)rootViewController {
    self.videoLifecycleManager.rootViewController = rootViewController;
}

- (void)setRequestedEncryptionType:(SDLStreamingEncryptionFlag)requestedEncryptionType {
    self.videoLifecycleManager.requestedEncryptionType = requestedEncryptionType;
    self.audioLifecycleManager.requestedEncryptionType = requestedEncryptionType;
}

- (void)setShowVideoBackgroundDisplay:(BOOL)showVideoBackgroundDisplay {
    self.videoLifecycleManager.showVideoBackgroundDisplay = showVideoBackgroundDisplay;
}

@end

NS_ASSUME_NONNULL_END
