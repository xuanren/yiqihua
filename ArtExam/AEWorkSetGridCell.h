//
//  AEWorkSetGridCell.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "GMGridViewCell.h"
#import "DBNImageView.h"
#import "AEWorkSet.h"

@interface AEWorkSetGridCell : GMGridViewCell{
}

@property (nonatomic, retain) DBNImageView *imgView;
@property (nonatomic, retain) UILabel *titleLbl;
@property (nonatomic, retain) UILabel *numLabel;

- (void)configureWithWorkSet:(AEWorkSet *)workSet;

@end
