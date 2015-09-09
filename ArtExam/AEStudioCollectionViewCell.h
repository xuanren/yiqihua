//
//  AEStudioCollectionViewCell.h
//  ArtExam
//
//  Created by chen on 15/8/12.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface AEStudioCollectionViewCell : UICollectionViewCell
@property (nonatomic,retain) UILabel *studioNameLabel;
@property (nonatomic,retain) UILabel *studioTypeLabel;
@property (nonatomic,retain) UIImageView *imageview;

- (id)initWithFrame:(CGRect)frame;
- (BOOL) setCellInfo :(NSDictionary *)dicInfo;
@end
