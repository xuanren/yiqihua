//
//  AETeacherDetailController.m
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AETeachersDetailController.h"
#import "AETeacherDetailCell.h"
#import "AETeacherIntroController.h"
#import "AETeacherInfoList.h"
#import "DBNAPIList.h"
#import "PullTableView.h"
#import "DBNStatusView.h"

@interface AETeachersDetailController ()<
DBNDataEntriesDelegate
>{
    
    AETeacherIntroController *_tdController;
}

@property (weak, nonatomic) IBOutlet PullTableView *teacherListTableView;
@property (strong, nonatomic) AETeacherInfoList *teacherList;

@end

static NSString *identifer = @"detailCell";

@implementation AETeachersDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [_tdController.view removeFromSuperview];
    
    [self.teacherList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"老师详情";
    
    [self.teacherListTableView registerNib:[UINib nibWithNibName:@"AETeacherDetailCell" bundle:nil] forCellReuseIdentifier:identifer];
    
    _tdController = [[AETeacherIntroController alloc]initWithNibName:@"AETeacherIntroController" bundle:nil];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [window addSubview:_tdController.view];
    _tdController.view.alpha = 0;
    
    self.teacherList = [[AETeacherInfoList alloc] initWithAPIName:[DBNAPIList getTeacherList]];
    self.teacherList.delegate = self;
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"加载中..."];

    [self.teacherList getMostRecentTeachers];
    
    self.teacherListTableView.pullBackgroundColor = self.view.backgroundColor;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
}

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
        
    [self.teacherList getMostRecentTeachers];
    
    self.teacherListTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    
    [self.teacherList getPrevTeachers];
    
    self.teacherListTableView.pullTableIsLoadingMore = NO;
    
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.teacherList.teacherArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AETeacherDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    
    [cell configureWithTchInfo:[self.teacherList.teacherArr objectAtIndex:indexPath.row]];
    
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [_tdController configureWithTchInfo:[(AETeacherInfo *)[self.teacherList.teacherArr objectAtIndex:indexPath.row] user]];
    _tdController.view.alpha = 1;
    
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
    
    [self.teacherListTableView reloadData];
    
    [[DBNStatusView sharedDBNStatusView] dismiss];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

@end
