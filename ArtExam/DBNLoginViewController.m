//
//  DBNLoginViewController.m
//  DBNWrongBook
//
//  Created by dahai on 14-5-10.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "DBNLoginViewController.h"
#import "AEAppDelegate.h"
#import "NSString+MD5.h"
#import "DBNAPIClient.h"
#import "DBNUser.h"
#import "DBNStatusView.h"
#import "DBNEQRegisterController.h"
#import <QuartzCore/QuartzCore.h>
#import "DBNAPIList.h"
#import "DBNUser.h"
#import "sdkCall.h"

#import "DBNViewController.h"

#define BorderBgColor [UIColor colorWithRed:190.0/255.0 green:189.0/255.0 blue:189.0/255.0 alpha:1]

@interface DBNLoginViewController ()<UITextFieldDelegate>
{
    BOOL _isOpenKeyboard;
    CGFloat _viewY;
    BOOL _isPhoneNumber;     //是否是手机号

}

@end

@implementation DBNLoginViewController

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

    [self setSubViewsStyle];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _viewY = _userPasswordView.frame.origin.y;
    [self.passwordTextField.text md5];
    
    self.title = @"账号登录";
    
    // add login notification handler
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logInStatusChange:) name:DBN_LOGIN_STATUS_CHANGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logInFail:) name:DBN_LOGIN_FAIL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQDidLogin) name:kLoginSuccessed object:[sdkCall getinstance]];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getQQUserInfo:) name:kGetUserInfoResponse object:[sdkCall getinstance]];

//    CGRect rect = [[UIScreen mainScreen] bounds];
//    if (rect.size.height == 480) {
//        
//        [self.bgImgView setImage:[UIImage imageNamed:@"login_background960.jpg"]];
//    }
    
    UIBarButtonItem *leftItem = [DBNViewController barButtonItemWithTitle:@"取消" target:self action:@selector(onClickCloseLogin:)];
    UIBarButtonItem *rightItem = [DBNViewController barButtonItemWithTitle:@"注册" target:self action:@selector(onClickRegister:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSubViewsStyle
{
    //圆角
//    [self setViewBorder:_userNameView color:BorderBgColor borderWidth:0];
//    [self setViewBorder:_passwordView color:BorderBgColor borderWidth:0];
    [self setViewBorder:_loginBtn color:nil borderWidth:0];
}


- (void)logInFail:(NSNotification*)notification {
    [[DBNStatusView sharedDBNStatusView] showStatus:[notification.userInfo objectForKey:@"errorString" ] dismissAfter:2];
//    if(self.delegate && [self.delegate respondsToSelector:@selector(loginControllerFailLogin:)]) {
//        [self.delegate performSelector:@selector(loginControllerFailLogin:)];
//    }
}

- (void)logInStatusChange:(NSNotification*)notification {
    if([DBNUser sharedDBNUser].loggedIn) {
        [[DBNStatusView sharedDBNStatusView] showStatus:@"登录成功" dismissAfter:1];
        //        if ([DBNUser sharedDBNUser].role == DBNBarber && [DBNUser sharedDBNUser].longInNum <=1) {
        //            NSMutableDictionary *barberDic = [NSMutableDictionary dictionaryWithCapacity:10];
        //            if([DBNUser sharedDBNUser].avatarURL) [barberDic setObject:[DBNUser sharedDBNUser].avatarURL forKey:@"avatarURL"];
        //            if([DBNUser sharedDBNUser].userName) [barberDic setObject:[DBNUser sharedDBNUser].userName forKey:@"userName"];
        //            if([DBNUser sharedDBNUser].additionalInfo) [barberDic setObject:[DBNUser sharedDBNUser].additionalInfo forKey:@"additionalInfo"];
        //            [barberDic setObject:[NSNumber numberWithInt:[DBNUser sharedDBNUser].followerNum] forKey:@"followerNum"];
        //            [barberDic setObject:[NSNumber numberWithInt:[DBNUser sharedDBNUser].uID] forKey:@"uID"];
        //           // self.barberInfo = barberDic;
        //            DBNBarberProfileController *controller = [[DBNBarberProfileController alloc]initWithBarberInfo:barberDic];
        //            controller.delegate = self;
        //            [self.navigationController pushViewController:controller animated:YES];
        //            [controller release];
        //        }else{
        //            NSLog(@"delegate:%@",self.delegate);
//        [self.delegate loginControllerDidLogin:self];
        [self dismissViewControllerAnimated:NO completion:nil];
        //  }
        return;
    }
//    if(self.delegate && [self.delegate respondsToSelector:@selector(loginControllerFailLogin:)]) {
//        [self.delegate performSelector:@selector(loginControllerFailLogin:)];
//    }
}


//设置圆角
- (void)setViewBorder:(UIView *)view color:(UIColor *)vColor borderWidth:(float)width
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 20.0;
    view.layer.borderWidth = width;
    view.layer.borderColor = [vColor CGColor];//设置列表边框
}

- (void)writeToUserName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithDictionary:[defaults objectForKey:@"username"]];
    
    [userDic setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:_userNameTextField.text];
    
    [defaults setObject:userDic forKey:@"username"];
    
    [defaults synchronize];
}

