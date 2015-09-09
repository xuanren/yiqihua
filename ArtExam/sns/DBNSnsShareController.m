//
//  DBNSnsShareController.m
//  Dabanniu_Hair
//
//  Created by Cao Jianglong on 11/13/13.
//
//

#import "DBNSnsShareController.h"
#import "MTStatusBarOverlay.h"
#import "sdkCall.h"
#import "DBNUser.h"
#import "TencentOpenAPI/QQApiInterfaceObject.h"
#import "TencentOpenAPI/QQApi.h"
#import "AEAppDelegate.h"
#import "DBNUserDefaults.h"
#import "WXApi.h"

//#if __QQAPI_ENABLE__
#import "TencentOpenAPI/QQApiInterface.h"
//#endif

@interface DBNSnsShareController ()

@end

@implementation DBNSnsShareController
@synthesize isShowing;
@synthesize rootController;
@synthesize shareImg;
@synthesize shareInfo = _shareInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id)initWithRootController:(UIViewController *)vc andShareImg:(UIImage *)img andShareIno:(NSDictionary *)info{
    self = [super init];
    if (self) {
        self.rootController = vc;
        self.shareImg = img;
        self.shareInfo = info;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQDidLogin) name:kLoginSuccessed object:[sdkCall getinstance]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getQQUserInfo:) name:kGetUserInfoResponse object:[sdkCall getinstance]];

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareToWeiboAction:(id)sender{
    AEAppDelegate *appDelegate=(AEAppDelegate*)[UIApplication sharedApplication].delegate;
//    if(![appDelegate checkNetworkConnection]) return;
    if([appDelegate.sinaWeibo isLoggedIn] && ![appDelegate.sinaWeibo isAuthorizeExpired]) {
        [self shareToWeibo];
    }
    else {
        appDelegate.sinaWeibo.delegate = self;
        [appDelegate.sinaWeibo logIn];
    }
}

- (IBAction)shareToQQSpaceAction:(id)sender{
    AEAppDelegate *appDelegate = (AEAppDelegate*)[UIApplication sharedApplication].delegate;
    if (![appDelegate checkNetworkConnection]) {
        return;
    }
    
    if ([[[sdkCall getinstance] oauth] isSessionValid]) {
        [self shareQQAction];
    }else{
        [[[sdkCall getinstance] oauth] authorize:appDelegate._permissions inSafari:NO];
    }
    
}

- (IBAction)shareTOWenxinAction:(id)sender{
    AEAppDelegate *appDelegate = (AEAppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *hairURL = [self.shareInfo objectForKey:@"url"];
    [appDelegate sendWeixinWithWebPage:hairURL andTitle:[self.shareInfo objectForKey:@"title"] image:shareImg scene:WXSceneSession];
}

- (IBAction)shareTOWenxinFriendsAction:(id)sender{
    AEAppDelegate *appDelegate = (AEAppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *hairURL = [self.shareInfo objectForKey:@"url"];
    [appDelegate sendWeixinWithWebPage:hairURL andTitle:[self.shareInfo objectForKey:@"title"] image:shareImg scene:WXSceneTimeline];
}

#pragma mark - Private Methods

- (IBAction)buttonPressed:(UIButton *)button
{
    int index = (int)button.tag;
    switch (index)
    {
        case 0:
        {}
            break;
            
        default:
            break;
    }
}

- (void)onShareNewsLocal
{
    if (self.shareInfo) {
        NSData *previewData = UIImageJPEGRepresentation(self.shareImg,1.0);
        NSString *utf8String = [self.shareInfo objectForKey:@"url"];
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String ? : @""]
                                                            title:[self.shareInfo objectForKey:@"title"] ? : @""
                                                      description:[self.shareInfo objectForKey:@"content"] ? : @""
                                                 previewImageData:previewData];
        //[newsObj setCflag:[self shareControlFlags]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        QQApiSendResultCode sent = 0;
        sent = [QQApiInterface sendReq:req];
    }
}

- (void)getQQUserInfo:(NSNotification *)noti{
    if (noti)
    {
        APIResponse *response = [[noti userInfo] objectForKey:kResponse];
        if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode && [response.jsonResponse objectForKey:@"nickname"])
        {
//            [DBNUserDefaults sharedDBNUserDefaults].qqUserName = [response.jsonResponse objectForKey:@"nickname"];
        }
    }
    
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

- (IBAction)reportAction:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"举报成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)onClickCancel:(id)sender {
    
    [self hideMyShareView];
}


- (void)handleTapGesture:(UITapGestureRecognizer*)sender {
    CGPoint tapPoint = [sender locationInView:_bgView];
    UIView *viewAtBottomOfHeirachy = [_bgView hitTest:tapPoint withEvent:nil];
    if(![viewAtBottomOfHeirachy isKindOfClass:[UIButton class]]) {
        [self hideMyShareView];
    }
}

-(void)QQDidLogin
{
    [self shareQQAction];
    AEAppDelegate *appDelegate=(AEAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate saveTencentQQCredential:[[sdkCall getinstance] oauth]];
//    if (![DBNUser sharedDBNUser].loggedIn) {
//        [[DBNUser sharedDBNUser] loginDBNFromQQ:[[sdkCall getinstance] oauth]];
//    }
    if ([[[sdkCall getinstance] oauth] getUserInfo]) {
        NSLog(@"get qq user info in success");
    }
}

