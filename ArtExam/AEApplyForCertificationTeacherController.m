//
//  AEApplyForCertificationTeacherController.m
//  ArtExam
//
//  Created by dkllc on 14-9-21.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEApplyForCertificationTeacherController.h"
#import "DBNUtils.h"
#import "DBNStatusView.h"
#import "DBNLoginViewController.h"

@interface AEApplyForCertificationTeacherController ()

@end

@implementation AEApplyForCertificationTeacherController

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
    
    CGRect contentRect = CGRectZero;
    for ( UIView *subview in self.sv.subviews ) {
        contentRect = CGRectUnion(contentRect, subview.frame);
    }
    self.sv.contentSize = CGSizeMake(self.sv.bounds.size.width, CGRectGetMaxY(contentRect));
    
    [self layoutSubView];
    
    [self addNavigationRightItem];
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    self.navigationItem.title = @"申请认证老师";
    [super setCustomBackButton];
}
- (void)layoutSubView{
    
    float cornerRadius = 4.0f;
    self.certificationTeacherView.layer.cornerRadius = cornerRadius;
    self.nameView.layer.cornerRadius = cornerRadius;
    self.phoneView.layer.cornerRadius = cornerRadius;
    self.qqNumView.layer.cornerRadius = cornerRadius;
    self.reasonView.layer.cornerRadius = cornerRadius;
}

- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 23);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [rightBtn addTarget:self action:@selector(onClickConfirm:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_askquestion_ok_def.png"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickConfirm:(id)sender{
    
    [self requestSendInfo];
    
}

#pragma mark -- 网络请求
- (void)requestSendInfo{
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }
    
    NSMutableDictionary *paramters = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    if (self.nameTF.text != nil) {
        
        [paramters setObject:self.nameTF.text forKey:@"name"];
    }
    
    if (self.phoneTF.text != nil && [DBNUtils isValidCellPhone:_phoneTF.text]) {
        
        [paramters setObject:self.phoneTF.text forKey:@"tel"];
    }else{
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"手机号格式有误！" dismissAfter:3.0];
        return;
    }
    
    if (self.qqNumTF.text != nil) {
        
        [paramters setObject:self.qqNumTF.text forKey:@"qq"];
    }else{
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"qq号不能为空！" dismissAfter:3.0];
        return;
    }
    
    if (self.reasonTF.text != nil) {
        
        [paramters setObject:self.reasonTF.text forKey:@"about"];
        
    }else{
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"申请理由不能为空！" dismissAfter:3.0];
        return;
    }
    
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"申请中..."];

    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getVerfifyAPI] parameters:paramters needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id json) {
        
        if ([json objectForKey:@"code"] == 0) {
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"申请成功等待审核！" dismissAfter:3.0];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([[json objectForKey:@"code"] intValue] == 22){
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能申请认证老师" dismissAfter:3.0];
        }else if ([[json objectForKey:@"code"] intValue] == 121){
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"已提交认证申请" dismissAfter:3.0];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        [[DBNStatusView sharedDBNStatusView] dismiss];
        
    }];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
@end
