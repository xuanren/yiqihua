//
//  AEUserCenterController.m
//  ArtExam
//
//  Created by dkllc on 14-9-2.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEUserCenterController.h"
#import "AESetController.h"
#import "AEMyQuestionListController.h"
#import "AEMyCollectionColleagesController.h"
#import "UIImageView+AFNetworking.h"
#import "DBNLoginViewController.h"
#import "AEUserCenter.h"
#import "AEMyCollectionStudiosController.h"
#import "AEMyTopicListController.h"
#import "DBNUtils.h"
#import "AELevelThatController.h"
#import "DBNStatusView.h"
#import "AEMyCollectionImageListController.h"

@interface AEUserCenterController ()<DBNDataEntriesDelegate>
{
    BOOL _isFollow;
    BOOL _isMe;
}
@property (nonatomic, strong) AEUserCenter *userCenter;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contraintViewB;

@end

@implementation AEUserCenterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isFollow = YES;
        _isMe = YES;
    }
    return self;
}

- (id)initWithUserId:(int)uId{
    self = [super init];
    if (self) {
        self.userId = uId;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.progressView.trackTintColor = [DBNUtils getColor:@"999FA8"];
    self.progressView.progressTintColor = [DBNUtils getColor:@"64C893"];
    
    self.loginBtn.layer.cornerRadius = 14.f;
    self.loginBtn.layer.masksToBounds = YES;
    
    self.logoBgImgView.layer.cornerRadius = 43.f;
    self.logoBgImgView.layer.masksToBounds = YES;
    
    if (self.userId <= 0) {
        self.userId = [DBNUser sharedDBNUser].userId;
        [self addNavigationRightItem];
    }else{
        
        self.userCenter = [[AEUserCenter alloc] initWithAPIName:[DBNAPIList getUserDetailAPI] andUserId:self.userId];
        self.userCenter.delegate = self;
        [self.userCenter getUserInfo];
        
        _isMe = NO;
        self.loginBtn.hidden = YES;
        self.attentionBtn.hidden = NO;
        [super setCustomBackButton];
    }
    
  
    [self layoutSubviews];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logInStatusChange:) name:DBN_LOGIN_STATUS_CHANGE object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    [super initNavItem];
    self.navigationItem.title = @"个人主页";
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSString *imgIndex = [[NSUserDefaults standardUserDefaults]objectForKey:@"imgIndex"];
    
    if (imgIndex) {
        
        [self.userBgImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"userCenter_background_0%@.jpg",imgIndex]]];
    }else{
        
        [self.userBgImgView setImage:[UIImage imageNamed:@"userCenter_background_01.jpg"]];
    }
    
    if (_isMe) {
        
        if ([DBNUser sharedDBNUser].loggedIn) {
            
            self.loginBtn.hidden = YES;
            
            self.userCenter = [[AEUserCenter alloc] initWithAPIName:[DBNAPIList getUserDetailAPI] andUserId:self.userId];
            self.userCenter.delegate = self;
            [self.userCenter getUserInfo];
        }else{
            
            [self logouClearUserInfo];
        }
    }
    
}

