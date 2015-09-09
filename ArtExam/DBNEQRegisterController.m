//
//  DBNRegisterController.m
//  Dabanniu_Hair
//
//  Created by admin on 14-5-20.
//
//

#import "DBNEQRegisterController.h"
#import "DBNAPIClient.h"
#import "DBNStatusView.h"
#import "DBNUtils.h"
#import "DBNAPIList.h"
#import "DBNPhotoImport.h"
#import "CVUtils.h"

@interface DBNEQRegisterController ()<DBNPhotoImportDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraintVH;
@property (nonatomic, strong) DBNPhotoImport *photoImport;
@end

@implementation DBNEQRegisterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initNavItem{
    [super initNavItem];
    return;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //scrollview的contentSize
    _constraintVH.constant = [UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.navigationController.navigationBar.bounds.size.height;
    self.navigationItem.title = @"账号注册";
    
    _isCancelClause = YES;
    
    [self setViewBorder:_pwNickView color:nil borderWidth:0];
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius  = 20.f;
    
    _thumBtn.layer.masksToBounds = YES;
    _thumBtn.layer.cornerRadius  = 43.f;
    [super setCustomBackButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置圆角
- (void)setViewBorder:(UIView *)view color:(UIColor *)vColor borderWidth:(float)width
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 6.0;
    view.layer.borderWidth = width;
    view.layer.borderColor = [vColor CGColor];//设置列表边框
}

//判断邮箱格式是否正确
- (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = nil;
    NSPredicate *emailTest = nil;
    
    emailRegex = @"[A-Z0-9a-z._%+-]{3,15}+@[qq|163|sina|Yahoo|sohu|gmail|126|china]+\\.[A-Za-z]{2,4}";
    emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

#pragma mark -IBAction methords

-(void)back
{
    [MobClick event:@"yqh054"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickCancelClause:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    if (_isCancelClause) {
        
        _isCancelClause = NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"check_no_btn.png"] forState:UIControlStateNormal];
        [self.submitBtn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.submitBtn setBackgroundColor:[DBNUtils getColor:@"b4b4b4"]];
        self.submitBtn.userInteractionEnabled = NO;
        [self setViewBorder:_submitBtn color:nil borderWidth:0];
    }else{
        
        _isCancelClause = YES;
        [btn setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
        [self.submitBtn setBackgroundImage:[UIImage imageNamed:@"sure-btn-img.png"] forState:UIControlStateNormal];
        self.submitBtn.userInteractionEnabled = YES;
        [self setViewBorder:_submitBtn color:nil borderWidth:0];
    }
    
}


- (IBAction)registerAction:(id)sender{
    //http://115.28.86.115/glwz/user/userKstkReg
//    1、username  用户名
//    2、password  密码，没有加密
//    3、email      电子邮箱
//    4、phone     移动电话    
    
    [MobClick event:@"yqh053"];
    
    NSMutableDictionary *parames = [NSMutableDictionary  dictionaryWithCapacity:3];

    if (self.nickNameTF.text != nil && ![self.nickNameTF.text isEqualToString:@""]) {
        
        [parames setObject:self.nickNameTF.text forKey:@"username"];
    }else{
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"昵称不能为空！" dismissAfter:3.0];
        return;
    }
    
    if (self.pwdTF.text != nil && ![self.pwdTF.text isEqualToString:@""]) {
        
        [parames setObject:self.pwdTF.text forKey:@"password"];
    }else{
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"密码不能为空！" dismissAfter:3.0];
        return;
    }
    
    if (self.pwdTF.text.length < 6) {
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"密码长度不够，应输入6~16字符" dismissAfter:3.0];
        return;
    }
    

    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getRegisAPI] parameters:parames needIdInfo:NO success:^(AFHTTPRequestOperation *opertion, id json) {
        
        NSLog(@"json ==== %@",json);
        
        if ([[json objectForKey:@"code"] intValue] == 0) {
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"注册成功" dismissAfter:3.0f];
            
            [self back];
        }else{
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *opertion, NSError *error) {
       
        
        NSLog(@"error === %@",error);
    }];

}

//选取头像

- (IBAction)thumBtnClick:(id)sender {
    if (!self.photoImport) {
        self.photoImport = [[DBNPhotoImport alloc] initWithRootViewController:self];
        self.photoImport.isUserMakeover=NO;
        self.photoImport.allowImportMutipleImgs = NO;
        self.photoImport.delegate = self;
        
    }
    [self.photoImport importPhoto];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    [self close:nil];
    
    return YES;
}

#pragma mark DBNPhotoImportDelegate

- (void)photoImport:(DBNPhotoImport *)import didImportPhoto:(UIImage *)img {
    UIImage *importImg = [CVUtils createLongShareImage:img];
    [_thumBtn setBackgroundImage:importImg forState:UIControlStateNormal];
}

- (void)photoImportDidCancel:(DBNPhotoImport *)import {
    
}

@end
