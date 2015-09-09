//
//  AEColleageDetailController.m
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEColleageDetailController.h"
#import "AEColleageList.h"
#import "UIImageView+AFNetworking.h"
#import "AEShowColleagePicsController.h"
#import "DBNStatusView.h"
#import "AEWebController.h"
#import "DBNWebViewController.h"
#import "DBNLoginViewController.h"
#import "AEQuestionBankAndHotController.h"
#import "DBNAPIList.h"
#import "AEColleageIntroList.h"
#import "AEMatriculateViewController.h"
#import "AEAdmissionsViewController.h"

@interface AEColleageDetailController ()<DBNDataEntriesDelegate>
{
    BOOL _isCollect;
}

@property (nonatomic, strong) AEColleageList *collegeList;
@property (nonatomic, strong) NSString *collegeId;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) AEColleage * currentColleage;
@property (nonatomic, strong) UIImage *thumImg;
@property (nonatomic, strong) AEColleageIntroList *colleageIntroList;


@end

static const float paddingH = 3;

@implementation AEColleageDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _isCollect = YES;
    }
    return self;
}


- (id)initWithColleageId:(NSString *)collegeId{
    
    self = [super init];
    if (self) {
        
        self.collegeId = collegeId;
        
    }
    return self;
}

//colledge
- (instancetype)initWithColleage:(AEColleage *)currentCollege withThumImg:(UIImage *)thumImg
{
    self = [super init];
    if (self) {
        self.currentColleage = currentCollege;
        self.thumImg = thumImg;
    }
    return self;
}

- (void)dealloc{
    
    [self.collegeList clearDelegateAndCancelRequests];
}

#pragma mark -- IBAction
//校园环境
- (IBAction)onClickColleagePics:(id)sender {
    
    AEShowColleagePicsController *showPics = [[AEShowColleagePicsController alloc] initWithWorkSet:_currentColleage.imgs];
    showPics.title = [NSString stringWithFormat:@"校园环境"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:showPics animated:YES];
}

//学校简介
- (IBAction)onClickCollegeInfo:(id)sender {
    
    NSString *urlStr = [[ROOTURL stringByAppendingString:COLLEAGEBRIEFINTRODUCE] stringByAppendingString:_currentColleage.colleageId];
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:urlStr];
    controller.webTitle = @"详情";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

//专业介绍
- (IBAction)onClickProfessionalIntroduction:(id)sender {
    NSString *urlStr = [[ROOTURL stringByAppendingString:COLLEAGEMAJORINTRODUCE] stringByAppendingString:_currentColleage.colleageId];
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:urlStr];
    controller.webTitle = @"专业介绍";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

