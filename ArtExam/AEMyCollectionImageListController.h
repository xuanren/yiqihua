//
//  AEMyCollectionImageListController.h
//  ArtExam
//
//  Created by dahai on 14-10-13.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"
#import "GMGridView.h"

@interface AEMyCollectionImageListController : DBNViewController

@property (nonatomic, strong) GMGridView *gmGridView;

@property (nonatomic, strong) NSArray *picArr;

- (id)initWithUserId:(int)uid;
@end
