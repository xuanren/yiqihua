//
//  AEMyCollectionColleagesController.m
//  ArtExam
//
//  Created by dkllc on 14-9-21.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEMyCollectionColleagesController.h"
#import "AEImageTitleCell.h"
#import "AEColleageDetailController.h"
#import "AEColleageList.h"

@interface AEMyCollectionColleagesController ()<DBNDataEntriesDelegate>

@property (nonatomic, strong) AEColleageList *colleageList;
@property (nonatomic) int userId;

@end

@implementation AEMyCollectionColleagesController

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
    
    [self.colleageList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colleageList = [[AEColleageList alloc] initWithAPIName:[DBNAPIList getCollectListAPI] andUserId:_userId];
    self.colleageList.delegate = self;
    [self.colleageList getMostCollectCollegeList];

    [self refreshTable];
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.navigationItem.title = @"收藏的学校";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_colleageList.schoolList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"cell";
    AEImageTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        
        cell = [[AEImageTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    cell.isShowAdd = NO;
    
    [cell configureWithColleage:[_colleageList.schoolList objectAtIndex:indexPath.row]];
    
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AEColleage *college = [_colleageList.schoolList objectAtIndex:indexPath.row];
    AEImageTitleCell * selCell = (AEImageTitleCell *)[tableView cellForRowAtIndexPath:indexPath];
    AEColleageDetailController *controller = [[AEColleageDetailController alloc]initWithColleage:college withThumImg:selCell.iconImgView.image];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
    
    //[self requestTodayHomeworkListRefresh];
    
    
    self.colleageTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    self.colleageTableView.pullTableIsLoadingMore = NO;
    
    
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
    
    [self.colleageTableView reloadData];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

@end
