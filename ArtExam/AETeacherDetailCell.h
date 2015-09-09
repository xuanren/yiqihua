//
//  AEUserDetailCell.h
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AETeacherInfo.h"

@interface AETeacherDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLable;
@property (weak, nonatomic) IBOutlet UILabel *workDescribeLabel;

-(void)configureWithTchInfo:(AETeacherInfo *)teacherInfo;
@end
