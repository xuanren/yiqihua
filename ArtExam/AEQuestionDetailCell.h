//
//  AEQuestionDetailCell.h
//  ArtExam
//
//  Created by dahai on 14-9-10.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEQuestion.h"
#import "DBNImageView.h"
#import "AEScoreView.h"
#import "DBNPhotoCollection.h"

@interface AEQuestionDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UILabel *stdNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet DBNPhotoCollection *worksImgView;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scroceLabel;
@property (weak, nonatomic) IBOutlet AEScoreView *scroceView;

@property (nonatomic, weak) UIViewController *rootController;

-(void)configureWithQuestion:(AEQuestion*)question;
+(float)heightForQuestionInfoCellWithQuestion:(AEQuestion *)question;

@end
