//
//  AEFeedbackController.m
//  ArtExam
//
//  Created by dahai on 14-9-12.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEFeedbackController.h"
#import "DBNAPIClient.h"
#import "DBNUtils.h"
#import "DBNStatusView.h"

@interface AEFeedbackController ()

@property (nonatomic,retain) NSString *hintStr;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneEmailTF;


@end

@implementation AEFeedbackController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    [self addNavigationRightItem];
    self.hintStr = _hintLabel.text;
    
    [self.finalBtn setBackgroundImage:[UIImage imageNamed:@"btn_dis.png"] forState:UIControlStateHighlighted];
    [self setViewStyle:_bView];
    [self setViewStyle:_phoneView];
    // Do any additional setup after loading the view from its nib.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
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

//添加发送按钮
- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 23);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [rightBtn setTitle:@"发 送" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(onClickSend:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[DBNUtils getColor:@"40c157"] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)setViewStyle:(UIView *)view
{
    view.layer.cornerRadius = 6;//设置那个圆角的有多圆
    view.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
    view.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
    view.layer.masksToBounds = YES;
}

- (IBAction)onClickSend:(UIButton *)sender
{
    
    if (_ideaTextView.text.length > 0) {
        
        
        [self sendIdeaRequest];
    }else{
        
        //        [[SYDLPromptView sharedInstance] showViewPrompt:@"内容不能为空！" animationDuration:PromptViewTime];
    }
    
    
}

- (IBAction)onClickClearKeyboard:(id)sender {
    
    [self.ideaTextView resignFirstResponder];
    [self.phoneEmailTF resignFirstResponder];
    
    NSString *nsTextContent = _ideaTextView.text;
    int existTextNum = [nsTextContent length];
    self.textPromptLabel.text = [NSString stringWithFormat:@"%d/%d",existTextNum,350];
}


#pragma mark -- 网络请求
- (void)sendIdeaRequest
{
    
    NSMutableDictionary *paramets = [NSMutableDictionary dictionary];
    
    if (![_ideaTextView.text isEqualToString:@""] && _ideaTextView != nil) {
        
        [paramets setValue:_ideaTextView.text forKey:@"feedback"];
    }
    
    
    if (![_phoneEmailTF.text isEqualToString:@""] && _phoneEmailTF != nil) {
        [paramets setValue:_phoneEmailTF.text forKeyPath:@"contact"];
    }
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getUserFeedbackAPI] parameters:paramets needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id json) {
        
        if ([[json objectForKey:@"status"] intValue] == 0) {
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"发送成功" dismissAfter:2.f];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
//            NSString *err = [[json objectForKey:@"data"] objectForKey:@"errlog"];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];
}

#pragma mark -- UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.hintLabel.text = @"";
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text length] == 0) {
        
        self.hintLabel.text = _hintStr;
    }
    
    NSString *nsTextContent = textView.text;
    int existTextNum = [nsTextContent length];
    self.textPromptLabel.text = [NSString stringWithFormat:@"%d/%d",existTextNum,350];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    int remainTextNum = 350;
    if (range.location >= 350) {
        
        self.textPromptLabel.text = [NSString stringWithFormat:@"%d/%d",remainTextNum,350];
        return NO;
    }else{
        
        NSString *nsTextContent = textView.text;
        int existTextNum = [nsTextContent length];
        remainTextNum = 350 - existTextNum;
        self.textPromptLabel.text = [NSString stringWithFormat:@"%d/%d",existTextNum,350];
        
        return YES;
    }
    
    return YES;
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
