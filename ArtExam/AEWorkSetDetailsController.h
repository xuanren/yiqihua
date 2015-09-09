//
//  AEWorkSetDetailsController.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNViewController.h"
#import "GMGridView.h"
#import "AEWorkSet.h"

@interface AEWorkSetDetailsController : DBNViewController{
}

@property (nonatomic, strong) GMGridView *gmGridView;

@property (nonatomic, strong) AEWorkSet *workSet;

- (instancetype)initWithWorkSet:(AEWorkSet *)workSet;


@end
