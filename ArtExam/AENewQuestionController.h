//
//  AEMineQuestionController.h
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"
#import "UIPlaceHolderTextView.h"

@class AENewQuestionController;
@protocol AENewQuestionControllerDelegate <NSObject>

@optional
-(void)postInProgress;

@optional
- (void)postDidSuccess:(AENewQuestionController*)controller;

@optional
- (void)postDidFail:(AENewQuestionController*)controller;

@end


@interface AENewQuestionController : DBNViewController

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *questionTextView;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, weak) id <AENewQuestionControllerDelegate>delegate;


@end
