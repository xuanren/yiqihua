//
//  AEMyTopicListController.m
//  ArtExam
//
//  Created by dkllc on 14-9-21.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEMyTopicListController.h"
#import "AETopicList.h"
#import "AETopicListTableView.h"

@interface AEMyTopicListController ()
<DBNDataEntriesDelegate>
@property (nonatomic) int userId;

@property (nonatomic, weak) IBOutlet AETopicListTableView *topicListTV;

@property (nonatomic, strong) AETopicList *topicList;

@end

@implementation AEMyTopicListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithUID:(int)uId{
    self = [super init];
    if (self) {
        self.userId = uId;
    }
    return self;
}

- (void)dealloc{
    
    [self.topicList clearDelegateAndCancelRequests];
}

- (void)initNavItem{
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.navigationItem.title = @"我的话题";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.topicListTV.rootController = self;
    
    self.topicList = [[AETopicList alloc]initWithAPIName:[DBNAPIList getCollectListAPI]];
    self.topicList.delegate = self;
    [self refreshTable];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
    
    //[self requestTodayHomeworkListRefresh];
    
    [self.topicList getMyMostRecentTopics:self.userId];
    
    //    self.topicListTV.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    
    [self.topicList getMyMostRecentTopics:self.userId];
    
    //    self.topicListTV.pullTableIsLoadingMore = NO;
    
    
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
    self.topicListTV.topicList = self.topicList;
    [self.topicListTV reloadData];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}


@end
