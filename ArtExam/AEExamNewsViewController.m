//
//  AEExamNewsViewController.m
//  ArtExam
//
//  Created by Zheng'en on 15-5-12.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "AEExamNewsViewController.h"

#import "AEImageTitleCell.h"

#import "AEExamNewsCell.h"
#import "DBNImageView.h"
#import "DBNUtils.h"
#import "DBNStatusView.h"
#import "AETopicDetailsController.h"
#import "DBNWebViewController.h"
#import "AEExamNewsList.h"

@interface AEExamNewsViewController ()<DBNDataEntriesDelegate>

@property (nonatomic, strong) AEExamNewsList *examNewsList;

@end

@implementation AEExamNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.examNewsList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //咨询列表
    self.examNewsList = [[AEExamNewsList alloc] initWithAPIName:[DBNAPIList getExamNewsListAPI]];
//    self.examNewsList = [[AEExamNewsList alloc] init];
    
    self.examNewsList.delegate = self;

    [self refreshTable];
}

- (void)initNavItem{
    [super initNavItem];
    [super setCustomBackButton];
    self.navigationItem.title = @"艺考资讯";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_examNewsList.examNewsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"cell";
    AEExamNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        
//        cell = [[AEExamNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        cell = [[NSBundle mainBundle]loadNibNamed:@"AEExamNewsCell" owner:self options:nil][0];
    }
    
    [cell configureWithColleage:[_examNewsList.examNewsList objectAtIndex:indexPath.row]];
    
    
    
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AEExamNews *news = [self.examNewsList.examNewsList objectAtIndex:indexPath.row];
    NSString *tmpUrl = [[ROOTURL stringByAppendingString:EXAMNEWSINFO] stringByAppendingString:news.newsId];
    
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:tmpUrl];
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    
    [self.examNewsList getMostRecentExamNews];
//    self.examNewsList.resultBlock = ^(id JSON){
//        self.examNewsList.examNewsList = JSON;
//        [self refreshTable];
//    };
//    [self.examNewsList getMostRecentExamNewsWithSuccess:^(id result) {
//        self.examNewsList.examNewsList = result;
//        [self refreshTable];
//    }];
}

- (void)loadMoreDataToTable
{
    
    [self.examNewsList getPrevExamNews];
    
    self.examNewsTableView.pullTableIsLoadingMore = NO;
    
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
    
    [self.examNewsTableView reloadData];
    
    [[DBNStatusView sharedDBNStatusView] dismiss];
    
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    [[DBNStatusView sharedDBNStatusView] showStatus:error dismissAfter:2];
}

@end
