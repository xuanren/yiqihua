//
//  AETeacherAnswerController.m
//  ArtExam
//
//  Created by dahai on 14-9-17.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AETeacherAnswerController.h"
#import "DBNStatusView.h"
#import "DBNUtils.h"
#import "DBNLoginViewController.h"

@interface AETeacherAnswerController ()

@property (nonatomic, strong) NSString *scoreStr;
@property (nonatomic) int questionId;

@end

@implementation AETeacherAnswerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithQuestionId:(int)questionId{
    
    self = [super init];
    if (self) {
        
        self.questionId = questionId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"评论";
    
    CGRect tmpRect = self.pickView.frame;
    tmpRect.size.height = 200;
    self.pickView.frame = tmpRect;
    
    self.contentView.placeholder = @"评论...";
    self.contentView.font = [UIFont systemFontOfSize:13.f];
    
    self.textView.layer.cornerRadius = 4.0f;
    self.textView.layer.masksToBounds = YES;
    
    self.scoreView.layer.cornerRadius = 4.0f;
    self.scoreView.layer.masksToBounds = YES;
    
    [self addNavigationRightItem];
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.contentView resignFirstResponder];
    self.choiceScoreView.alpha = 0;
}

- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 23);
    //[rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(8, 20, 5, -10)];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [rightBtn addTarget:self action:@selector(onClickSend:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"t_statistics.png"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"t_statistics_dis.png"] forState:UIControlStateHighlighted];
    [rightBtn setTitle:@"发 送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[DBNUtils getColor:@"40BF57"] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (IBAction)onClickSend:(id)sender{
    
    [self requsetSendComment];
}

#pragma mark -- 网络请求
- (void)requsetSendComment{
    
//    if (![DBNUser sharedDBNUser].loggedIn) {
//        
//        [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能评论" dismissAfter:3.0];
//        return;
//    }
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }

    
    NSMutableDictionary *parament = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    if (_scoreLabel.text != nil && ![_scoreLabel.text isEqualToString:@""]) {
        
        [parament setValue:_scoreLabel.text forKey:@"score"];
    }
    
    if (_contentView.text != nil && ![_contentView.text isEqualToString:@""]) {
        
        [parament setValue:_contentView.text forKey:@"remark"];
    }
    
    [parament setValue:[NSNumber numberWithInt:_questionId] forKey:@"qid"];
    
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"评分中..."];
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getCommentAPI] parameters:parament needIdInfo:NO success:^(AFHTTPRequestOperation *opertion, id json) {
        
        if ([[json objectForKey:@"code"] intValue] == 0) {
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"发送成功！" dismissAfter:3.f];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else if([[json objectForKey:@"code"] intValue] == 301){
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"没有老师权限" dismissAfter:3.f];
        }
        
        
    } failure:^(AFHTTPRequestOperation *opertion, NSError *error) {
        
        NSLog(@"error == %@",error);
        [[DBNStatusView sharedDBNStatusView] dismiss];
    }];
}

#pragma mark -- UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 101;
}

#pragma mark -- UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"%d",row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.scoreStr = [NSString stringWithFormat:@"%d",row];
}

#pragma mark -- IBAction
- (IBAction)onClickScore:(id)sender {
    
    [self.contentView resignFirstResponder];
    self.choiceScoreView.alpha = 1;
}

- (IBAction)onClickCancle:(id)sender {
    
    self.choiceScoreView.alpha = 0;
}

- (IBAction)onClickConfirm:(id)sender {
    
    self.scoreLabel.text = _scoreStr;
    self.choiceScoreView.alpha = 0;
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    self.choiceScoreView.alpha = 0;
}
@end
