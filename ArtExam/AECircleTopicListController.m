//
//  AECircleTopicListController.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AECircleTopicListController.h"
#import "AETopicList.h"
#import "AETopic.h"
#import "AETopicListCell.h"
#import "AETopicDetailsController.h"
#import "AEAppDelegate.h"
#import "AENewTopicController.h"
#import "AEAppDelegate.h"
#import "DBNLoginViewController.h"
#import "AECircleListHeaderCell.h"

@interface AECircleTopicListController ()
<
DBNDataEntriesDelegate
,UITableViewDataSource
,UITableViewDelegate
>

@property (nonatomic, strong) AETopicList *topicList;

@end

static NSString* cellIdentifier = @"AETopicListCell";
static NSString* cellIdentifier1 = @"AECircleListHeaderCell";


@implementation AECircleTopicListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithCircle:(AECircle *)circle{
    self = [super init];
    if (self) {
        self.circleInfo = circle;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.rootNavController == self.navigationController) {
        appDelegate.rootNavController.navigationBarHidden = NO;
    }
    
    [MobClick beginLogPageView:@"circle_page"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.rootNavController.navigationBarHidden = YES;
    
//    [appDelegate.rootNavController setNavigationBarHidden:YES animated:YES];
    
    [MobClick endLogPageView:@"circle_page"];
    
}


- (void)dealloc{
    
//    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
//    //    appDelegate.rootNavController.navigationBarHidden = YES;
//    [appDelegate.rootNavController setNavigationBarHidden:YES animated:YES];

    
    [self.topicList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.topicListTV registerNib:[UINib nibWithNibName:@"AETopicListCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    [self.topicListTV registerNib:[UINib nibWithNibName:@"AECircleListHeaderCell" bundle:nil] forCellReuseIdentifier:cellIdentifier1];
    
    [self.topicListTV setSeparatorStyle:UITableViewCellSeparatorStyleNone];


    self.topicListTV.dataSource = self;
    self.topicListTV.delegate = self;
    
    self.topicList = [[AETopicList alloc]initWithAPIName:[DBNAPIList getPostListAPI]];
    self.topicList.delegate = self;
    self.topicList.type = self.circleInfo.circieLd;
    [self refreshTable];
    
    [self addNavigationRightItem];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.topicListTV.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.title = self.circleInfo.name;
}

- (void)createHeaderView{
}

#pragma mark - private methords
- (void)addNavigationRightItem
{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 60, 30);
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [rightBtn addTarget:self action:@selector(postAction:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setTitle:@"发帖" forState:UIControlStateNormal];
    
    [rightBtn setImage:[UIImage imageNamed:@"c_post_one"] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}


- (void)initNavItem{
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.navigationItem.title = @"圈子";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postAction:(id)sender{
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }

    
    AENewTopicController *controller = [[AENewTopicController alloc]initWithCircleId:self.circleInfo.circieLd];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
    
    //[self requestTodayHomeworkListRefresh];
    
    [self.topicList getMostRecentTopics];
    
    self.topicListTV.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    
    [self.topicList getPrevTopics];
    
    self.topicListTV.pullTableIsLoadingMore = NO;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.topicList.topicArr count] + 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        AECircleListHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1 forIndexPath:indexPath];
        
        [cell configureWithCircle:self.circleInfo];
        return cell;
        
    }
    
    AETopicListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithTopic:[self.topicList.topicArr objectAtIndex:indexPath.row-1]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        return;
    }
    
    AETopic *topic = [self.topicList.topicArr objectAtIndex:indexPath.row-1];
    
    AETopicDetailsController *controller = [[AETopicDetailsController alloc]initWithPostId:topic.topicId];
//    [self.navigationController pushViewController:controller animated:YES];
    
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.rootNavController pushViewController:controller animated:YES];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 65;
    }
    
    return [AETopicListCell heightForTopicListCellWithTopic:[self.topicList.topicArr objectAtIndex:indexPath.row-1]];
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
    [self.topicListTV reloadData];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}


@end
