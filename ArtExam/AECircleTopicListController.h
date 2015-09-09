//
//  AECircleTopicListController.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNViewController.h"
#import "AETopicListTableView.h"
#import "AECircle.h"

@interface AECircleTopicListController : DBNViewController{
}

@property (nonatomic, weak) IBOutlet PullTableView *topicListTV;

@property (nonatomic, strong) AECircle *circleInfo;

- (instancetype)initWithCircle:(AECircle *)circle;

@end
