//
//  AEAppDelegate.h
//  ArtExam
//
//  Created by dkllc on 14-9-2.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBNReachability.h"
#import "DBNCheckNewVersion.h"
#import "AEHomePageController.h"
#import "AEQuestionAnswerController.h"
#import "AETopicListController.h"
#import "AEFindController.h"
#import "AEArtStudioController.h"
#import "AEUserCenterController.h"
#import "SUNViewController.h"
#import "AECirclesController.h"
#import "SinaWeibo.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentApiInterface.h>

#import "AEColleageViewController.h"
#include "AEArtStudioDetailEViewController.h"

@interface AEAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>{
    DBNReachability* internetReachable;
    DBNCheckNewVersion *checkNewVersion;
    BOOL updateChecked;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic) BOOL isInternetConnected;

@property (nonatomic, strong) AEHomePageController *homePageControlelr;
@property (nonatomic, strong) UINavigationController *homePageNavController;

@property (nonatomic, strong) AEQuestionAnswerController *qAnswerControlelr;
@property (nonatomic, strong) UINavigationController *qAnswerNavController;

@property (nonatomic, strong) AETopicListController *topicListControlelr;
@property (nonatomic, strong) UINavigationController *topicListNavController;

@property (nonatomic, strong) AEFindController *findControlelr;//删掉
@property (nonatomic, strong) AEColleageViewController *colleageController;

@property (nonatomic, strong) UINavigationController *findNavController;

@property (nonatomic, strong) AECirclesController *circlesController;
@property (nonatomic, strong) UINavigationController *circlesNavController;

@property (nonatomic, strong) AEUserCenterController *userCenterControlelr;
@property (nonatomic, strong) UINavigationController *userCenterNavController;
@property (retain, nonatomic) UINavigationController *rootNavController;

@property (retain, nonatomic) SUNViewController * drawerController;

//@property (nonatomic) BOOL isInternetConnected;
@property (nonatomic, retain) SinaWeibo *sinaWeibo;     // global sina weibo object
@property (nonatomic,retain) NSString *deviceToken;
@property (nonatomic,strong)   NSArray* _permissions;   //qq授权

//check NetWork Connection
- (BOOL)checkNetworkConnection;

// SNS
- (void)sendWeixinWithImage:(UIImage*)img scene:(int)scene;
- (void)sendWeixinWithWebPage:(NSString*)url andTitle:(NSString*)title image:(UIImage*)img scene:(int)scene;
- (void)initSinaWeibo;
- (void)saveSinaWeiboCredential;
- (void)deleteSinaWeiboCredential;

//qq
//-(TencentOAuth * )initQQ:(id<TencentSessionDelegate>)qqSessionDelegate;
-(void)saveTencentQQCredential:(TencentOAuth *)tencentOAuth;
-(void)deleteQQCredential;


@end
