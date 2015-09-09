//
//  AEUserCenterController.h
//  ArtExam
//
//  Created by dkllc on 14-9-2.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBNViewController.h"
#import "SYDLProgressView.h"
#import "DBNImageView.h"

@interface AEUserCenterController : DBNViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;

@property (weak, nonatomic) IBOutlet DBNImageView *userBgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *logoBgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dengjiLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratioLabel;
@property (weak, nonatomic) IBOutlet SYDLProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet UIView *infoVIew;

@property (weak, nonatomic) IBOutlet UILabel *attentionNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *questionNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *artexamNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *imgNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (nonatomic) int userId;

- (id)initWithUserId:(int)uId;

- (IBAction)onClickAttention:(id)sender;
- (IBAction)onClickSiXin:(id)sender;
- (IBAction)onClickUserInfo:(id)sender;

- (IBAction)onClickAttentionList:(id)sender;
- (IBAction)onClickFans:(id)sender;
- (IBAction)onClickQuestion:(id)sender;
- (IBAction)onClickTopic:(id)sender;
- (IBAction)onClickCollectSchool:(id)sender;
- (IBAction)onClickCollectArtexam:(id)sender;
- (IBAction)onClickLogin:(id)sender;
- (IBAction)onClickCollectImgs:(id)sender;

@end
