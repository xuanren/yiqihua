//
//  AETitleCell.m
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AETitleCell.h"
#import "AEQuestionBank.h"
#import "AEHotMajor.h"
#import "AEEadress.h"
#import "AEMatriculate.h"
#import "AEAdmissions.h"

@implementation AETitleCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureWithQuestionBank:(AEQuestionBank *)questionBank{
    
    self.titleLabel.text = questionBank.title;
}

-(void)configureWithMatriculate:(AEMatriculate *)matriculate{
    
    self.titleLabel.text = matriculate.title;
}

-(void)configureWithAdmissions:(AEAdmissions *)admissions{
    
    self.titleLabel.text = admissions.title;
}

-(void)configureWithHotMajor:(AEHotMajor *)hotMajor{
    
    self.titleLabel.text = hotMajor.title;
}

-(void)configureWithColleageIntro:(AEColleageIntro *)colleageIntro{
    //self.titleLabel.text =
}

-(void)configureWithEadress:(AEEadress *)eadressIntro{
    self.titleLabel.text = eadressIntro.eadressTitle;
}

@end
