//
//  AETopicListController.m
//  ArtExam
//
//  Created by dkllc on 14-9-2.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AETopicListController.h"
#import "AEWorkSetDetailsController.h"
#import "AETopicList.h"
#import "AETopicListTableView.h"
#import "AEAppDelegate.h"
#import "DBNUtils.h"
#import "PPiFlatSegmentedControl.h"
#import "AETopic.h"
#import "AETopicListCell.h"
#import "AEWorkSetGridCell.h"
#import "AEWorkGridCell.h"
#import "AEWorkSetsController.h"
#import "AETopicDetailsController.h"
#import "DBNStatusView.h"
#import "GMGridView.h"
#import "AESegalView.h"

#import "AEWorkSetList.h"
#import "AEWorkSet.h"

@interface AETopicListController ()
<
DBNDataEntriesDelegate,
GMGridViewDataSource,
UIScrollViewDelegate,
GMGridViewActionDelegate
>

@property (nonatomic, strong) AETopicList *topicList;
@property (nonatomic) int defaultSelectedIndex;
@property (nonatomic, strong) GMGridView * gmGridView;
@property (nonatomic, strong) AEWorkSetList * workSetList;
@property (nonatomic, strong) NSArray * imgsArr;
@property (nonatomic, strong) NSArray * typesIdArr;
@property (nonatomic, strong) NSArray * titleNameArr;

@property (nonatomic, assign) TopicType currentType;
@end

static NSString* cellIdentifier = @"AEWorkSetGridCell";

@implementation AETopicListController
@synthesize gmGridView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.topicList clearDelegateAndCancelRequests];
    [self.workSetList clearDelegateAndCancelRequests];
}

- (void)initNavItem{
    [super initNavItem];
    self.navigationItem.title = @"话题";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    self.topicListTV.pullBackgroundColor = self.view.backgroundColor;
    
    [self.topicListTV registerNib:[UINib nibWithNibName:@"AEWorkSetGridCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.topicList = [[AETopicList alloc]initWithAPIName:[DBNAPIList getPostListAPI]];
    self.topicList.delegate = self;
    self.topicList.needLoadCache = YES;
    self.topicList.type = AETopicJinghua;

    [self refreshTable];
     
    [self addNavigationRightItem];
     
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.topicListTV.backgroundColor = [UIColor clearColor];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.topicListTV.frame.size.width, 0)];
    self.topicListTV.tableFooterView = footer;
    */
    
    gmGridView = [[GMGridView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    gmGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    gmGridView.backgroundColor = [UIColor clearColor];
    gmGridView.clipsToBounds = YES;
    gmGridView.delegate = self;
    [self.view addSubview:gmGridView];
    
    gmGridView.style = GMGridViewStyleSwap;
    gmGridView.minEdgeInsets = UIEdgeInsetsMake(7, 6, 6, 6);
    gmGridView.itemSpacing = 6 ;
    gmGridView.centerGrid = NO;
    gmGridView.actionDelegate = self;
    gmGridView.dataSource = self;
    gmGridView.editing = NO;

   //[gmGridView reloadData];
    
    self.workSetList = [[AEWorkSetList alloc]initWithAPIName:[DBNAPIList getWorkSetAPI]];
    self.workSetList.delegate = self;
    self.currentType = AETopicJinghua;
    self.workSetList.myType = AETopicJinghua;
    
    [self.workSetList getMostRecentWorkSets];
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"加载中"];

    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:235.0/255.0 alpha:1];
    
    [self createSegmentControl];
    [self initArrs];
}

-(void)initArrs{
    _imgsArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"cover_1"],[UIImage imageNamed:@"cover_2"],[UIImage imageNamed:@"cover_3"],[UIImage imageNamed:@"cover_4"],[UIImage imageNamed:@"cover_5"],[UIImage imageNamed:@"cover_6"],[UIImage imageNamed:@"cover_7"],[UIImage imageNamed:@"cover_8"], nil];
    _typesIdArr = [NSArray arrayWithObjects:@"4028dd814a2fc895014a2fd55af70010",@"4028dd814a2fc895014a2fd5a2d20011",@"8a7c9e234a66c95e014a6be9b5d70002",@"8a7c9e234a66c95e014a6beb3d540003",@"8a7c9e234a66c95e014a6bec64440004",@"8a7c9e234a66c95e014a6bed34f90005",@"8a7c9e234a66c95e014a6beff50d0006",@"8a7c9e234a66c95e014a6bf09db70007",nil];
    _titleNameArr = [NSArray arrayWithObjects:@"素描",@"速写",@"色彩",@"设计",@"试卷",@"水彩",@"描画",@"灵感", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
//    if (appDelegate.rootNavController == self.navigationController) {
//        appDelegate.rootNavController.navigationBarHidden = NO;
//    }
    
    [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
    //    appDelegate.rootNavController.navigationBarHidden = YES;
//    [appDelegate.rootNavController setNavigationBarHidden:YES animated:YES];
    
    [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}


#pragma mark - private methords
- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn addTarget:self action:@selector(openRightSide) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"quanzi_list.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;//c_post_one
}

- (void)openRightSide{
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:nil];

}

