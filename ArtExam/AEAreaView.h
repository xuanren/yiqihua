//
//  AEAreaView.h
//  TestAutoLayout
//
//  Created by dahai on 14-9-26.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AEAreaView;

@protocol AEAreaViewDelegate <NSObject>

- (void)areaView:(AEAreaView *)areaView selectIndex:(int)index;

@end

@interface AEAreaView : UIScrollView

@property (nonatomic) float paddingL;
@property (nonatomic) float paddingT;
@property (nonatomic) float paddingV;
@property (nonatomic) float paddingH;
@property (nonatomic) float titleViewHeight;
@property (nonatomic, weak) id<AEAreaViewDelegate> delegatee;

@property (nonatomic, strong) NSArray *areaList;

- (void)upDataAreaList:(NSArray *)array showColumn:(int)colum;
@end
