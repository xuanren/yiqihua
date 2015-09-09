//
//  AEHomePageCell.h
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEHomeFeed.h"

@interface AEHomePageCell : UITableViewCell

-(void)configureWithFeed:(AEHomeFeed*)feed;

@end
