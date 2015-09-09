//
//  AEExamNewsCell.h
//  ArtExam
//
//  Created by liubo on 15/7/18.
//  Copyright (c) 2015年 liubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBNImageView.h"
#import "AEExamNews.h"
#import "UIImageView+AFNetworking.h"

@interface AEExamNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet DBNImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *views;
@property (weak, nonatomic) IBOutlet UILabel *cdate;
-(void)configureWithColleage:(AEExamNews *)examNews;
@end
