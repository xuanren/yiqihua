//
//  AESelectGradeCell.h
//  ArtExam
//
//  Created by dahai on 14-9-24.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AESelectGradeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markImgView;


- (void)configureWithGradeInfo:(NSDictionary *)info;
@end