- (void)createSegmentControl{
//    PPiFlatSegmentedControl *segmented=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(0, 100, 150, 25) items:@[@{@"text":@"精选"},@{@"text":@"全部"},@{@"text":@"测试"}] iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
//        if (segmentIndex == 0)
//        {
//            self.topicList.type = AETopicJinghua;
//            [self refreshTable];
//        }else{
//            self.topicList.type = AETopicALL;
//            [self refreshTable];
//        }
//    }];
//    
//    if (self.defaultSelectedIndex == 1) {
//        [segmented setEnabled:YES forSegmentAtIndex:self.defaultSelectedIndex];
//        
//    }
////    segmented.color=[DBNUtils getColor:@"fc7a89"];
//    
//    segmented.color=[UIColor blackColor];
//
//    
//    //    segmented.color=[UIColor clearColor];
//    
//    segmented.borderWidth=1.0;
//    segmented.borderColor=[UIColor clearColor];
//    segmented.layer.cornerRadius = 12.5;
//    //    segmented.selectedColor=[DBNUtils getColor:@"6eac4e"];
//    
//    segmented.selectedColor=[DBNUtils getColor:@"8e9296"];
//    
//    
//    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:15],
//                               NSForegroundColorAttributeName:[UIColor whiteColor]};
//    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    AESegalView * view = [AESegalView segalViewWith:^(int selectedIndex) {
        switch (selectedIndex)
        {
            case 0:
            {
                self.currentType = AETopicJinghua;
                self.workSetList.myType = AETopicJinghua;
                if (_workSetList.workSetArr.count == 0) {
                    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"加载中"];
                    [self.workSetList getMostRecentWorkSets];
                }else{
                    [gmGridView reloadData];
                }
            }
                break;
            case 1:
            {
                self.currentType = AETopicRecommand;
                self.workSetList.myType = AETopicRecommand;
                if (_workSetList.workSetArrRecommand.count == 0) {
                    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"加载中"];
                    [self.workSetList getMostRecentWorkSets];
                }else{
                    [gmGridView reloadData];
                }
            }
                break;
            case 2:
            {
                self.currentType = AETopicALL;
                [gmGridView reloadData];
            }
                break;
            default:
                break;
        }

    }];

    self.navigationItem.titleView = view;
}

#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    UIViewController *controlller;
    if (_currentType == AETopicALL) {
        controlller = [[AEWorkSetsController alloc]initWithTitle:[self.titleNameArr objectAtIndex:position] withSelectId:[self.typesIdArr objectAtIndex:position]];
    }else if(_currentType == AETopicJinghua){
        AEWorkSet *tmp = (AEWorkSet *)[self.workSetList.workSetArr objectAtIndex:position];
        controlller = [[AEWorkSetDetailsController alloc] initWithWorkSet:tmp];
    }else if (_currentType == AETopicRecommand){
        AEWorkSet *tmp = (AEWorkSet *)[self.workSetList.workSetArrRecommand objectAtIndex:position];
        controlller = [[AEWorkSetDetailsController alloc] initWithWorkSet:tmp];
    }
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controlller animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    if (_currentType == AETopicJinghua) {
        return [self.workSetList.workSetArr count];
    }else if (_currentType == AETopicRecommand){
        return [self.workSetList.workSetArrRecommand count];
    }else if (_currentType == AETopicALL){
        return [_imgsArr count];
    }
    return 0;
}

