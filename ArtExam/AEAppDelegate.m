//
//  AEAppDelegate.m
//  ArtExam
//
//  Created by dkllc on 14-9-2.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AEAppDelegate.h"
#import "MMDrawerVisualState.h"
#import "DBNStatusView.h"
#import "DBNUtils.h"
#import "MobClick.h"
//#import "APService.h"
#import "CVUtils.h"
#import "MTStatusBarOverlay.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "SinaWeibo.h"

@implementation AEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    _tabBarController = [[UITabBarController alloc] init];
    
    UIEdgeInsets imageEdgeInset = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    
    _homePageControlelr = [[AEHomePageController alloc]init];
    _homePageNavController = [[UINavigationController alloc]initWithRootViewController:_homePageControlelr];
    _homePageNavController.tabBarItem.imageInsets = imageEdgeInset;
//    [_homePageNavController.tabBarItem setTitle:@"首页"];
    [_homePageNavController.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"tab-home-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                    withFinishedUnselectedImage:[[UIImage imageNamed:@"tab-home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //院校
     _colleageController = [[AEColleageViewController alloc]init];
    _findNavController = [[UINavigationController alloc]initWithRootViewController:_colleageController];
    _findNavController.tabBarItem.imageInsets = imageEdgeInset;
//    [_findNavController.tabBarItem setTitle:@"发现"];
    [_findNavController.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"tab-find-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                    withFinishedUnselectedImage:[[UIImage imageNamed:@"tab-find"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //图库
    _topicListControlelr = [[AETopicListController alloc]init];
    _topicListNavController = [[UINavigationController alloc]initWithRootViewController:_topicListControlelr];
    _topicListNavController.tabBarItem.imageInsets = imageEdgeInset;
    //    [_topicListNavController.tabBarItem setTitle:@"圈子"];
    [_topicListNavController.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"tab-circle-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                     withFinishedUnselectedImage:[[UIImage imageNamed:@"tab-circle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    _userCenterControlelr = [[AEUserCenterController alloc]init];
    _userCenterNavController = [[UINavigationController alloc]initWithRootViewController:_userCenterControlelr];
    _userCenterNavController.tabBarItem.imageInsets = imageEdgeInset;
//    [_userCenterNavController.tabBarItem setTitle:@"个人"];
    [_userCenterNavController.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"tab-user-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                    withFinishedUnselectedImage:[[UIImage imageNamed:@"tab-user"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //要删掉的
    /*
    _qAnswerControlelr = [[AEQuestionAnswerController alloc]init];
    _qAnswerNavController = [[UINavigationController alloc]initWithRootViewController:_qAnswerControlelr];
    _qAnswerNavController.tabBarItem.imageInsets = imageEdgeInset;
    [_qAnswerNavController.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"tab-comment-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                   withFinishedUnselectedImage:[[UIImage imageNamed:@"tab-comment"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    */
    AEArtStudioController *artStudioController = [[AEArtStudioController alloc]init];
    
    //测试
    AEArtStudioDetailEViewController *test = [[AEArtStudioDetailEViewController alloc]init];
    
    UINavigationController *artStudioNavController = [[UINavigationController alloc]initWithRootViewController:artStudioController];
    artStudioNavController.tabBarItem.imageInsets = imageEdgeInset;
    
    [artStudioNavController.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"tab-studio-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                      withFinishedUnselectedImage:[[UIImage imageNamed:@"tab-studio"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    _tabBarController.viewControllers = [NSArray arrayWithObjects:_homePageNavController,
                                         _findNavController,
                                         _topicListNavController,
                                          artStudioNavController,
                                         _userCenterNavController,
                                         
                                         
                                         nil];//_qAnswerNavController,
    _tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    
    _circlesController = [[AECirclesController alloc]init];
    _circlesNavController = [[UINavigationController alloc]initWithRootViewController:_circlesController];
    
    /*
    _drawerController = [[SUNViewController alloc]
                         initWithCenterViewController:self.tabBarController
                         leftDrawerViewController:nil
                         rightDrawerViewController:_circlesNavController];
    
    [_drawerController setMaximumLeftDrawerWidth:200];
    [_drawerController setMaximumRightDrawerWidth:240];
    [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [_drawerController setShouldStretchDrawer:NO];
    [_drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
        block(drawerController, drawerSide, percentVisible);
    }];
    */
    _rootNavController = [[UINavigationController alloc]initWithRootViewController:_tabBarController];
    self.rootNavController.navigationBarHidden = YES;

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.rootNavController;
    [self.window makeKeyAndVisible];
    [self setDBNNavigationStyle];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    __block AEAppDelegate *blockSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //友盟统计
        [MobClick startWithAppkey:@"54d02b15fd98c54f53000308" reportPolicy:SEND_ON_EXIT channelId:@""];
        //qq授权
        blockSelf._permissions = [NSArray arrayWithObjects:
                             kOPEN_PERMISSION_GET_USER_INFO,
                             kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                             kOPEN_PERMISSION_ADD_ALBUM,
                             kOPEN_PERMISSION_ADD_IDOL,
                             kOPEN_PERMISSION_ADD_ONE_BLOG,
                             kOPEN_PERMISSION_ADD_PIC_T,
                             kOPEN_PERMISSION_ADD_SHARE,
                             kOPEN_PERMISSION_ADD_TOPIC,
                             kOPEN_PERMISSION_CHECK_PAGE_FANS,
                             kOPEN_PERMISSION_DEL_IDOL,
                             kOPEN_PERMISSION_DEL_T,
                             kOPEN_PERMISSION_GET_FANSLIST,
                             kOPEN_PERMISSION_GET_IDOLLIST,
                             kOPEN_PERMISSION_GET_INFO,
                             kOPEN_PERMISSION_GET_OTHER_INFO,
                             kOPEN_PERMISSION_GET_REPOST_LIST,
                             kOPEN_PERMISSION_LIST_ALBUM,
                             kOPEN_PERMISSION_UPLOAD_PIC,
                             kOPEN_PERMISSION_GET_VIP_INFO,
                             kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                             kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                             kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                             nil];
        
        // weixin setup
        [WXApi registerApp:kWeixinAppID];
        // 微博
        [blockSelf initSinaWeibo];
    });
    
    
//    //jPush request
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
//    [APService  setupWithOption:launchOptions];
    
    //初始化交流平台
    [ShareSDK registerApp:@"艺起画"
          activePlatforms:@[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType) {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                             case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[SinaWeibo class]];
                             break;
                             case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         default:
                             break;
                     }
                 } onConfiguration:^(SSDKPlatformType platformType,
                                     NSMutableDictionary *appInfo) {
                     switch (platformType) {
                         case SSDKPlatformTypeWechat:
                             [appInfo SSDKSetupWeChatByAppId:@"wxa5d7051828efdc40"
                                                   appSecret:@"8d511e7190a20af56dc4d8432637c68e"];
                             break;
                             case SSDKPlatformTypeSinaWeibo:
                             [appInfo SSDKSetupSinaWeiboByAppKey:@"504445686"
                                                       appSecret:nil
                                                     redirectUri:nil
                                                        authType:SSDKAuthTypeBoth];
                             break;
                             case SSDKPlatformTypeQQ:
                             [appInfo SSDKSetupQQByAppId:@"1103185935"
                                                  appKey:@"pOal0Bz0unrRi27a"
                                                authType:SSDKAuthTypeBoth];
                         default:
                             break;
                     }
                     
                 }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //jPush request
   // [APService registerDeviceToken:deviceToken];
    
    NSString *token = [NSString stringWithString:[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]];
    
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"===========%@",deviceToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
   // [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
   // [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Handle OpenURL
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url scheme] rangeOfString:@"tencent"].location !=NSNotFound){
        if (YES == [TencentOAuth CanHandleOpenURL:url])
        {
            return [TencentOAuth HandleOpenURL:url];
        }
    }
    if([[url scheme] rangeOfString:@"sinaweibosso"].location != NSNotFound) return [self.sinaWeibo handleOpenURL:url];
    if([[url scheme] rangeOfString:kWeixinAppID].location != NSNotFound) return [WXApi handleOpenURL:url delegate:self];
    return NO;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url scheme] rangeOfString:@"tencent"].location != NSNotFound) {
        if (YES == [TencentOAuth CanHandleOpenURL:url])
        {
            return [TencentOAuth HandleOpenURL:url];
        }
    }
    
    if([[url scheme] rangeOfString:@"sinaweibosso"].location != NSNotFound) return [self.sinaWeibo handleOpenURL:url];
    if([[url scheme] rangeOfString:kWeixinAppID].location != NSNotFound) return [WXApi handleOpenURL:url delegate:self];
    return NO;
}

