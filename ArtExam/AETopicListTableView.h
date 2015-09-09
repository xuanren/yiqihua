//
//  AETopicListTableView.h
//  ArtExam
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "AETopicList.h"

@interface AETopicListTableView : UITableView{
}

@property (nonatomic, weak) UIViewController *rootController;
@property (nonatomic, weak) AETopicList *topicList;


@end
