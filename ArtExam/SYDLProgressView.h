//
//  SYDLProgressView.h
//  EKWStudent
//
//  Created by dahai on 14-7-29.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYDLProgressView : UIView

@property (nonatomic) float progress;                          // 1.0 .. 100.0, default is 0.0. values outside are pinned.
@property (nonatomic, strong) UIColor* progressTintColor;
@property (nonatomic, strong) UIColor* trackTintColor;
@property (nonatomic) float plan;

@property (nonatomic) BOOL isShowRatio;                        //显示比例
@property (nonatomic, strong) UILabel *ratioLabel;
@property (nonatomic, strong) NSString *rationStr;             //12/50
@property (nonatomic) BOOL isSubVCornerRadius;

- (void)setProgress:(float)progress andRatio:(NSString *)ratioStr animated:(BOOL)animated;
@end
