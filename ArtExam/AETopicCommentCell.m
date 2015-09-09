//
//  AETopicCommentCell.m
//  ArtExam
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AETopicCommentCell.h"
#import "DBNUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "AEUserCenterController.h"

@implementation AETopicCommentCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.avatarImgView.layer.cornerRadius = 15;
    self.avatarImgView.layer.masksToBounds = YES;
    
    self.avatarImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self.avatarImgView addGestureRecognizer:tapGesture];

    
    self.nameLbl.textColor = [DBNUtils getColor:@"2b2e32"];
    self.timeLbl.textColor = [DBNUtils getColor:@"aab0ba"];
    self.contentLbl.textColor = [DBNUtils getColor:@"69707a"];
    self.contentLbl.numberOfLines = 0;
    
    self.rContentLbl.numberOfLines = 0;
    self.rContentLbl.textColor = [DBNUtils getColor:@"69707a"];
    self.rUserNameLbl.textColor = [DBNUtils getColor:@"2b2e32"];
    
    self.picView.showLargeImg = YES;
    self.picView.backgroundColor = [UIColor clearColor];
    self.picView.paddingL = 0.0;
    [self.picView setLargeModeWithPhotoWidth:253];
    
    UIImage *img = [UIImage imageNamed:@"reply-img-bg"];
    
    [self.replyUserImgBG setImage:[img stretchableImageWithLeftCapWidth:img.size.width/2.0 + 2 topCapHeight:img.size.height/2.0 + 4]];
    
}

- (void)handleTapGesture:(UITapGestureRecognizer *)gesture{
    AEUserCenterController *controller = [[AEUserCenterController alloc]initWithUserId:self.userId];
    [self.rootController.navigationController pushViewController:controller animated:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)replyAction:(id)sender{
    if (self.replyButtonDidPressed) {
        self.replyButtonDidPressed();
    }
}

- (void)configureWithComment:(AEComment *)comment{
    
    self.userId = comment.user.userId;
    
    self.nameLbl.text = comment.user.userName;
    self.timeLbl.text = @"时间";
    self.timeLbl.text = [DBNUtils time:[[NSDate date] timeIntervalSince1970] since:comment.subtime];

    self.contentLbl.text = comment.content;
    
    UILabel *contentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 253, 0)];
    contentLbl.font = [UIFont systemFontOfSize:13.0];
    contentLbl.numberOfLines = 0;
    contentLbl.text = comment.content;
    [contentLbl sizeToFit];
    
    self.contentLblConstraintH.constant = contentLbl.frame.size.height;

    if (comment.user.avatarUrl != nil) {
        [self.avatarImgView setImageWithURL:[NSURL URLWithString:comment.user.avatarUrl] placeholderImage:nil];
    }
    

//    [self.rContentLbl sizeToFit];
    
    if ([comment.picArr count] > 0) {
        self.picView.photoArray = comment.picArr;
        self.picView.hidden = NO;
        
        self.picViewConstraintH.constant = self.picView.frame.size.height;
        
    }else{
        self.picView.hidden = YES;
        self.picViewConstraintH.constant = 0;
    }
    
    if (comment.origUser) {
        
        UILabel *contentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 233, 0)];
        //        contentLbl.font = [UIFont systemFontOfSize:13.0];
        contentLbl.numberOfLines = 0;
        contentLbl.text = [comment.origcommentDic objectForKey:@"content"];
        [contentLbl sizeToFit];
        
        self.rContentLbl.text = [comment.origcommentDic objectForKey:@"content"];
        
        self.bottomConstraintH.constant = contentLbl.frame.size.height + 30;
        self.botomView.hidden = NO;
        
        self.rUserNameLbl.text = comment.origUser.userName;
        
    }else{
        
        self.bottomConstraintH.constant = 0;
        self.botomView.hidden = YES;
    }
    
    [self updateConstraints];
}

+ (float)heightForTopicDetailCellWithComment:(AEComment *)comment{
    float h = 50;
    
    UILabel *contentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 253, 0)];
    contentLbl.font = [UIFont systemFontOfSize:13.0];
    contentLbl.numberOfLines = 0;
    contentLbl.text = comment.content;

    [contentLbl sizeToFit];
    h+= contentLbl.frame.size.height;
    
//    h+= contentLbl.frame.size.height;
    
    if ([comment.picArr count] > 0) {
        h +=[DBNPhotoCollection heightForImages:comment.picArr photoWidth:253 photoPadding:5 showLargeImg:YES];
        
        h += 20;

    }
    
    if (comment.origUser) {
        UILabel *contentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 233, 0)];
//        contentLbl.font = [UIFont systemFontOfSize:13.0];
        contentLbl.numberOfLines = 0;
        contentLbl.text = [comment.origcommentDic objectForKey:@"content"];
        [contentLbl sizeToFit];
        
        h += contentLbl.frame.size.height;
        
        h += 30;
    }
//
    
    h += 20;
    return h;
}

@end
