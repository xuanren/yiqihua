//
//  AEFeedbackController.h
//  ArtExam
//
//  Created by dahai on 14-9-12.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"

@interface AEFeedbackController : DBNViewController

@property (weak, nonatomic) IBOutlet UITextView *ideaTextView;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UIView *bView;

@property (weak, nonatomic) IBOutlet UIButton *finalBtn;

@property (weak, nonatomic) IBOutlet UILabel *textPromptLabel;

- (IBAction)onClickClearKeyboard:(id)sender;

@end
