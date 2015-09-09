//
//  AEShowInfoCell.h
//  ArtExam
//
//  Created by dahai on 14-9-10.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEQuestion.h"
#import "DBNImageView.h"

@interface AEQuestionInfoCell : UITableViewCell

@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *starTimeLabel;
@property (nonatomic) BOOL isLookUp;                               //老师是否查阅
@property (nonatomic, strong) DBNImageView *worksImgView;             //作品图片
@property (nonatomic, strong) UILabel *worksDescribe;                //作品描述
@property (nonatomic, weak) UIViewController *rootController;
@property (nonatomic) long long currTimeStamp;  // current time stamp



-(void)configureWithQuestion:(AEQuestion*)question;

@end
