//
//  AETopicDetailsCell.m
//  ArtExam
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AETopicDetailsCell.h"
#import "DBNUtils.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "AEUserCenterController.h"
#import "AETopicDetailsController.h"
#import "AETopic.h"
#import "AECircleTopicListController.h"
#import "AECircle.h"

@interface AETopicDetailsCell ()

@property (nonatomic, weak) IBOutlet UILabel *pvNumLbl;
@property (nonatomic, weak) IBOutlet UILabel *phraseNumLbl;
@property (nonatomic, weak) IBOutlet UILabel *commentNumLbl;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentConstraintH;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *picConstraintH;


@property (nonatomic, strong) AETopic *topic;

@property (nonatomic) int userId;

@end

@implementation AETopicDetailsCell

- (void)awakeFromNib
{
    // Initialization code
    self.avatarImgView.layer.cornerRadius = 20;
    self.avatarImgView.layer.masksToBounds = YES;
    
    self.avatarImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self.avatarImgView addGestureRecognizer:tapGesture];
    
    self.nameLbl.textColor = [DBNUtils getColor:@"2b2e32"];
    self.timeLbl.textColor = [DBNUtils getColor:@"aab0ba"];
    self.titleLbl.textColor = [DBNUtils getColor:@"69707a"];
    self.contentLbl.textColor = [DBNUtils getColor:@"69707a"];
    self.contentLbl.numberOfLines = 0;
    self.pvNumLbl.textColor = [DBNUtils getColor:@"b1b7c0"];
    self.phraseNumLbl.textColor = [DBNUtils getColor:@"b1b7c0"];
    self.commentNumLbl.textColor = [DBNUtils getColor:@"b1b7c0"];
    
    self.picView.showLargeImg = YES;
    self.picView.backgroundColor = [UIColor clearColor];
    self.picView.paddingL = 10.0;
    [self.picView setLargeModeWithPhotoWidth:self.frame.size.width-20];
    
    self.quanziBtn.layer.cornerRadius = 10.0;
    self.quanziBtn.layer.masksToBounds = YES;
    self.quanziBtn.backgroundColor = [DBNUtils getColor:@"b0b7c0"];
//    [self.quanziBtn addTarget:self action:@selector(goToPostList) forControlEvents:UIControlEventTouchUpInside];
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

+ (float)heightForTopicDetailCellWithTopic:(AETopic *)topic{
    float h = 142;
    
    UILabel *contentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320 - 18, 0)];
    contentLbl.font = [UIFont systemFontOfSize:13.0];
    contentLbl.numberOfLines = 0;
    contentLbl.text = topic.content;
    [contentLbl sizeToFit];
    h+= contentLbl.frame.size.height;
    
//    DBNPhotoCollection *photoView = [[DBNPhotoCollection alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
//    photoView.showLargeImg = YES;
//    [photoView setLargeModeWithPhotoWidth:320];
//    photoView.photoArray = topic.picArr;
    
    if ([topic.picArr count] > 0) {
        h +=[DBNPhotoCollection heightForImages:topic.picArr photoWidth:300 photoPadding:5 showLargeImg:YES];
    }else{
        
//        return 114 + contentLbl.frame.size.height;
//        h -= 10;
    }

    return h + 20;
}

- (IBAction)returnAction:(id)sender{
//    [self.rootController.navigationController popViewControllerAnimated:YES];
    if (self.rootController) {
        int currIndex =  [self.rootController.navigationController.viewControllers indexOfObject:self.rootController];
                
        currIndex--;
        if (currIndex >= 0) {
            UIViewController *tmpController = [self.rootController.navigationController.viewControllers objectAtIndex:currIndex];
            if ([tmpController isKindOfClass:[AECircleTopicListController class]]) {
                if (((AECircleTopicListController *)tmpController).circleInfo.circieLd == self.topic.circleId) {
                    [self.rootController.navigationController popViewControllerAnimated:YES];
                }else{
                    [self goToTopicList];
                }
            }else{
                [self goToTopicList];
            }
        }
    }

}

- (void)goToPostList{
    if (self.rootController) {
        int currIndex =  [self.rootController.navigationController.viewControllers indexOfObject:self.rootController];

        
        currIndex--;
        if (currIndex >= 0) {
            UIViewController *tmpController = [self.rootController.navigationController.viewControllers objectAtIndex:currIndex];
            if ([tmpController isKindOfClass:[AECircleTopicListController class]]) {
                if (((AECircleTopicListController *)tmpController).circleInfo.circieLd == self.topic.circleId) {
                    [self.rootController.navigationController popViewControllerAnimated:YES];
                }else{
                    [self goToTopicList];
                }
            }else{
                [self goToTopicList];
            }
        }
    }
}

- (void)goToTopicList{
    if (self.topic.circleId != 0) {
        AECircle *circle = [[AECircle alloc]init];
        circle.circieLd = self.topic.circleId;
        
        AECircleTopicListController *controller = [[AECircleTopicListController alloc]initWithCircle:circle];
        [self.rootController.navigationController pushViewController:controller animated:YES];
    }
}



- (void)configureWithTopic:(AETopic *)topic{
    
    self.topic = topic;
    
//    self.quanziBtn setTitle:topic.q forState:<#(UIControlState)#>
    self.nameLbl.text = topic.user.userName;
    self.timeLbl.text = [DBNUtils time:[[NSDate date] timeIntervalSince1970] since:topic.subtime];
    self.titleLbl.text = topic.title;
    self.contentLbl.text = topic.content;
    
    UILabel *tmpContentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320 - 18, 0)];
    tmpContentLbl.font = [UIFont systemFontOfSize:13.0];
    tmpContentLbl.numberOfLines = 0;
    tmpContentLbl.text = topic.content;
    [tmpContentLbl sizeToFit];
    
//    self.contentLbl.backgroundColor = [UIColor greenColor];
    
    self.contentConstraintH.constant = tmpContentLbl.frame.size.height;
    
    self.userId = topic.user.userId;
    
    if (topic.circle.name != nil) {
        [self.quanziBtn setTitle:topic.circle.name forState:UIControlStateNormal];
        self.quanziBtn.hidden = NO;
    }else{
        self.quanziBtn.hidden = YES;
    }
    
    if (topic.user.avatarUrl != nil) {
        [self.avatarImgView setImageWithURL:[NSURL URLWithString:topic.user.avatarUrl] placeholderImage:nil];
    }
    
    self.pvNumLbl.text = [NSString stringWithFormat:@"%d",topic.pvNum];
    self.commentNumLbl.text = [NSString stringWithFormat:@"%d",topic.commentNum];
    self.phraseNumLbl.text = [NSString stringWithFormat:@"%d",topic.phraiseNum];
    
    
    if ([topic.picArr count] > 0) {
        self.picView.photoArray = topic.picArr;
        self.picConstraintH.constant = self.picView.frame.size.height;
    }else{
        self.picConstraintH.constant = 0;
    }

}

@end
