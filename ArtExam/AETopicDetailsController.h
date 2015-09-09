//
//  AETopicDetailsController.h
//  ArtExam
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNViewController.h"
#import "PullTableView.h"

@interface AETopicDetailsController : DBNViewController{
    float _prevScrollViewOffsetY;
}

@property (nonatomic, weak) IBOutlet PullTableView *commentTV;

@property (nonatomic) int postId;

@property (nonatomic) int circleId;

- (instancetype)initWithPostId:(int)pId;

@end
