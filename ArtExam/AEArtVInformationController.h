//
//  AEArtVInformationController.h
//  ArtExam
//
//  Created by renxuan on 15/8/19.
//  Copyright (c) 2015年 renxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEArtInformationViewCell.h"
#import "PullTableView.h"
#import "LoadMoreTableFooterView.h"


@interface AEArtVInformationController : UIViewController<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>
{
    NSMutableArray *m_arrInfos;
    PullTableView *m_tableView;
}

@end