- (NSArray *)getUserName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithDictionary:[defaults objectForKey:@"username"]];
    NSArray *userList = [userDic allKeys];
    return userList;
}

- (void)changeUserPasswordViewFrame
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    if (size.height == 480.0) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            if (_isOpenKeyboard) {
                
                self.userPasswordView.frame = CGRectMake(_userPasswordView.frame.origin.x, _viewY - 100, _userPasswordView.frame.size.width, _userPasswordView.frame.size.height);
            }else{
                
                self.userPasswordView.frame = CGRectMake(_userPasswordView.frame.origin.x, _viewY, _userPasswordView.frame.size.width, _userPasswordView.frame.size.height);
            }
            
        }];
    }
}

//判断手机号格式
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)cancelKeyboard
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    _isOpenKeyboard = NO;
    [self changeUserPasswordViewFrame];
}

- (IBAction)onClickCancelKeyboard:(id)sender {
    
    [self cancelKeyboard];
}

- (IBAction)onClickLogin:(id)sender {


    [MobClick event:@"yqh048"];
    NSMutableString *tmpUserName = [[NSMutableString alloc]initWithFormat:@"%@",self.userNameTextField.text];
    
    
    if ([tmpUserName rangeOfString:@" "].location != NSNotFound) {
        [[DBNStatusView sharedDBNStatusView] showStatus:@"用户名或密码错误" dismissAfter:3.0];
        return;
    }
    
    
    tmpUserName = [[NSMutableString alloc]initWithFormat:@"%@",self.passwordTextField.text];
    self.passwordTextField.text = [tmpUserName stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([tmpUserName rangeOfString:@" "].location != NSNotFound) {
        [[DBNStatusView sharedDBNStatusView] showStatus:@"用户名或密码错误" dismissAfter:3.0];
        return;
    }

    
    [self writeToUserName];
    
    
    BOOL isValid = self.userNameTextField.text == nil || self.passwordTextField.text == nil || [self.userNameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""];
    if (isValid) {
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"用户名或密码不能为空" dismissAfter:3.0];
        return;
    }
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:3];
    [parameters setValue:_userNameTextField.text forKey:@"username"];
    [parameters setValue:_passwordTextField.text forKey:@"password"];
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getLoginAPI] parameters:parameters needIdInfo:NO success:^(AFHTTPRequestOperation *opertion, id json) {
        
        if ([[json objectForKey:@"code"] intValue] == 1) {
            //成功
            [[DBNUser sharedDBNUser] initUser:[json objectForKey:@"uinfo"] withSessionId:[json objectForKey:@"sessionid"]];
            
        }else if ([[json objectForKey:@"code"] intValue] == 0){
            //失败
        }
        NSString *error = [json objectForKey:@"error"];
        [[DBNStatusView sharedDBNStatusView] showStatus:error dismissAfter:3.0];

    } failure:^(AFHTTPRequestOperation *opertion, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];

}


