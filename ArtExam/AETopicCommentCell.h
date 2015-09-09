//
//  AETopicCommentCell.h
//  ArtExam
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBNPhotoCollection.h"
#import "AEComment.h"
#import "AETopic.h"

@interface AETopicCommentCell : UITableViewCell{
}

@property (nonatomic, weak) IBOutlet UIImageView *avatarImgView;
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UILabel *timeLbl;
@property (nonatomic, weak) IBOutlet UILabel *contentLbl;
@property (nonatomic, weak) IBOutlet DBNPhotoCollection *picView;

@property (nonatomic, weak) IBOutlet UILabel *rContentLbl;
@property (nonatomic, weak) IBOutlet UILabel *rUserNameLbl;
@property (nonatomic, weak) IBOutlet UIView *botomView;
@property (nonatomic, weak) IBOutlet UIImageView *replyUserImgBG;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *picViewConstraintH;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentLblConstraintH;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomConstraintH;

@property (nonatomic, weak) UIViewController *rootController;

@property (nonatomic) int userId;


@property (copy, nonatomic) void (^replyButtonDidPressed)();



- (void)configureWithComment:(AEComment *)comment;
+ (float)heightForTopicDetailCellWithComment:(AEComment *)comment;

@end
