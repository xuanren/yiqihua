//
//  AETopicListController.h
//  ArtExam
//
//  Created by dkllc on 14-9-2.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBNViewController.h"
#import "AETopicListTableView.h"
#import "PullTableView.h"

@interface AETopicListController : DBNViewController{
}

@property (nonatomic, weak) IBOutlet PullTableView *topicListTV;

@end
