//
//  AEShowColleagePicsController.h
//  ArtExam
//
//  Created by dkllc on 14-9-21.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNViewController.h"
#import "GMGridView.h"

@interface AEShowColleagePicsController : DBNViewController{
}

@property (nonatomic, strong) GMGridView *gmGridView;

@property (nonatomic, strong) NSArray *picArr;;

- (instancetype)initWithWorkSet:(NSArray *)picArr;


@end
