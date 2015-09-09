//
//  AEMatriculateViewController.h
//  ArtExam
//
//  Created by Zhengen on 15-6-10.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

/*******************************************
            录取规则
 ******************************************/

#import "DBNViewController.h"

@interface AEMatriculateViewController : DBNViewController

@property (strong, nonatomic) NSString *colleageID;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end