- (CGSize)sizeForItemsInGMGridView:(GMGridView *)gridView
{
    CGSize itemSize;
    if (_currentType == AETopicALL) {
        itemSize = CGSizeMake(150, 150);
    }else{
        itemSize = CGSizeMake(150, 130);
    }
    return itemSize;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [self sizeForItemsInGMGridView:gridView];
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
    // CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    GMGridViewCell * cell;
    if (_currentType == AETopicALL) {
        cell = [gridView dequeueReusableCellWithIdentifier:@"classifyType"];
        if (!cell) {
            cell = [[AEWorkGridCell alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
            cell.backgroundColor = [UIColor clearColor];
        }
        [((AEWorkGridCell *)cell).imgView setImage:[self.imgsArr objectAtIndex:index]];
        
    }else{
        cell = [gridView dequeueReusableCellWithIdentifier:@"Type"];
        if (!cell) {
            cell = [[AEWorkSetGridCell alloc]init];
            cell.backgroundColor = [UIColor clearColor];
        }
        if (_currentType == AETopicJinghua) {
            [((AEWorkSetGridCell *)cell)configureWithWorkSet:[self.workSetList.workSetArr objectAtIndex:index]];
        }else if(_currentType == AETopicRecommand){
            [((AEWorkSetGridCell *)cell)configureWithWorkSet:[self.workSetList.workSetArrRecommand objectAtIndex:index]];
        }
    }
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return NO; //index % 2 == 0;
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollPosition = scrollView.frame.size.height - (scrollView.contentSize.height - scrollView.contentOffset.y);
    if (scrollPosition >= 60.0&&scrollView.isDragging) {
    }
    
    /*
     float offsetY = scrollView.contentOffset.y;
     BOOL isBouncing = (offsetY <= 0 ||
     scrollView.contentSize.height-offsetY <= scrollView.frame.size.height);
     if( isBouncing) { // 如果是bouncing，立刻返回
     _prevScrollViewOffsetY = offsetY;
     return;
     }
     
     CGRect scrollViewFrame = scrollView.frame;
     CGRect topViewFrame = topView.frame;
     if(offsetY > _prevScrollViewOffsetY) { // 向上滑动
     if(scrollViewFrame.origin.y > 0) {
     float deltaY = offsetY - _prevScrollViewOffsetY;
     deltaY=deltaY/2;
     if(scrollViewFrame.origin.y - deltaY < 0) { // 滑动距离过大
     deltaY = scrollViewFrame.origin.y;
     }
     scrollViewFrame.origin.y -= deltaY;
     scrollViewFrame.size.height += deltaY;
     topViewFrame.origin.y -= deltaY;
     
     topView.frame = topViewFrame;
     scrollView.frame = scrollViewFrame;
     }
     }
     else if(offsetY < _prevScrollViewOffsetY) { // 向下滑动
     if(topViewFrame.origin.y < 0) {
     float deltaY = _prevScrollViewOffsetY - offsetY;
     deltaY=deltaY/2;
     if(deltaY+topViewFrame.origin.y > 0) { // 滑动距离过大
     deltaY = -topViewFrame.origin.y;
     }
     scrollViewFrame.origin.y += deltaY;
     scrollViewFrame.size.height -= deltaY;
     topViewFrame.origin.y += deltaY;
     
     topView.frame = topViewFrame;
     scrollView.frame = scrollViewFrame;
     }
     }
     _prevScrollViewOffsetY = offsetY;
     */
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_currentType == AETopicALL) {
        return;
    }
    CGFloat scrollPosition = scrollView.frame.size.height - (scrollView.contentSize.height - scrollView.contentOffset.y);
    if (scrollPosition >= 60.0 && !self.workSetList.isLoading) {
        [self.workSetList getPrevWorkSets];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    double cellCount = [self.topicList.topicArr count];
    return cellCount;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AETopicListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithTopic:[self.topicList.topicArr objectAtIndex:indexPath.row]];
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
    
    AETopic *topic = [self.topicList.topicArr objectAtIndex:indexPath.row];
    
    AETopicDetailsController *controller = [[AETopicDetailsController alloc]initWithPostId:topic.topicId];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [AETopicListCell heightForTopicListCellWithTopic:[self.topicList.topicArr objectAtIndex:indexPath.row]];
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
    [self.gmGridView reloadData];
    [[DBNStatusView sharedDBNStatusView] dismiss];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    [[DBNStatusView sharedDBNStatusView] showStatus:error dismissAfter:2];
}

@end
