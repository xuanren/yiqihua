//
//  AEHorizonPicsView.h
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"

@interface AEHorizonPicsView : UIView{
}

@property (nonatomic, strong) GMGridView *gridView;
@property (nonatomic, strong) NSArray *picArr;
@property (nonatomic, strong) UIView *numBg;;
@property (nonatomic, strong) UILabel *numLbl;

- (void)setElementWidth:(float)width;

@end