//往年考题
- (IBAction)onClickExamList:(id)sender {
    AEQuestionBankAndHotController *controller = [[AEQuestionBankAndHotController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.colleageID = _currentColleage.colleageId;
    [self.navigationController pushViewController:controller animated:YES];
}

//录取规则及分数线
- (IBAction)onClickMatriculate:(id)sender {
    AEMatriculateViewController *controller = [[AEMatriculateViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.colleageID = _currentColleage.colleageId;
    [self.navigationController pushViewController:controller animated:YES];
}

//招生简章
- (IBAction)onClickColleageIntro:(id)sender {
    AEAdmissionsViewController *controller = [[AEAdmissionsViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.colleageID = _currentColleage.colleageId;
    [self.navigationController pushViewController:controller animated:YES];
}
/*
- (IBAction)onClickGetIntoCollege:(UIButton *)sender {
    
   // self.totalLabel.text = [NSString stringWithFormat:@"想考这所大学： %d人",_collegeList.collegeDetail.wantreadNum];
    [sender setBackgroundImage:[UIImage imageNamed:@"find_wantgoCollege_def.png"] forState:UIControlStateNormal];
}
*

/*
//简介
- (IBAction)onClickQuestion:(id)sender {
    
//    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"考题",@"title",[NSString stringWithFormat:@"http://ae.bdqrc.cn/college/getpage/id/%@",_collegeList.collegeDetail.examId],@"url", nil];
    
        NSString *tmpUrl = [NSString stringWithFormat:@"%@college/getpage/id/%@",kWebUrl,_collegeList.collegeDetail.examId];
    
//    AEWebController *controller = [[AEWebController alloc] initWithWebInfo:dic];
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:tmpUrl];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickThisYear:(id)sender {
    
    NSString *tmpUrl = [NSString stringWithFormat:@"%@college/getpage/id/%@",kWebUrl,_collegeList.collegeDetail.recruitId];
    
    
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:tmpUrl];
    [self.navigationController pushViewController:controller animated:YES];
}
*/
- (IBAction)onClickNextYear:(id)sender {
    
    
}

#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self addNavigationRightItemCollect];
    
    /*
    self.collegeList = [[AEColleageList alloc] initWithAPIName:[DBNAPIList getSchoolDetailAPI] andDetailId:_collegeId];
    self.collegeList.delegate = self;
    [self.collegeList getSchoolDetail];
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"加载中..."];
     
    NSString *thisYear = [self getThisYear];
    [self.thisYearBtn setTitle:thisYear forState:UIControlStateNormal];
    self.thisYearBtn.layer.cornerRadius = 13.f;
    self.thisYearBtn.layer.masksToBounds = YES;
    
     NSString *nextYear = [NSString stringWithFormat:@"%d",[thisYear intValue] + 1];
    [self.nextYearBtn setTitle:nextYear forState:UIControlStateNormal];
    self.nextYearBtn.layer.cornerRadius = 13.f;
    self.nextYearBtn.layer.masksToBounds = YES;
     */
    [self showData:_currentColleage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavItem{
    [super initNavItem];
 
    [super setCustomBackButton];
}

- (void)addNavigationRightItemCollect
{
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectBtn.frame = CGRectMake(0, 0, 25, 25);
    [_collectBtn addTarget:self action:@selector(onClickCollect:) forControlEvents:UIControlEventTouchUpInside];
    [_collectBtn setImage:[UIImage imageNamed:@"btn_notToCollect.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:_collectBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)showData:(AEColleage *)college{
    _colleageImgView.image = _thumImg;
    self.navigationItem.title = college.name;
    self.imgNumLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[college.imgs count]];
    self.cityLabel.text = [NSString stringWithFormat:@"地区：%@",college.locationArea];
    self.yearLabel.text = [NSString stringWithFormat:@"创办于：%@年",college.buildYear];
    self.typeLabel.text = [NSString stringWithFormat:@"院校类型：%@",college.collegeType];
    self.levelLabel.text = [NSString stringWithFormat:@"学历层次：%@",college.colleageLevel];
    self.subjectLabel.text = [NSString stringWithFormat:@"美考科目：%@",college.colleageSubject];
    self.peoplesLabel.text = [NSString stringWithFormat:@"招生人数：%@人",college.colleageStunum];
    
    if (college.isFavorite == 1) {
        
        [_collectBtn setImage:[UIImage imageNamed:@"btn_collect.png"] forState:UIControlStateNormal];
    }
    
    [self recSubviewsFrame];
}

- (void)recSubviewsFrame{
    
    [self.typeLabel sizeToFit];
    
    float labelY = 0;
    CGRect tmpRect = self.levelLabel.frame;
    labelY = _typeLabel.frame.origin.y + _typeLabel.frame.size.height + paddingH;
    tmpRect.origin.y = labelY;
    self.levelLabel.frame = tmpRect;
    
    [self.subjectLabel sizeToFit];
    tmpRect = self.subjectLabel.frame;
    labelY = _levelLabel.frame.origin.y + _levelLabel.frame.size.height + paddingH;
    tmpRect.origin.y = labelY;
    self.subjectLabel.frame = tmpRect;
    
    tmpRect = self.peoplesLabel.frame;
    labelY = _subjectLabel.frame.origin.y + _subjectLabel.frame.size.height + paddingH;
    tmpRect.origin.y = labelY;
    self.peoplesLabel.frame = tmpRect;
    
    CGRect rect = self.secondView.frame;
    rect.size.height = tmpRect.origin.y + tmpRect.size.height + 10;
    self.secondView.frame = rect;
    
    float viewY = rect.origin.y + rect.size.height;
    
    rect = self.thirdView.frame;
    rect.origin.y = viewY;
    self.thirdView.frame = rect;
    
    float contentHeight = rect.origin.y + rect.size.height;
    self.scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, contentHeight);
    
    [self getThisYear];
}

//获取年份
- (NSString *)getThisYear{
    
    NSDate *confromTimesp = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString * time=[dateFormatter stringFromDate:confromTimesp];

    return time;
}

#pragma mark -- IBAction
- (IBAction)onClickCollect:(UIButton *)sender{
    
    [sender setImage:[UIImage imageNamed:@"btn_collect.png"] forState:UIControlStateNormal];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [parameters setValue:@"colleges" forKey:@"type"];
    [parameters setValue:_collegeList.collegeDetail.colleageId forKey:@"id"];
    
    if (_isCollect) {
        
        _isCollect = NO;
    }else{
        
        _isCollect = YES;
    }
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getCollectAPI] parameters:parameters needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id json) {
        
        if ([[json objectForKey:@"code"] intValue] == 0) {
            
            NSDictionary *data = [json objectForKey:@"data"];
            
            if ([[data objectForKey:@"state"] intValue] == 1) {
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"收藏成功" dismissAfter:3.0];
                
                [sender setImage:[UIImage imageNamed:@"btn_collect.png"] forState:UIControlStateNormal];
            }else{
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"取消收藏" dismissAfter:3.0];
                [sender setImage:[UIImage imageNamed:@"btn_notToCollect.png"] forState:UIControlStateNormal];
            }
            
        }else if ([[json objectForKey:@"code"] intValue] == 22){
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能收藏" dismissAfter:3.0];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    
    [self showData:_collegeList.collegeDetail];
    [[DBNStatusView sharedDBNStatusView] dismiss];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

@end
