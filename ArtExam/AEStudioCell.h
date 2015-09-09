//
//  AEStudioCell.h
//  test
//
//  Created by dkllc on 14-9-11.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEStudio.h"
#import "DBNImageView.h"

@interface AEStudioCell : UITableViewCell{
}

@property (nonatomic, weak) IBOutlet DBNImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UILabel *detailsLbl;
@property (nonatomic, weak) IBOutlet UILabel *popularLbl;

- (void)configureWithStudio:(AEStudio *)studio;

@end