- (void)logInStatusChange:(NSNotification *)notificion{
    
    if ([DBNUser sharedDBNUser].loggedIn) {
        
        self.loginBtn.hidden = YES;
        
        self.userCenter = [[AEUserCenter alloc] initWithAPIName:[DBNAPIList getUserDetailAPI] andUserId:[[DBNUser sharedDBNUser] userId]];
        self.userCenter.delegate = self;
        [self.userCenter getUserInfo];
    }else{
        
        self.loginBtn.hidden = NO;
        
        [self logouClearUserInfo];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    [rightBtn addTarget:self action:@selector(onClickSet:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"userCenter_seting.png"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)layoutSubviews{
    
    self.logoImgView.layer.cornerRadius = _logoImgView.frame.size.width / 2.0;
    self.logoImgView.layer.masksToBounds = YES;
}

- (void)showUserInfo:(AEUserRelatedData *)userRelated{
    
    if (userRelated == nil) {
        
        return;
    }
    
    self.nameLabel.text = userRelated.username;
    
    [self.logoImgView setImageWithURL:[NSURL URLWithString:userRelated.avatarurl] placeholderImage:[UIImage imageNamed:@""]];
    self.attentionNumLabel.text = userRelated.followedNum;
    self.fansNumLabel.text = userRelated.followerNum;
    self.questionNumLabel.text = userRelated.questionNum;
    self.topicNumLabel.text = userRelated.articleNum;
    self.schoolNumLabel.text = userRelated.collegeNum;
    self.artexamNumLabel.text = userRelated.studioNum;
    self.imgNumLabel.text = userRelated.imageNum;
    
    self.dengjiLabel.text = [NSString stringWithFormat:@"等级 %@ %@",[userRelated.levelInfo objectForKey:@"level"],[userRelated.levelInfo objectForKey:@"name"]];
    self.ratioLabel.text = [NSString stringWithFormat:@"%@/%@",[userRelated.levelInfo objectForKey:@"min"],[userRelated.levelInfo objectForKey:@"max"]];
    
    float progress = [[userRelated.levelInfo objectForKey:@"min"] floatValue] / [[userRelated.levelInfo objectForKey:@"max"] floatValue] * 100;
    
    [self.progressView setProgress:progress andRatio:nil animated:YES];
}

- (void)logouClearUserInfo{
    
    self.nameLabel.text = @"";
    
    self.dengjiLabel.text = @"";
    self.ratioLabel.text = @"";
    self.logoImgView.image = [UIImage imageNamed:@"common_defaultAvatar.png"];
    self.attentionNumLabel.text = @"0";
    self.fansNumLabel.text = @"0";
    self.questionNumLabel.text = @"0";
    self.topicNumLabel.text = @"0";
    self.schoolNumLabel.text = @"0";
    self.artexamNumLabel.text = @"0";
    self.imgNumLabel.text = @"0";
    
}

#pragma mark -- IBAction
- (IBAction)onClickSet:(id)sender{
    
    [MobClick event:@"yqh033"];
    AESetController *controller = [[AESetController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)onClickAttention:(id)sender {
    
    [MobClick event:@"yqh035"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    if (_isFollow) {
        
        [parameters setValue:@"1" forKey:@"isFollow"];
        
        _isFollow = NO;
    }else{
        
        [parameters setValue:@"0" forKey:@"isFollow"];
        
        _isFollow = YES;
    }
    
    [parameters setValue:@"0" forKey:@"isFollow"];
    
    [parameters setValue:@(_userCenter.userRelate.userId) forKey:@"uid"];
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getUserFollowAPI] parameters:parameters needIdInfo:NO success:^(AFHTTPRequestOperation *opertion, id json) {
        
        if ([[json objectForKey:@"code"] intValue] == 0) {
            
            if (!_isFollow) {
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"关注成功" dismissAfter:3.f];
            }else{
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"取消关注" dismissAfter:3.f];
            }
            
        }else{
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"关注失败" dismissAfter:3.f];
        }
        
    } failure:^(AFHTTPRequestOperation *opertion, NSError *error) {
        
    }];
}
//com.ekwing.AppStudent
//com.yiqihua.draw

- (IBAction)onClickSiXin:(id)sender {
}

- (IBAction)onClickUserInfo:(id)sender {
    
    [MobClick event:@"yqh034"];
    
    if (_isMe) {
        
        if (![DBNUser sharedDBNUser].loggedIn) {
            
            [self alertViewPrompt];
            return;
        }
        
    }
    AELevelThatController *controller = [[AELevelThatController alloc] initWithLevelInfo:_userCenter.userRelate.levelInfo];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)onClickAttentionList:(id)sender {
    
    
}

- (IBAction)onClickFans:(id)sender {
}

- (IBAction)onClickQuestion:(id)sender {
    
    [MobClick event:@"yqh036"];
    
    if (_isMe) {
        
        if (![DBNUser sharedDBNUser].loggedIn) {
            
            [self alertViewPrompt];
            return;
        }
        
    }
    AEMyQuestionListController *myQuestionController = [[AEMyQuestionListController alloc] initWithUID:_userCenter.userRelate.userId];
    myQuestionController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myQuestionController animated:YES];
    
}

- (IBAction)onClickTopic:(id)sender {
    
    [MobClick event:@"yqh037"];
    
    if (_isMe) {
        
        if (![DBNUser sharedDBNUser].loggedIn) {
            
            [self alertViewPrompt];
            return;
        }
        
    }
    
    AEMyTopicListController *controller = [[AEMyTopicListController alloc]initWithUID:1];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickCollectSchool:(id)sender {
    
    [MobClick event:@"yqh038"];
    
    if (_isMe) {
        
        if (![DBNUser sharedDBNUser].loggedIn) {
            
            [self alertViewPrompt];
            return;
        }
        
    }
    
    AEMyCollectionColleagesController *collegeController = [[AEMyCollectionColleagesController alloc] initWithUID:_userCenter.userRelate.userId];
    collegeController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:collegeController animated:YES];
}

- (IBAction)onClickCollectArtexam:(id)sender {
    
    [MobClick event:@"yqh039"];
    
    if (_isMe) {
        
        if (![DBNUser sharedDBNUser].loggedIn) {
            
            [self alertViewPrompt];
            return;
        }
        
    }
    
    AEMyCollectionStudiosController *controller = [[AEMyCollectionStudiosController alloc]initWithUID:self.userCenter.userRelate.userId];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickLogin:(id)sender {
    
    DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)onClickCollectImgs:(id)sender {
    
    [MobClick event:@"yqh040"];
    
    if (_isMe) {
        
        if (![DBNUser sharedDBNUser].loggedIn) {
            
            [self alertViewPrompt];
            return;
        }
        
    }
    
    AEMyCollectionImageListController *controller = [[AEMyCollectionImageListController alloc] initWithUserId:_userCenter.userRelate.userId];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    
    [self showUserInfo:_userCenter.userRelate];

}

- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

- (void)alertViewPrompt{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册登录做有身份的小伙伴!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        
    }else{
        
        [self onClickLogin:nil];
    }
}

@end
