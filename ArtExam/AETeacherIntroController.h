//
//  AETeacherDetailController.h
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

/*****************************************
          老师简介
 ***************************************/

#import "DBNViewController.h"
#import "AETopicUser.h"

@interface AETeacherIntroController : DBNViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UIImageView *logoBgImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *describeTextView;
@property (weak, nonatomic) IBOutlet UIView *infoView;


-(void)configureWithTchInfo:(AETopicUser *)tchUser;

- (IBAction)touchTapGestureRecognizer:(UITapGestureRecognizer *)sender;

@end
