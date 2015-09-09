//
//  DBNLoginViewController.h
//  DBNWrongBook
//
//  Created by dahai on 14-5-10.
//  Copyright (c) 2014年 admin. All rights reserved.
//

/************************************
        登录页
 **********************************/

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import <TencentOpenAPI/TencentOAuth.h>


@interface DBNLoginViewController : UIViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate>{
    BOOL isOpened;
}

@property (weak, nonatomic) IBOutlet UIView *userPasswordView;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UIView *userNameView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIView *passwordView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

//@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;


- (IBAction)onClickCancelKeyboard:(id)sender;
- (IBAction)onClickLogin:(id)sender;
- (IBAction)onClickRegister:(id)sender;
- (IBAction)onClickQQLogin:(id)sender;
- (IBAction)onClickWeiboLogin:(id)sender;
- (IBAction)onClickCloseLogin:(id)sender;


@end
