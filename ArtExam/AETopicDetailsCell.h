//
//  AETopicDetailsCell.h
//  ArtExam
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AETopic.h"
#import "DBNPhotoCollection.h"

@interface AETopicDetailsCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *avatarImgView;
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UILabel *timeLbl;
@property (nonatomic, weak) IBOutlet UIButton *quanziBtn;

@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UILabel *contentLbl;
@property (nonatomic, weak) IBOutlet DBNPhotoCollection *picView;
@property (nonatomic, weak) IBOutlet UIView *bottomView;

@property (nonatomic, weak) UIViewController *rootController;

- (void)configureWithTopic:(AETopic *)topic;
+ (float)heightForTopicDetailCellWithTopic:(AETopic *)topic;


@end
