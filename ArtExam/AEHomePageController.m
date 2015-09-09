//
//  AEHomePageControllerViewController.m
//  ArtExam
//
//  Created by dkllc on 14-9-2.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEHomePageController.h"
#import "DBNLoginViewController.h"
#import "AEHomePageCell.h"
#import "PullTableView.h"
#import "DBNConsts.h"
#import "AEHomeFeedList.h"
#import "AEWorkSetsController.h"
#import "AEWorkSetDetailsController.h"
#import "AEColleageDetailController.h"
#import "AEStudioDetailsController.h"
#import "AETopicDetailsController.h"
#import "AEQuestionDetailController.h"
#import "AEWebController.h"
#import "AEAppDelegate.h"
#import "DBNWebViewController.h"
#import "DBNStatusView.h"

@interface AEHomePageController ()
<
DBNDataEntriesDelegate
>
@property (weak, nonatomic) IBOutlet PullTableView *pullTableView;

@property (strong, nonatomic) AEHomeFeedList *feedList;

@property (strong, nonatomic) IBOutlet UIView *titleView;

@end

static NSString* cellIdentifier = @"AEHomePageCell";


@implementation AEHomePageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.feedList clearDelegateAndCancelRequests];
}

- (void)initNavItem{
    [super initNavItem];
    self.navigationItem.titleView = _titleView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    [self.pullTableView registerNib:[UINib nibWithNibName:@"AEHomePageCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.feedList = [[AEHomeFeedList alloc]initWithAPIName:[DBNAPIList getHomeListAPI]];
    self.feedList.delegate = self;
    
    [self refreshTable];
    
   // [self addNavigationRightItem];
    
    self.pullTableView.pullBackgroundColor = self.view.backgroundColor;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].currentMode.size.width, 6)] ;
    headView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    self.pullTableView.tableHeaderView = headView;
    
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
    for(UIView *view in appDelegate.tabBarController.tabBar.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick event:@"yqh001"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private methords
- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    [rightBtn addTarget:self action:@selector(enterWorkSet) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"homePage_gallery.png"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)enterWorkSet{
    AEWorkSetsController *controller = [[AEWorkSetsController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.feedList.feedArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AEHomePageCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [((AEHomePageCell *)cell)configureWithFeed:[self.feedList.feedArr objectAtIndex:indexPath.row]];
    return cell;
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 + 30 +6;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 6;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)] ;
//    headView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:235.0/255.0 alpha:1];
//    return headView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AEHomeFeed *feed = [self.feedList.feedArr objectAtIndex:indexPath.row];
    NSString *tmpUrl = [[ROOTURL stringByAppendingString:HOMEINFO] stringByAppendingString:feed.typeId];
    
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:tmpUrl];
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
//    if ([feed.feedType isEqualToString:@"8a7c9e234ab07aae014aba42e71d009c"]) {
//        
//       
//    }
    /*
    if (feed.feedType == Gallery_Type) {
        
        AEWorkSetsController *controller = [[AEWorkSetsController alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else if (feed.feedType == Information_Type){
        
        AEQuestionDetailController *controller = [[AEQuestionDetailController alloc]initWithQuestionId:feed.typeId];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
    }else if (feed.feedType == CollegeHomePage_Type){
        
        NSString *typeId = [NSString stringWithFormat:@"%d",feed.typeId];
        AEColleageDetailController *controller = [[AEColleageDetailController alloc]initWithColleageId:typeId];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else if (feed.feedType == StudioHomePage_Type){
        
        AEStudioDetailsController *controller = [[AEStudioDetailsController alloc]initWithStudioId:feed.typeId];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else if (feed.feedType == Topic_Type){
        
        AETopicDetailsController *controller = [[AETopicDetailsController alloc]initWithPostId:364];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else if (feed.feedType == WebView_Type){
        
        NSString *url = [NSString stringWithFormat:@"http://ae.bdqrc.cn/college/getpage/id/%d",feed.typeId];
        
//        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:url,@"url", nil];
//        AEWebController *controller = [[AEWebController alloc] initWithWebInfo:info];
        
        NSString *tmpUrl = [NSString stringWithFormat:@"%@college/getpage/id/%d",kWebUrl,feed.typeId];
        
        DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:tmpUrl];
        
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    */
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
    
        //[self requestTodayHomeworkListRefresh];


    [self.feedList getMostRecentHomeFeeds];
    
    self.pullTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{

    [self.feedList getPrevHomeFeeds];

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
    
    [self.pullTableView reloadData];
    [[DBNStatusView sharedDBNStatusView] dismiss];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    [[DBNStatusView sharedDBNStatusView] showStatus:error dismissAfter:2];
}

@end
