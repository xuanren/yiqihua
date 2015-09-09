//
//  AEColleageDetailController.h
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"
#import "AEColleage.h"
@interface AEColleageDetailController : DBNViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *colleageImgView;
@property (weak, nonatomic) IBOutlet UILabel *imgNumLabel;


@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *peoplesLabel;


@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *thisYearBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextYearBtn;

- (id)initWithColleageId:(NSString *)collegeId;

- (id)initWithColleage:(AEColleage *)currentCollege withThumImg:(UIImage *)thumImg;

- (IBAction)onClickColleagePics:(id)sender;
- (IBAction)onClickGetIntoCollege:(id)sender;
- (IBAction)onClickCollegeInfo:(id)sender;
- (IBAction)onClickProfessionalIntroduction:(id)sender;
- (IBAction)onClickQuestion:(id)sender;
- (IBAction)onClickThisYear:(id)sender;
- (IBAction)onClickNextYear:(id)sender;


@end
