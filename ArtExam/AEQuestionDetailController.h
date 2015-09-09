//
//  AEQuestionDetailController.h
//  ArtExam
//
//  Created by dahai on 14-9-10.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"

@interface AEQuestionDetailController : DBNViewController

@property (weak, nonatomic) IBOutlet UIView *answerView;

- (instancetype)initWithQuestionId:(int)qId;

- (IBAction)onClickAnswer:(UIButton *)sender;

@end
