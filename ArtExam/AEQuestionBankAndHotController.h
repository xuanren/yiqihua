//
//  AEQuestionBankAndHotController.h
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

/*******************************************
            题库
 ******************************************/

#import "DBNViewController.h"

@interface AEQuestionBankAndHotController : DBNViewController

@property (strong, nonatomic) NSString *colleageID;

@property (assign, nonatomic) BOOL isColleageIntroList;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end
