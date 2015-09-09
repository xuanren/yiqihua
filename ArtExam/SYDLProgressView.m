//
//  SYDLProgressView.m
//  EKWStudent
//
//  Created by dahai on 14-7-29.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "SYDLProgressView.h"

@interface SYDLProgressView ()

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIView *trackView;

@end

@implementation SYDLProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self initialization];
        
    }
    return self;

}

- (void)initialization{
    
    CGRect tmpRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    self.trackView = [[UIView alloc] initWithFrame:tmpRect];
    _trackView.backgroundColor = [UIColor cyanColor];
    [self addSubview:_trackView];
    
    tmpRect.size.width = 0;
    self.progressView = [[UIView alloc] initWithFrame:tmpRect];
    _progressView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_progressView];
    
    tmpRect.size.width = self.frame.size.width;
    tmpRect.size.height = 20;
    tmpRect.origin.y = (self.frame.size.height - 20) / 2.0;
    self.ratioLabel = [[UILabel alloc] initWithFrame:tmpRect];
    _ratioLabel.backgroundColor = [UIColor clearColor];
    _ratioLabel.font = [UIFont systemFontOfSize:15.f];
    _ratioLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_ratioLabel];
    
    self.plan = tmpRect.size.width / 100.0;
}

- (void)setProgress:(float)progress andRatio:(NSString *)ratioStr animated:(BOOL)animated{

    
    if (animated) {
        
        [UIView animateWithDuration:1.f animations:^{
            
            CGRect rect = self.progressView.frame;
            rect.size.width = _plan * progress;
            self.progressView.frame = rect;
            
            self.rationStr = ratioStr;
        }];
    }else{
        
        CGRect rect = self.progressView.frame;
        rect.size.width = _plan * progress;
        self.progressView.frame = rect;
        
        self.rationStr = ratioStr;
    }
    
    
    
}

- (void)setProgress:(float)progress{
    
    if (_progress == progress) {
        
        return;
    }
    
    _progress = progress;
    
    CGRect rect = self.progressView.frame;
    rect.size.width = _plan * _progress;
    self.progressView.frame = rect;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor{
    
    if (_progressTintColor != progressTintColor) {
        
        _progressTintColor = progressTintColor;
        self.progressView.backgroundColor = _progressTintColor;
    }
}

- (void)setTrackTintColor:(UIColor *)trackTintColor{
    
    if (_trackTintColor != trackTintColor) {
        
        _trackTintColor = trackTintColor;
        self.trackView.backgroundColor = _trackTintColor;
    }
}

- (void)setIsShowRatio:(BOOL)isShowRatio{
    
    if (_isShowRatio != isShowRatio) {
        
        _isShowRatio = isShowRatio;
        self.ratioLabel.hidden = _isShowRatio;
    }
}

- (void)setRationStr:(NSString *)rationStr{
    
    if (_rationStr != rationStr) {
        
        _rationStr = rationStr;
        self.ratioLabel.text = [NSString stringWithFormat:@"%@",_rationStr];
    }
}

- (void)setIsSubVCornerRadius:(BOOL)isSubVCornerRadius{
    
    if (_isSubVCornerRadius != isSubVCornerRadius) {
        
        _isSubVCornerRadius = isSubVCornerRadius;
        
        _progressView.layer.cornerRadius = self.layer.cornerRadius;
        _trackView.layer.cornerRadius = self.layer.cornerRadius;
    }
}

@end
