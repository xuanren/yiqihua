//
//  AEPicGridViewCell.h
//  ArtExam
//
//  Created by dkllc on 14-9-15.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "GMGridViewCell.h"
#import "DBNImageView.h"

@interface AEPicGridViewCell : GMGridViewCell

@property (nonatomic, weak) DBNImageView *imgView;

- (void)loadImgWithUrl:(NSString *)url;

@end