- (void)setDBNNavigationStyle {
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            UITextAttributeTextColor:[UIColor colorWithWhite:1.0 alpha:1.0],
                                                            UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetMake(0,0)],
                                                            UITextAttributeFont:[UIFont systemFontOfSize:20.0]
                                                            }];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:252.0/255.0 green:93.0/255.0 blue:123.0/255.0 alpha:1.0]];
        [[UINavigationBar appearance] setBarTintColor:[DBNUtils getColor:@"252f3b"]];
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
    }
    else {
        //  [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:252.0/255.0 green:93.0/255.0 blue:123.0/255.0 alpha:1.0]];
        [[UINavigationBar appearance] setTintColor:[DBNUtils getColor:@"252f3b"]];
        
    }
}

#pragma mark - check NetWork Connection
- (BOOL)checkNetworkConnection {
    if(self.isInternetConnected) return YES;
    [[DBNStatusView sharedDBNStatusView] showStatus:@"你的网络好像有点问题，请重试!" dismissAfter:2.0];
    return NO;
}

#pragma mark - sina weibo
- (void)initSinaWeibo {
    if(_sinaWeibo) {
         _sinaWeibo = nil;
    }
    // SinaWeibo delegate is set to nil. Please set delegate before using it.
    _sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kWBSDKAppKey2 appSecret:kWBSDKAppSecret2 appRedirectURI:kAppRedirectURI andDelegate:nil];
    NSDictionary *sinaweiboInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kSinaWeiboAuthData];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}