-(void)shareQQAction{
//   if (self.shareInfo) {
//        TCUploadPicDic *params = [TCUploadPicDic dictionary];
//       if (shareImg) {
//           params.paramPicture = shareImg;
//       }
//        // params.paramAlbumid = albumId;
//        params.paramTitle = @"来自 打扮妞";
//        params.paramPhotodesc =[NSString stringWithFormat:@"%@,%@",[self.shareInfo objectForKey:@"content"],[self.shareInfo objectForKey:@"url"]];
//        params.paramMobile = @"1";
//        params.paramNeedfeed = @"1";
//        params.paramX = @"39.909407";
//        params.paramY = @"116.397521";
//        
//        MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
//        overlay.animation = MTStatusBarOverlayAnimationFallDown;  // MTStatusBarOverlayAnimationShrink
//        [overlay postMessage:@"分享中..." duration:100.0 animated:YES];
//        
//        if(![[[sdkCall getinstance] oauth] uploadPicWithParams:params]){
//            //NSLog(@"qq上传图片失败");
//            MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
//            overlay.animation = MTStatusBarOverlayAnimationFallDown;
//            [overlay postImmediateFinishMessage:@"分享失败，请重试" duration:3.0 animated:YES];
//            
//            //[[DBNStatusView sharedDBNStatusView]showStatus:@"分享失败，请重试" dismissAfter:3];
//        }else {
//           // NSLog(@"qq 上传成功");
//            MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
//            overlay.animation = MTStatusBarOverlayAnimationFallDown;
//            [overlay postImmediateFinishMessage:@"分享成功" duration:3.0 animated:YES];
//        }
//    }
    [self onShareNewsLocal];
}


- (void)shareToWeibo {
    NSMutableDictionary *params;
    NSString *actionStr;
    if(self.shareImg) {
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  [NSString stringWithFormat:@"%@,%@",
                   [self.shareInfo objectForKey:@"title"],[self.shareInfo objectForKey:@"url"]], @"status",self.shareImg, @"pic", nil];
        actionStr = @"statuses/upload.json";
    }
    else {
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  [NSString stringWithFormat:@"%@,%@",
                   [self.shareInfo objectForKey:@"title"],[self.shareInfo objectForKey:@"url"]], @"status", nil];
        actionStr = @"statuses/update.json";
    }
    AEAppDelegate *appDelegate=(AEAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.sinaWeibo requestWithURL:actionStr
                                   params:params
                               httpMethod:@"POST"
                                 delegate:self];
    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
    overlay.animation = MTStatusBarOverlayAnimationFallDown;
    [overlay postMessage:@"分享中..." duration:100.0 animated:YES];
}


- (void)showShareMyView {
    if(!_bgView) {
        _bgView = [[UIView alloc] initWithFrame: self.rootController.view.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.opaque = NO;
        _bgView.alpha = 0.5;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        [_bgView addGestureRecognizer:tapGesture];
        [tapGesture release];
    }
    [self.rootController.view addSubview:_bgView];
    
    CGRect shareFrame = self.view.frame;
    shareFrame.origin.y = self.rootController.view.frame.size.height;
    self.view.frame = shareFrame;
    [self.rootController.view addSubview:self.view];
    shareFrame.origin.y = (self.rootController.view.frame.size.height - shareFrame.size.height)/2.0;
    shareFrame.origin.x = (self.rootController.view.frame.size.width - shareFrame.size.
                           width)/2.0;

    [UIView animateWithDuration:0.5
                     animations:^(void){
                         self.view.frame = shareFrame;
                     }
                     completion:^(BOOL finished) {
                         
                     }
     ];
    self.isShowing = YES;
}

- (void)hideMyShareView {
    CGRect shareFrame = self.view.frame;
    shareFrame.origin.y = self.rootController.view.frame.size.height;
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         self.view.frame = shareFrame;
                     }
                     completion:^(BOOL finished) {
                         [_bgView removeFromSuperview];
//                         [self release];
                     }
     ];
    self.isShowing = NO;
}

#pragma mark -
#pragma mark Sina Weibo
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self shareToWeibo];
    AEAppDelegate *appDelegate=(AEAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate saveSinaWeiboCredential];
//    if(![DBNUser sharedDBNUser].loggedIn) {  // 将用户的打扮妞账号和新浪微博关联
//        [[DBNUser sharedDBNUser] loginDBNFromWeibo:appDelegate.sinaWeibo];
//    }
    
    [self getWeiboUserInfo];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    AEAppDelegate *appDelegate=(AEAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate deleteSinaWeiboCredential];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"登录失败"
													   message:@"请重新登录"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSinaWeiboAuthData];
}

#pragma mark -
#pragma mark SinaWeiboRequestDelegate Methods
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
    overlay.animation = MTStatusBarOverlayAnimationFallDown;
    [overlay postImmediateFinishMessage:@"分享成功！" duration:2.0 animated:YES];
    
    if ([result isKindOfClass:[NSDictionary class]] && [result objectForKey:@"screen_name"]) {
//        [DBNUserDefaults sharedDBNUserDefaults].weiboUserName = [result objectForKey:@"screen_name"];
    }
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
    overlay.animation = MTStatusBarOverlayAnimationFallDown;
    [overlay postImmediateFinishMessage:@"分享失败，请稍后重试！" duration:3.0 animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_bgView) {
        [_bgView release];
    }
    [_shareInfo release];
    [shareImg release];
    [super dealloc];
}

@end
