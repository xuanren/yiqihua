//
//  AETopicListCell.h
//  test
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEHorizonPicsView.h"
#import "AETopic.h"

@interface AETopicListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView *bgView;
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UIImageView *tagIconImg;
@property (nonatomic, weak) IBOutlet AEHorizonPicsView *picView;
@property (nonatomic, weak) IBOutlet UILabel *contentLbl;

@property (nonatomic, weak) IBOutlet UIView *bottomView;
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UILabel *timeLbl;

+ (float)heightForTopicListCellWithTopic:(AETopic *)topic;
- (void)configureWithTopic:(AETopic *)topic;

@end
