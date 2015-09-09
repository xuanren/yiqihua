//
//  AEApplyForCertificationTeacherController.h
//  ArtExam
//
//  Created by dkllc on 14-9-21.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "DBNViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface AEApplyForCertificationTeacherController : DBNViewController

@property (nonatomic,strong)  IBOutlet TPKeyboardAvoidingScrollView *sv;

@property (weak, nonatomic) IBOutlet UIView *certificationTeacherView;

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UIView *qqNumView;
@property (weak, nonatomic) IBOutlet UITextField *qqNumTF;

@property (weak, nonatomic) IBOutlet UIView *reasonView;
@property (weak, nonatomic) IBOutlet UITextView *reasonTF;
@end
