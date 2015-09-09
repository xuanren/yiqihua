//
//  AEMineQuestionController.m
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AENewQuestionController.h"
#import "DBNPhotoImport.h"
#import "CVUtils.h"
#import "DBNImageView.h"
#import "DBNStatusView.h"
#import "DBNUserDefaults.h"
#import "DBNUtils.h"
#import "DBNLoginViewController.h"

@interface AENewQuestionController ()
<
DBNPhotoImportDelegate
>
@property (nonatomic, strong) DBNPhotoImport *photoImport;

@property (nonatomic, weak) IBOutlet DBNImageView *addImg;
@property (weak, nonatomic) IBOutlet UIButton *touchBtn;


@end

@implementation AENewQuestionController

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
    self.title = @"我的问题";
    
    self.questionTextView.placeholder = @"请详细的描述你的问题以便老师更好的帮助你解答";
    
    self.photoImport = [[DBNPhotoImport alloc] initWithRootViewController:self];
    //    photoImport.isUserMakeover=YES;
    self.photoImport.delegate = self;
    
    self.bgView.layer.cornerRadius = 6.0f;
    self.bgView.layer.masksToBounds = YES;
    
    [self addNavigationRightItem];
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
}

- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 23);
    //[rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(8, 20, 5, -10)];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [rightBtn addTarget:self action:@selector(addQuestionAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"question_btn_ok.png"] forState:UIControlStateNormal];

    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}


- (IBAction)addImgAction:(id)sender{
    if (!self.photoImport) {
        self.photoImport = [[DBNPhotoImport alloc] initWithRootViewController:self];
        self.photoImport.isUserMakeover=NO;
        self.photoImport.allowImportMutipleImgs = NO;
        self.photoImport.delegate = self;

    }
    [self.photoImport importPhoto];
}

- (IBAction)addQuestionAction:(id)sender{
    
//    if (![DBNUser sharedDBNUser].loggedIn) {
//        
//        [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能收藏" dismissAfter:3.0];
//        return;
//    }
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    if (self.questionTextView.text != nil) {
        [params setObject:self.questionTextView.text forKey:@"desc"];
    }else{
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"详细描述不能为空！" dismissAfter:3.0f];
        return;
    }
    
    if (self.addImg.image == nil) {
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"图片不能为空！" dismissAfter:3.0f];
        return;
    }
    
    [params setObject:@"ios" forKey:@"device"];
    [params setObject:[DBNUserDefaults sharedDBNUserDefaults].appVersion forKey:@"version"];
    if ([DBNUser sharedDBNUser].sessionKey) {
        [params setObject:[DBNUser sharedDBNUser].sessionKey forKey:@"session"];
    }
    
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"发送中..."];

    AFHTTPRequestOperation *operation  = [[DBNAPIClient sharedClient] postmultipartFormDataPath:[DBNAPIList addNewQuestion] parameters:params constructingBody:^(id<AFMultipartFormData>formData) {
        if (self.addImg.image != nil) {
            NSString *imgName = @"imgurl";
            NSData *photoData = UIImageJPEGRepresentation(self.addImg.image, 0.85);
            [formData appendPartWithFileData:photoData
                                        name:@"0"
                                    fileName:imgName
                                    mimeType:@"image/jpeg"];
        }
        
    } needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id JSON) {
        if ([[JSON objectForKey:@"code"] intValue] != 0) {

            if ([[JSON objectForKey:@"code"] intValue] == 22){
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能提问" dismissAfter:3.0];
            }
            return ;
        }
        [[DBNStatusView sharedDBNStatusView] showStatus:@"发送成功" dismissAfter:2.0];
        if (self.delegate) {
            [self.delegate postDidSuccess:self];
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        [[DBNStatusView sharedDBNStatusView] dismiss];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [[DBNStatusView sharedDBNStatusView] showStatus:@"请检查网络" dismissAfter:2.0];
    }];
    
    [[DBNAPIClient sharedClient] enqueueHTTPRequestOperation:operation];
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_questionTextView resignFirstResponder];
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    _hintLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([textView.text length] > 0 && ![textView.text isEqualToString:@""]) {
        
        
    }else{
        
        _hintLabel.hidden = NO;
    }
}

#pragma mark -
#pragma mark DBNPhotoImportDelegate
- (void)photoImport:(DBNPhotoImport *)import didImportPhoto:(UIImage *)img {
    UIImage *importImg = [CVUtils createLongShareImage:img];
    [self.addImg setImage:importImg];
    [self.touchBtn setImage:nil forState:UIControlStateNormal];
}

- (void)photoImportDidCancel:(DBNPhotoImport *)import {
    
}

@end
