//
//  AEAdmissionsViewController.h
//  ArtExam
//
//  Created by Zhengen on 15-6-18.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

/*******************************************
            招生简章
 ******************************************/

#import "DBNViewController.h"

@interface AEAdmissionsViewController : DBNViewController

@property (strong, nonatomic) NSString *colleageID;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end
