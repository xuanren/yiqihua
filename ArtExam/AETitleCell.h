//
//  AETitleCell.h
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AEQuestionBank;
@class AEHotMajor;
@class AEColleageIntro;
@class AEEadress;
@class AEMatriculate;
@class AEAdmissions;

@interface AETitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void)configureWithQuestionBank:(AEQuestionBank *)questionBank;

-(void)configureWithHotMajor:(AEHotMajor *)hotMajor;

//简章
-(void)configureWithColleageIntro:(AEColleageIntro *)colleageIntro;

//考点查询
-(void)configureWithEadress:(AEEadress *)eadressIntro;

//录取规则
-(void)configureWithMatriculate:(AEMatriculate *)matriculate;

//招生简章
-(void)configureWithAdmissions:(AEAdmissions *)admissions;
@end
