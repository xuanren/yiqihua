//
//  AEQuestionAnswerController.m
//  ArtExam
//
//  Created by dkllc on 14-9-2.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEQuestionAnswerController.h"
#import "AEQuestionInfoCell.h"
#import "AEQuestionDetailController.h"
#import "AETeachersDetailController.h"
#import "AENewQuestionController.h"
#import "AEQuestionList.h"
#import "PullTableView.h"
#import "AENewTopicController.h"
#import "AETopicCommentController.h"
#import "DBNImageView.h"
#import "AEAdList.h"
#import "DBNUtils.h"
#import "AEWorkSetsController.h"
#import "AEStudioDetailsController.h"
#import "AEColleageDetailController.h"
#import "AETopicDetailsController.h"
#import "DBNStatusView.h"

@interface AEQuestionAnswerController ()
<
DBNDataEntriesDelegate
,AENewQuestionControllerDelegate
>
@property (nonatomic, strong) AEQuestionList *questionList;

@property (weak, nonatomic) IBOutlet PullTableView *pullTableView;

@property (nonatomic, weak) IBOutlet UIScrollView *picSV;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *adTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *adView;


@property (nonatomic, strong) AEAdList *adList;

@end

@implementation AEQuestionAnswerController

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
    
    [self addNavigationLeftItem];
    [self addNavigationRightItem];
    
    self.questionList = [[AEQuestionList alloc]initWithAPIName:[DBNAPIList getQuestionList]];
    self.questionList.delegate = self;

    [self refreshTable];
    
    //获取广告列表
    self.adList = [[AEAdList alloc] initWithAPIName:[DBNAPIList getAdListAPI] andFrom:1];
    _adList.delegate = self;
    [_adList getadList];
    
    if ([_adList.adAry count] > 0) {
        
        [self showAdvertisInfo];
        
    }
    
    self.pullTableView.pullBackgroundColor = self.view.backgroundColor;
    
    self.pullTableView.tableHeaderView = self.adView;

}

- (void)dealloc{
    [self.questionList clearDelegateAndCancelRequests];
}

- (void)initNavItem{
    [super initNavItem];
    self.navigationItem.title = @"评画";
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick event:@"yqh005"];
}

- (void)showAdvertisInfo{

    self.adTitleLabel.textColor = [DBNUtils getColor:@"33363B"];
    
    self.adTitleLabel.text = [[_adList.adAry objectAtIndex:0] descStr];
    
    self.pageControl.numberOfPages = [self.adList.adAry count];
    
    for (int i = 0; i < [self.adList.adAry count]; i++) {
        AEAdvertisement *ad = [self.adList.adAry objectAtIndex:i];
        NSString *url = ad.imgUrl;
        if (url != nil) {
            
            __block DBNImageView *tmpImg = [[DBNImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, 181)];
            
            [tmpImg setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            
            [self.picSV addSubview:tmpImg];
        };
    }
    
    self.picSV.contentSize = CGSizeMake([self.adList.adAry count] * self.view.frame.size.width, _picSV.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNavigationLeftItem
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 23);
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [leftBtn addTarget:self action:@selector(onClickTeacherDetail:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"questionAnswer_teacher_detail.png"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 23);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [rightBtn addTarget:self action:@selector(onClickQuestion:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_askquestion.png"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

#pragma mark --  IBAction
-(IBAction)onClickTeacherDetail:(id)sender{
    
    [MobClick event:@"yqh006"];
    
    AETeachersDetailController *controller = [[AETeachersDetailController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickQuestion:(id)sender{
    
    [MobClick event:@"yqh007"];
    AENewQuestionController *controller = [[AENewQuestionController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.delegate = self;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count:%d",[self.questionList.questionArr count]);
    return [self.questionList.questionArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"topcell";
    AEQuestionInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        
        cell = [[AEQuestionInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        cell.rootController = self;
    }
    
    [cell configureWithQuestion:[self.questionList.questionArr objectAtIndex:indexPath.row]];
    
    [cell setCurrTimeStamp:self.questionList.timeStamp];
    
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 6;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)] ;
//    headView.backgroundColor = [UIColor clearColor];
//    return headView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [MobClick event:@"yqh008"];
    
    AEQuestion *question = [self.questionList.questionArr objectAtIndex:indexPath.row];
    
    AEQuestionDetailController *controller = [[AEQuestionDetailController alloc]initWithQuestionId:question.questionId];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
    
    //[self requestTodayHomeworkListRefresh];

    
    [self.questionList getMostRecentQuestions];
    
    self.pullTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    [self.questionList getPrevQuestions];
    
    self.pullTableView.pullTableIsLoadingMore = NO;
    
    
}

#pragma mark -- 下拉刷新和上拉加载 PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{

    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.2f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:0.2f];
}

#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    
    if ([dataEntries isKindOfClass:[AEAdList class]]) {
        
        [self showAdvertisInfo];
    }else{
        
        [self.pullTableView reloadData];
        
    }
   
    [[DBNStatusView sharedDBNStatusView] dismiss];
    
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

#pragma mark - AENewQuestionControllerDelegate
-(void)postInProgress{
}
- (void)postDidSuccess:(AENewQuestionController*)controller{
    [self refreshTable];
}

- (void)postDidFail:(AENewQuestionController*)controller{
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int num = lroundf(self.picSV.contentOffset.x/self.view.frame.size.width);
    self.pageControl.currentPage = num;
    
    AEAdvertisement *ad = [self.adList.adAry objectAtIndex:num];
    self.adTitleLabel.text = ad.descStr;
}

#pragma mark --  GestureRecognizer
- (IBAction)tapGestureRecognizerAd:(UITapGestureRecognizer *)sender {
    
    AEAdvertisement *ad = [_adList.adAry objectAtIndex:self.pageControl.currentPage];
    
    if (ad.type == Gallery_Type) {
        
        AEWorkSetsController *controller = [[AEWorkSetsController alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else if (ad.type == Information_Type){
        
        AEQuestionDetailController *controller = [[AEQuestionDetailController alloc]initWithQuestionId:ad.tid];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
    }else if (ad.type == CollegeHomePage_Type){
        
        NSString *typeId = [NSString stringWithFormat:@"%d",ad.tid];
        AEColleageDetailController *controller = [[AEColleageDetailController alloc]initWithColleageId:typeId];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else if (ad.type == StudioHomePage_Type){
        
        AEStudioDetailsController *controller = [[AEStudioDetailsController alloc]initWithStudioId:ad.tid];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else if (ad.type == Topic_Type){
        
        AETopicDetailsController *controller = [[AETopicDetailsController alloc]initWithPostId:364];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    NSLog(@"currentPage ==== %d",self.pageControl.currentPage);
}
@end
