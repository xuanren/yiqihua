//
//  AEHotMajorController.h
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

/***********************************************
            热门专业 (校考内容)
 **********************************************/

#import "DBNViewController.h"

@interface AEHotMajorController : DBNViewController

@property (weak, nonatomic) IBOutlet UITableView *listTableVIew;

@property (assign, nonatomic) BOOL isHotMajor;

@end