- (void)saveSinaWeiboCredential {
    if(_sinaWeibo.isLoggedIn && !_sinaWeibo.isAuthorizeExpired) {
        NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                                  _sinaWeibo.accessToken, @"AccessTokenKey",
                                  _sinaWeibo.expirationDate, @"ExpirationDateKey",
                                  _sinaWeibo.userID, @"UserIDKey",
                                  _sinaWeibo.refreshToken, @"refresh_token", nil];
        [[NSUserDefaults standardUserDefaults] setObject:authData forKey:kSinaWeiboAuthData];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)deleteSinaWeiboCredential {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSinaWeiboAuthData];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark
#pragma mark - Weixin
- (BOOL)isWeixinInstalled {
    if([WXApi isWXAppInstalled]) return YES;
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"你还没有安装微信。安装微信可以将你的新造型分享给好友。现在下载微信吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"以后再说"
                                              otherButtonTitles:@"现在下载", nil];
//    alertview.tag = WeixinDownload;
    [alertview show];
    return NO;
}

- (void)sendWeixinWithImage:(UIImage*)img scene:(int)scene{
    if(![self isWeixinInstalled]) return;
    WXMediaMessage *message = [WXMediaMessage message];
    
    if (img == nil) {
        NSString *logoPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"AppIcon60x60@2x.png"];
        img = [[UIImage alloc]initWithContentsOfFile:logoPath];
    }
    
    UIImage *thumbImg = [CVUtils createThumbnail:img thumbSize:CGSizeMake(100, 100)];
    [message setThumbImage:thumbImg];
//    [message setTitle:@"我的"];
    [message setDescription:@"下载\"艺考魔盒\"，~"];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImageJPEGRepresentation(img, 0.8);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

- (void)sendWeixinWithWebPage:(NSString*)url andTitle:(NSString*)title image:(UIImage*)img scene:(int)scene {
    if(![self isWeixinInstalled]) return;
    WXMediaMessage *message = [WXMediaMessage message];
    if (img == nil) {
        NSString *logoPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"AppIcon60x60@2x.png"];
        img = [[UIImage alloc]initWithContentsOfFile:logoPath];
    }
    
    UIImage *thumbImg = [CVUtils createThumbnail:img thumbSize:CGSizeMake(100, 100)];
    [message setThumbImage:thumbImg];
    [message setTitle:title];
    [message setDescription:@"下载\"打扮妞\"，还能换上试试~"];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
    
    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
    overlay.animation = MTStatusBarOverlayAnimationFallDown;
    [overlay postMessage:@"分享中..." duration:100.0 animated:YES];
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
        overlay.animation = MTStatusBarOverlayAnimationFallDown;
        if (resp.errCode != 0) {
            [overlay postImmediateFinishMessage:@"微信分享失败,请稍后重试！" duration:2.0 animated:YES];
            return;
        }
        [overlay postImmediateFinishMessage:@"微信分享成功！" duration:2.0 animated:YES];
    }
}


#pragma mark - tencent qq

-(void)saveTencentQQCredential:(TencentOAuth *)tencentOAuth{
    if ([tencentOAuth isSessionValid]) {
        NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                                  tencentOAuth.accessToken, @"AccessTokenKey",
                                  tencentOAuth.expirationDate, @"ExpirationDateKey",
                                  tencentOAuth.openId, @"UserIDKey",nil];
        [[NSUserDefaults standardUserDefaults] setObject:authData forKey:kQQAuthData];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"保存QQ数据成功");
    }
}

- (void)deleteQQCredential {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kQQAuthData];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
