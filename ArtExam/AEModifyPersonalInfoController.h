//
//  AEModifyPersonalInfoController.h
//  ArtExam
//
//  Created by dahai on 14-9-23.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface AEModifyPersonalInfoController : DBNViewController

@property (nonatomic,strong)  IBOutlet TPKeyboardAvoidingScrollView *sv;

@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UITextField *studioTF;

- (IBAction)onClickModifyPhoto:(id)sender;
- (IBAction)onClickModifyBackground:(id)sender;
- (IBAction)onClickChoiceGrade:(id)sender;

@end
