//
//  AETeacherAnswerController.h
//  ArtExam
//
//  Created by dahai on 14-9-17.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"
#import "UIPlaceHolderTextView.h"

@interface AETeacherAnswerController : DBNViewController

@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *contentView;

@property (weak, nonatomic) IBOutlet UIView *scoreView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property (weak, nonatomic) IBOutlet UIView *choiceScoreView;

- (id)initWithQuestionId:(int)questionId;
- (IBAction)onClickScore:(id)sender;
- (IBAction)onClickCancle:(id)sender;
- (IBAction)onClickConfirm:(id)sender;

@end
