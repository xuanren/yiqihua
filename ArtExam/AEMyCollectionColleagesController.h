//
//  AEMyCollectionColleagesController.h
//  ArtExam
//
//  Created by dkllc on 14-9-21.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNViewController.h"
#import "PullTableView.h"

@interface AEMyCollectionColleagesController : DBNViewController

@property (weak, nonatomic) IBOutlet PullTableView *colleageTableView;

- (instancetype)initWithUID:(int)uId;
@end
