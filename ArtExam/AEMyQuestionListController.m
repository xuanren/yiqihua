//
//  AEMyQuestionListController.m
//  ArtExam
//
//  Created by dkllc on 14-9-21.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEMyQuestionListController.h"
#import "AEQuestionDetailController.h"
#import "AEQuestionInfoCell.h"
#import "AEQuestionList.h"

@interface AEMyQuestionListController ()<DBNDataEntriesDelegate>

@property (nonatomic, strong) AEQuestionList *questionList;
@property (nonatomic) int userId;

@end

@implementation AEMyQuestionListController

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
    
    [self.questionList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.questionList = [[AEQuestionList alloc]initWithAPIName:[DBNAPIList getMyQuestionsAPI] andUserId:_userId];
    self.questionList.delegate = self;
    [self refreshTable];
    
    self.pullTableView.pullBackgroundColor = self.view.backgroundColor;
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.navigationItem.title = @"我的提问";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
    }
    
    [cell configureWithQuestion:[self.questionList.questionArr objectAtIndex:indexPath.row]];
    
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)] ;
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AEQuestion *question = [self.questionList.questionArr objectAtIndex:indexPath.row];
    
    AEQuestionDetailController *controller = [[AEQuestionDetailController alloc]initWithQuestionId:question.questionId];
    //    AENewTopicController *controller = [[AENewTopicController alloc]init];
    //    AETopicCommentController *controller = [[AETopicCommentController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
    
    //[self requestTodayHomeworkListRefresh];
    
    [self.questionList getMostRecentMyQuestionList];
    
    self.pullTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    
    [self.questionList getPrevMyQuestionList];
    
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
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

@end
