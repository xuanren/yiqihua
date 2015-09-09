//
//  AEWorkSetsController.h
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNViewController.h"
#import "GMGridView.h"

@interface AEWorkSetsController : DBNViewController{
}

@property (nonatomic, retain) GMGridView *gmGridView;

-(instancetype)initWithTitle:(NSString*)titleName withSelectId:(NSString *)selId;


@end
