//
//  VideoSourceViewController.m
//  SmartDeviceLink-iOS
//
//  Copyright © 2018 Luxoft. All rights reserved
//

#import "VideoSourceViewController.h"
#import "SDLTouchManagerDelegate.h"
#import "SimpleRootView.h"
#import "TouchModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface VideoSourceViewController ()
@property (strong, nonatomic, nullable) IBOutletCollection(UIButton) NSArray *buttons;
@end


@interface VideoSourceViewController (SDLTouchManagerDelegate) <SDLTouchManagerDelegate>
@end


@implementation VideoSourceViewController

+ (VideoSourceViewController*)createInstance {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"ExampleVideoApp" bundle:nil];
    VideoSourceViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"idVideoSourceViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    for (UIButton *button in self.buttons) {
        button.tag = 0;
    }
}

- (SimpleRootView *)rootView {
    return (SimpleRootView *)self.view;
}

- (void)updateOnTouchButton:(UIView * _Nullable)viewCandidate {
    if (!viewCandidate) {
        return;
    }
    for (UIButton *button in self.buttons) {
        if (button == viewCandidate) {
            button.tag += 1;
            [button setTitle:[NSString stringWithFormat:@"%03d", (int)button.tag] forState:UIControlStateNormal];
            break;
        }
    }
}

@end


//#Touch_Input:
@implementation VideoSourceViewController (SDLTouchManagerDelegate)

static const CGFloat MinSz = -8.0;

- (void)touchManager:(SDLTouchManager *)manager didReceiveSingleTapForView:(UIView *_Nullable)view atPoint:(CGPoint)point {
    CGRect frame = view.frame;
    if (nil == view) {
        frame.origin = point;
        frame = CGRectInset(frame, MinSz, MinSz);
    }
    self.rootView.singleTap = [TouchModel touchPoint:point inRect:frame];
    [self updateOnTouchButton:view];
    NSLog(@"%s: %@ > %@", __PRETTY_FUNCTION__, NSStringFromClass(view.class), self.rootView.singleTap);
}

- (void)touchManager:(SDLTouchManager *)manager didReceiveDoubleTapForView:(UIView *_Nullable)view atPoint:(CGPoint)point {
    CGRect frame = view.frame;
    if (nil == view) {
        frame.origin = point;
        frame = CGRectInset(frame, MinSz, MinSz);
    }
    self.rootView.doubleTap = [TouchModel touchPoint:point inRect:frame];
    [self updateOnTouchButton:view];
    NSLog(@"%s: %@ > %@", __PRETTY_FUNCTION__, NSStringFromClass(view.class), self.rootView.doubleTap);
}

// panning
- (void)touchManager:(SDLTouchManager *)manager panningDidStartInView:(UIView *_Nullable)view atPoint:(CGPoint)point {
    NSLog(@"%s: %@ > %@", __PRETTY_FUNCTION__, view, NSStringFromCGPoint(point));
}

- (void)touchManager:(SDLTouchManager *)manager didReceivePanningFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    NSLog(@"%s: %@-->%@", __PRETTY_FUNCTION__, NSStringFromCGPoint(fromPoint), NSStringFromCGPoint(toPoint));
}

- (void)touchManager:(SDLTouchManager *)manager panningDidEndInView:(UIView *_Nullable)view atPoint:(CGPoint)point {
    NSLog(@"%s: %@ > %@", __PRETTY_FUNCTION__, view, NSStringFromCGPoint(point));
}

- (void)touchManager:(SDLTouchManager *)manager panningCanceledAtPoint:(CGPoint)point {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, NSStringFromCGPoint(point));
}

// pinch
- (void)touchManager:(SDLTouchManager *)manager pinchDidStartInView:(UIView *_Nullable)view atCenterPoint:(CGPoint)point {
    NSLog(@"%s: %@ > %@", __PRETTY_FUNCTION__, view, NSStringFromCGPoint(point));
}

- (void)touchManager:(SDLTouchManager *)manager didReceivePinchAtCenterPoint:(CGPoint)point withScale:(CGFloat)scale {
    NSLog(@"%s: %@ : %2.2f", __PRETTY_FUNCTION__, NSStringFromCGPoint(point), scale);
}

- (void)touchManager:(SDLTouchManager *)manager didReceivePinchInView:(UIView *_Nullable)view atCenterPoint:(CGPoint)point withScale:(CGFloat)scale {
    NSLog(@"%s: %@ > %@", __PRETTY_FUNCTION__, view, NSStringFromCGPoint(point));
}

- (void)touchManager:(SDLTouchManager *)manager pinchDidEndInView:(UIView *_Nullable)view atCenterPoint:(CGPoint)point {
    NSLog(@"%s: %@ > %@", __PRETTY_FUNCTION__, view, NSStringFromCGPoint(point));
}

- (void)touchManager:(SDLTouchManager *)manager pinchCanceledAtCenterPoint:(CGPoint)point {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, NSStringFromCGPoint(point));
}

#pragma mark - SDLStreamingMediaDelegate

- (void)videoStreamingSizeDidUpdate:(CGSize)displaySize {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, NSStringFromCGSize(displaySize));
}

- (void)videoStreamingSizeDoesNotMatch {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end

NS_ASSUME_NONNULL_END
