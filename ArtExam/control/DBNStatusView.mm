//
//  DBNStatusView.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBNStatusView.h"
//#import "CWLSynthesizeSingleton.h"
#import <QuartzCore/QuartzCore.h>

@implementation DBNStatusView

//CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(DBNStatusView);

const static float statusViewWidth = 200;
const static float statusViewHeight = 150;

+(DBNStatusView *)sharedDBNStatusView {
    static dispatch_once_t pred;
    static DBNStatusView *shared = nil;

    dispatch_once(&pred, ^{
        shared = [[DBNStatusView alloc] init];
        [shared updateStatusOrientation];
        [[NSNotificationCenter defaultCenter] addObserver:shared selector:@selector(updateStatusOrientation) name:UIDeviceOrientationDidChangeNotification object:nil];
    });
    return shared;
}

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, statusViewWidth, statusViewHeight)];
    if(self) {
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
        self.layer.cornerRadius = 20.0;
        
        self.layer.shadowOffset = CGSizeMake(1, 0);
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = .25;
        
        self.opaque = NO;
        self.alpha = 0.7;
        
        ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        ind.frame = CGRectMake((statusViewWidth-30)/2, 30, 30, 30);
        [self addSubview:ind];
        [ind startAnimating];
        
        busyTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 70, statusViewWidth, 80)];
        busyTextView.textColor = [UIColor whiteColor];
        busyTextView.backgroundColor = [UIColor clearColor];
        busyTextView.font = [UIFont systemFontOfSize:17.0];
        busyTextView.textAlignment = NSTextAlignmentCenter;
        busyTextView.userInteractionEnabled = NO;
        [self addSubview:busyTextView];
        
        statusView = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, statusViewWidth, 70)];
        statusView.numberOfLines = 0;
        statusView.textAlignment = NSTextAlignmentCenter;
        statusView.textColor = [UIColor whiteColor];
        statusView.backgroundColor = [UIColor clearColor];
        statusView.font = [UIFont systemFontOfSize:17.0];
        [self addSubview:statusView];
    }
    return self;
}

- (void)showBusyStatus:(NSString*)str {
    busyTextView.hidden = NO;
    statusView.hidden = YES;
    [ind startAnimating];
    busyTextView.text = str;
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    self.frame = CGRectMake((mainWindow.frame.size.width-self.frame.size.width)/2,
                            (mainWindow.frame.size.height-self.frame.size.height)/2,
                            self.frame.size.width, self.frame.size.height);
    [mainWindow addSubview:self];
}

- (void)showStatus:(NSString*)str dismissAfter:(float)delay {
    CGSize sizeToFit = [str sizeWithFont:[UIFont systemFontOfSize:17.0]
                       constrainedToSize:CGSizeMake(statusViewWidth, statusViewHeight)
                           lineBreakMode:NSLineBreakByWordWrapping];
    CGRect textFrame = busyTextView.frame;
    textFrame.size = CGSizeMake(statusViewWidth, sizeToFit.height);
    textFrame.origin.y = (statusViewHeight - sizeToFit.height) / 2;
    statusView.frame = textFrame;
    busyTextView.hidden = YES;
    statusView.hidden = NO;
    statusView.text = str;
    [ind stopAnimating];
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if(!self.superview || self.superview != mainWindow) {
        self.frame = CGRectMake((mainWindow.frame.size.width-self.frame.size.width)/2,
                                (mainWindow.frame.size.height-self.frame.size.height)/2,
                                self.frame.size.width, self.frame.size.height);
        [mainWindow addSubview:self];
    }
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:delay];
}

- (void)dismiss {
    [ind stopAnimating];
    [self removeFromSuperview];
}

- (void)updateStatusOrientation {
    CGAffineTransform t = CGAffineTransformIdentity;
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case UIDeviceOrientationPortrait:
            t = CGAffineTransformIdentity;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            t = CGAffineTransformMakeRotation(M_PI);
            break;
        case UIDeviceOrientationLandscapeLeft:
            t = CGAffineTransformMakeRotation(M_PI * 0.5);
            break;
        case UIDeviceOrientationLandscapeRight:
            t = CGAffineTransformMakeRotation(M_PI * 1.5);
            break;
        default:
            break;
    }
    self.transform = t;
}

@end
