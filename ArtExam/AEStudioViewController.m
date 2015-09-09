//
//  AEStudioViewController.m
//  ArtExam
//
//  Created by dkllc on 14-9-11.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEStudioViewController.h"
#import "AEStudioCell.h"
#import "AEStudioDetailsController.h"
#import "AEStudioList.h"
#import "AEAdList.h"

#import "AEWorkSetsController.h"
#import "AETopicDetailsController.h"
#import "AEQuestionDetailController.h"
#import "AEColleageDetailController.h"
#import "AEAdvertisement.h"
#import "DBNImageView.h"
#import "DBNUtils.h"
#import "UIImageView+AFNetworking.h"
#import "AEAreaController.h"
#import "AEAreaView.h"
#import "PullTableView.h"
#import "DBNStatusView.h"
@interface AEStudioViewController ()
<
UITableViewDelegate
,UITableViewDataSource
,DBNDataEntriesDelegate
>

@property (nonatomic, weak) IBOutlet PullTableView *studioTV;

@property (nonatomic, strong) AEStudioList *studioList;

@property (nonatomic, weak) IBOutlet UIScrollView *picSV;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *adTitleLabel;
@property (strong, nonatomic) IBOutlet UIView *adView;

@property (nonatomic, strong) AEAdList *adList;
@property (nonatomic, strong) AEAreaController *areaController;

@end

static NSString* cellIdentifier = @"AEStudioCell";


@implementation AEStudioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.studioList clearDelegateAndCancelRequests];
    [self.adList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.studioTV registerNib:[UINib nibWithNibName:@"AEStudioCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.studioList = [[AEStudioList alloc]initWithAPIName:[DBNAPIList getStudioListAPI]];
    self.studioList.delegate = self;
    [self.studioList getMostRecentStudios];
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"加载中..."];

    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.studioTV.tableFooterView = footer;
    
    [self.studioTV setSeparatorInset:UIEdgeInsetsZero];
    
    //获取广告列表
    self.adList = [[AEAdList alloc] initWithAPIName:[DBNAPIList getAdListAPI] andFrom:2];
    _adList.delegate = self;
    [_adList getadList];
    
    self.studioTV.tableHeaderView = _adView;
}

- (void)initNavItem{
    [super initNavItem];
    [super setCustomBackButton];
    self.navigationItem.title = @"画室";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAdvertisInfo{
    
    self.adTitleLabel.textColor = [DBNUtils getColor:@"33363B"];
    
    if ([_adList.adAry count] > 0) {
        
        self.adTitleLabel.text = [[_adList.adAry objectAtIndex:0] descStr];
    }
    
    
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

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.studioList.studioArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AEStudioCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithStudio:[self.studioList.studioArr objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [MobClick event:@"yqh025"];
    
    AEStudio *studio = [self.studioList.studioArr objectAtIndex:indexPath.row];
    
    AEStudioDetailsController *controller = [[AEStudioDetailsController alloc]initWithStudioId:studio.studioId];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
    
    //[self requestTodayHomeworkListRefresh];
    
    
    [self.studioList getMostRecentStudios];
    
    self.studioTV.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    [self.studioList getPrevStudions];
    
    self.studioTV.pullTableIsLoadingMore = NO;
    
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

#pragma mark - DBNTopicListDelegate
- (void)dataEntriesLoaded:(DBNDataEntries *)dataEntries {
    
    if ([dataEntries isKindOfClass:[AEAdList class]]) {
        
        [self showAdvertisInfo];
    }else{
        
        [self.studioTV reloadData];
        
    }
    [[DBNStatusView sharedDBNStatusView] dismiss];
    
}

- (void)dataEntries:(DBNDataEntries *)dataEntries LoadError:(NSString *)error {
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
    
}

#pragma mark -- IBAction
- (IBAction)onClickFindArea:(id)sender {
    
    self.areaController = [[AEAreaController alloc] initWithAreaViewDelegate:self];
    _areaController.title = @"各省份画室";

    self.areaController.isShowBgView = NO;
    [self.navigationController pushViewController:_areaController animated:YES];
 
    
}

#pragma mark --
- (void)areaView:(AEAreaView *)areaView selectIndex:(int)index{
   
    int locationId = [[[areaView.areaList objectAtIndex:index] objectForKey:@"id"] intValue];
    
    self.studioList.locationId = locationId;

    [self.studioList getMostRecentStudios];
    
    [self.areaController.navigationController popViewControllerAnimated:YES];
    
}
@end
