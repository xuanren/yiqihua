//
//  AEWorkGridCell.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "GMGridViewCell.h"
#import "DBNImageView.h"
#import "AEWorkSet.h"
@interface AEWorkGridCell : GMGridViewCell

@property (nonatomic, retain) DBNImageView *imgView;

- (void)setImgUrl:(NSString *)url;

- (void)setImgName:(NSString *)imgName;
- (void)configureWithWorkSet:(NSDictionary *)workDic;
@end
