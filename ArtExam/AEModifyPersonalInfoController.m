//
//  AEModifyPersonalInfoController.m
//  ArtExam
//
//  Created by dahai on 14-9-23.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEModifyPersonalInfoController.h"
#import "DBNPhotoImport.h"
#import "CVUtils.h"
#import "AESelectGradeController.h"
#import "UIImageView+AFNetworking.h"
#import "DBNStatusView.h"
#import "DBNUserDefaults.h"
#import "AEModifyUserBackgroundController.h"

@interface AEModifyPersonalInfoController ()<DBNPhotoImportDelegate>

@property (nonatomic, strong) DBNPhotoImport *photoImport;
@property (nonatomic) int positionId;

@end

@implementation AEModifyPersonalInfoController

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
    
    self.logoImgView.layer.cornerRadius = self.logoImgView.frame.size.width / 2.0;
    self.logoImgView.layer.masksToBounds = YES;
    
    [self addNavigationRightItem];
    
    [self showUserInfo];
    
    self.positionId = [[[[DBNUser sharedDBNUser] position] objectForKey:@"id"] intValue];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.gradeLabel.text = [[[DBNUser sharedDBNUser] position] objectForKey:@"name"];
}

- (void)showUserInfo{
    
    [self.logoImgView setImageWithURL:[NSURL URLWithString:[[DBNUser sharedDBNUser] avatarUrl]] placeholderImage:nil];
    
    self.nickNameTF.text = [[DBNUser sharedDBNUser] userName];
    
    self.studioTF.text = [[DBNUser sharedDBNUser] studioName];
}

- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 25);
    //[rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(8, 20, 5, -10)];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [rightBtn addTarget:self action:@selector(onClickFinish:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"t_statistics.png"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"t_statistics_dis.png"] forState:UIControlStateHighlighted];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.title = @"修改个人资料";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- IBAction
- (IBAction)onClickModifyPhoto:(id)sender {
    
    if (!self.photoImport) {
        self.photoImport = [[DBNPhotoImport alloc] initWithRootViewController:self];
        self.photoImport.isUserMakeover=NO;
        self.photoImport.allowImportMutipleImgs = NO;
        self.photoImport.delegate = self;
        
    }
    [self.photoImport importPhoto];
}

- (IBAction)onClickModifyBackground:(id)sender {
    
    AEModifyUserBackgroundController *controller = [[AEModifyUserBackgroundController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickChoiceGrade:(id)sender {
    
    AESelectGradeController *controller = [[AESelectGradeController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickFinish:(id)sender{
 
    [self requestSendUserInfo];
}


#pragma mark -- 网络请求
- (void)requestSendUserInfo{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    if (![_nickNameTF.text isEqualToString:[[DBNUser sharedDBNUser] userName]] && ![_nickNameTF.text isEqualToString:@""]) {
        
        [parameters setValue:_nickNameTF.text forKey:@"username"];
    }
    
    /* 暂时没有画室和年级
    if (![_gradeLabel.text isEqualToString:@""] && _positionId != [[[[DBNUser sharedDBNUser] position] objectForKey:@"id"] intValue]) {
        
        [parameters setValue:[[[DBNUser sharedDBNUser] position] objectForKey:@"id"] forKey:@"positionid"];
    }
    
    if (![_studioTF.text isEqualToString:@""] && ![_studioTF.text isEqualToString:[[DBNUser sharedDBNUser] studioName]]) {
        
        [parameters setValue:_studioTF.text forKey:@"studioname"];
    }
    */
    
    //[parameters setObject:@"ios" forKey:@"device"];
    //[parameters setObject:[DBNUserDefaults sharedDBNUserDefaults].appVersion forKey:@"version"];
    if ([DBNUser sharedDBNUser].sessionKey) {
        [parameters setObject:[DBNUser sharedDBNUser].sessionKey forKey:@"sessionid"];
    }
    
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"修改中..."];
    
    AFHTTPRequestOperation *operation  = [[DBNAPIClient sharedClient] postmultipartFormDataPath:[DBNAPIList getUserModifyAPI] parameters:parameters constructingBody:^(id<AFMultipartFormData>formData) {
        if (self.logoImgView.image != nil) {
            NSString *imgName = @"imgurl";
            NSData *photoData = UIImageJPEGRepresentation(self.logoImgView.image, 0.85);
            [formData appendPartWithFileData:photoData
                                        name:@"0"
                                    fileName:imgName
                                    mimeType:@"image/jpeg"];
        }
        
    } needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id JSON) {
        if ([[JSON objectForKey:@"code"] intValue] != 0) {
            //            [[DBNStatusView sharedDBNStatusView] showStatus:[[JSON objectForKey:@"message"] objectForKey:@"msg"] dismissAfter:2.0];
            return ;
        }
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"修改成功" dismissAfter:2.0];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DBN_LOGIN_STATUS_CHANGE object:self];
        NSLog(@"========%@",JSON);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        [[DBNStatusView sharedDBNStatusView] showStatus:@"请检查网络" dismissAfter:2.0];
    }];
    
    [[DBNAPIClient sharedClient] enqueueHTTPRequestOperation:operation];
    [operation start];

}

#pragma mark -- UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

#pragma mark DBNPhotoImportDelegate
- (void)photoImport:(DBNPhotoImport *)import didImportPhoto:(UIImage *)img {
    UIImage *importImg = [CVUtils createLongShareImage:img];
    [self.logoImgView setImage:importImg];
}

- (void)photoImportDidCancel:(DBNPhotoImport *)import {
    
}
@end