- (IBAction)onClickRegister:(id)sender {
    
    [MobClick event:@"yqh051"];
    DBNEQRegisterController *controller = [[DBNEQRegisterController alloc]init];

    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickQQLogin:(id)sender {
    
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:3];
//    [parameters setValue:_userNameTextField.text forKey:@"qq"];
//    [parameters setValue:_passwordTextField.text forKey:@"photo"];
//    
//    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getLoginAPI] parameters:parameters needIdInfo:NO success:^(AFHTTPRequestOperation *opertion, id json) {
//        
//    } failure:^(AFHTTPRequestOperation *opertion, NSError *error) {
//        
//    }];
    
    [MobClick event:@"yqh049"];
    
    AEAppDelegate *appDelegate = (AEAppDelegate*)[UIApplication sharedApplication].delegate;
    if (![appDelegate checkNetworkConnection]) {
       // return;
    }
    
    //    if ([[[sdkCall getinstance] oauth] isSessionValid]) {
    //        [[DBNUser sharedDBNUser] loginDBNFromQQ:[[sdkCall getinstance] oauth]];
    //        [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"登录中"];
    //    }else{
    [[[sdkCall getinstance] oauth] authorize:appDelegate._permissions];
    //  }
}

- (IBAction)onClickWeiboLogin:(id)sender {
    
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:3];
//    [parameters setValue:_userNameTextField.text forKey:@"uid"];
//    [parameters setValue:_passwordTextField.text forKey:@"photo"];
//    
//    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getLoginAPI] parameters:parameters needIdInfo:NO success:^(AFHTTPRequestOperation *opertion, id json) {
//        
//    } failure:^(AFHTTPRequestOperation *opertion, NSError *error) {
//        
//    }];
    
    [MobClick event:@"yqh050"];
    
    AEAppDelegate *appDelegate = (AEAppDelegate*)[UIApplication sharedApplication].delegate;
    if (![appDelegate checkNetworkConnection]) {
        //return;
    }
    [appDelegate.sinaWeibo logOut];
    [appDelegate deleteSinaWeiboCredential];
    appDelegate.sinaWeibo.delegate = nil;
    
    appDelegate.sinaWeibo.delegate = self;
    [appDelegate.sinaWeibo logIn];
}

- (IBAction)onClickCloseLogin:(id)sender {
    
    [MobClick event:@"yqh052"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _isOpenKeyboard = YES;
    [self changeUserPasswordViewFrame];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    if ([_userNameTextField isEqual:textField]) {
//        
//        if (![self isMobileNumber:_userNameTextField.text]) {
//            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"手机号格式错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//            _isPhoneNumber = NO;
//        }else{
//            
//            _isPhoneNumber = YES;
//        }
//            
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:_userNameTextField]) {
    
        [_passwordTextField becomeFirstResponder];
        
    }else if ([textField isEqual:_passwordTextField]){
        
        [self cancelKeyboard];
    }
    return YES;
}

#pragma mark - SinaWeiboDelegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    AEAppDelegate *appDelegate=(AEAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate saveSinaWeiboCredential];
    [[DBNUser sharedDBNUser] loginDBNFromWeibo:sinaweibo];
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"登录中"];
    [self getWeiboUserInfo];
}

- (void)getWeiboUserInfo{
    AEAppDelegate *appDelegate=(AEAppDelegate*)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setObject:appDelegate.sinaWeibo.userID forKey:@"uid"];
    [params setObject:appDelegate.sinaWeibo.accessToken forKey:@"access_token"];
    [appDelegate.sinaWeibo requestWithURL:@"users/show.json"
                                   params:params
                               httpMethod:@"GET"
                                 delegate:self];
}


- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"登录失败"
													   message:@"请重新登录"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSinaWeiboAuthData];
}

#pragma mark - QQ SesionDelegate

-(void)QQDidLogin
{
    AEAppDelegate *appDelegate=(AEAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate saveTencentQQCredential:[[sdkCall getinstance] oauth]];
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"登录中"];
    [[DBNUser sharedDBNUser] loginDBNFromQQ:[[sdkCall getinstance] oauth]];
    
    if ([[[sdkCall getinstance] oauth] getUserInfo]) {
        NSLog(@"get qq user info in success");
    }
}

@end
