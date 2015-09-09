//
//  AETCommentCell.h
//  ArtExam
//
//  Created by dahai on 14-9-10.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEAnswer.h"

@interface AETCommentCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *scorceLabel;
@property (nonatomic, strong) UILabel *describeLabel;

- (void)updataQuestion:(AEAnswer *)answer;

+(float)heightForCommentCellWithAnswer:(AEAnswer *)answer;

@end
