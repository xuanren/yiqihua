//
//  AEColleageViewController.m
//  ArtExam
//
//  Created by dkllc on 14-9-11.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEColleageViewController.h"
#import "AEImageTitleCell.h"
#import "AEColleageDetailController.h"
#import "AEQuestionBankAndHotController.h"
#import "AEHotMajorController.h"
#import "AEColleageList.h"
#import "DBNImageView.h"
#import "AESearchViewController.h"
#import "AEAreaController.h"
#import "AEAreaView.h"
#import "AEAdList.h"
#import "DBNUtils.h"
#import "DBNStatusView.h"

#import "AEWorkSetsController.h"
#import "AEStudioDetailsController.h"
#import "AETopicDetailsController.h"
#import "AEQuestionDetailController.h"

#import "DBNWebViewController.h"
@interface AEColleageViewController ()<DBNDataEntriesDelegate,AEAreaViewDelegate>

@property (nonatomic, strong) AEColleageList *colleageList;

@property (nonatomic, weak) IBOutlet UIScrollView *picSV;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *adTitleLabel;
@property (nonatomic, strong) UILabel *areaLabel;
@property (strong, nonatomic) IBOutlet UIView *adView;


@property (nonatomic, strong) AEAreaController *areaController;
@property (nonatomic, strong) AEAdList *adList;

@end

@implementation AEColleageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.colleageList clearDelegateAndCancelRequests];
    [self.adList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //获取广告列表
    self.adList = [[AEAdList alloc] initWithAPIName:[DBNAPIList getAdListAPI] andFrom:3];
    _adList.delegate = self;
    [_adList getadList];
    
    //院校列表
    self.colleageList = [[AEColleageList alloc] initWithAPIName:[DBNAPIList getSchoolListAPI] andLocationId:0];
    self.colleageList.delegate = self;

    [self refreshTable];
    
    [self addNavigationRightItemSearch];
    
    //地区搜索
    self.areaController = [[AEAreaController alloc] initWithAreaViewDelegate:self];
    
    [self.view addSubview:_areaController.view];
    _areaController.view.hidden = YES;
   
    
    self.colleageTableView.tableHeaderView = _adView;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    [super initNavItem];
    //[super setCustomBackButton];
    //self.navigationItem.title = @"院校";
    
    [self titleView];
}

- (void)titleView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    self.areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 123, 40)];
    _areaLabel.backgroundColor = [UIColor clearColor];
    _areaLabel.textColor = [UIColor whiteColor];
    _areaLabel.textAlignment = NSTextAlignmentRight;
    _areaLabel.font = [UIFont systemFontOfSize:20.f];
    _areaLabel.text = @"全国";
    [titleView addSubview:_areaLabel];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(122, 16, 16, 10)];
    imgView.image = [UIImage imageNamed:@"find_pulldown.png"];
    [titleView addSubview:imgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height);
    [btn addTarget:self action:@selector(onClickChoiceArea:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btn];
    
}


- (void)searchAction{
    
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
            UIImage *img = [UIImage imageNamed:@"a_home_loading"];
            [tmpImg setImageWithURL:[NSURL URLWithString:url] placeholderImage:img];
            
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

- (void)addNavigationRightItemSearch
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 20, 20);
    [rightBtn addTarget:self action:@selector(onClickSearch:) forControlEvents:UIControlEventTouchUpInside];
    //[rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [rightBtn setImage:[UIImage imageNamed:@"find_search_college.png"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

#pragma mark -- IBAction

- (IBAction)onClickQuestionBank:(id)sender {
    
    [MobClick event:@"yqh027"];
    AEQuestionBankAndHotController *controller = [[AEQuestionBankAndHotController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

//热门专业
- (IBAction)onClickHot:(id)sender {
    
    [MobClick event:@"yqh028"];
    AEHotMajorController *controller = [[AEHotMajorController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onClickSearch:(id)sender{
    AESearchViewController *controller = [[AESearchViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)onClickChoiceArea:(id)sender{
    
    if ([self.areaController.areaList count] == 0) {
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"暂无地区信息" dismissAfter:3.f];
    }else{
        
        self.areaController.view.hidden = NO;
        self.areaController.view.backgroundColor = [UIColor clearColor];
    }
    
}

#pragma mark --
- (void)areaView:(AEAreaView *)areaView selectIndex:(int)index{
    
    self.areaController.view.hidden = YES;
    
    int locationId = [[[areaView.areaList objectAtIndex:index] objectForKey:@"id"] intValue];
    
    self.areaLabel.text = [[areaView.areaList objectAtIndex:index] objectForKey:@"name"];
    
    self.colleageList.locationId = locationId;
    
    [self.colleageList getMostRecentSchools];
   
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
    
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [MobClick event:@"yqh026"];
    
    AEColleage *college = [_colleageList.schoolList objectAtIndex:indexPath.row];
    
    AEColleageDetailController *controller = [[AEColleageDetailController alloc]initWithColleageId:college.idStr];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
    
    //[self requestTodayHomeworkListRefresh];
    
    
    [self.colleageList getMostRecentSchools];
    
    self.colleageTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    [self.colleageList getPrevSchools];
    
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
    
    if ([dataEntries isKindOfClass:[AEAdList class]]) {
        
        [self showAdvertisInfo];
    }else{
        
        [self.colleageTableView reloadData];
    }
    
    [[DBNStatusView sharedDBNStatusView] dismiss];
    
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    [[DBNStatusView sharedDBNStatusView] showStatus:error dismissAfter:2];
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
    
    NSString *tmpUrl = [[ROOTURL stringByAppendingString:COLLEGEADINFO] stringByAppendingString:ad.tid];
    
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:tmpUrl];
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    /*
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
     */
}

@end
