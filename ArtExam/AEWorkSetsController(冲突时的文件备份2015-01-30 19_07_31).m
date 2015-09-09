//
//  AEWorkSetsController.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEWorkSetsController.h"
#import "AEWorkSetGridCell.h"
#import "AEWorkSetList.h"
#import "DBNStatusView.h"
#import "AEWorkSetDetailsController.h"

@interface AEWorkSetsController ()
<
GMGridViewDataSource
,GMGridViewActionDelegate
,UIScrollViewDelegate
,DBNDataEntriesDelegate
>

@property (nonatomic, strong) AEWorkSetList *workSetList;

@end

@implementation AEWorkSetsController

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
    
    [self.workSetList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    
    [gmGridView reloadData];
    
    self.workSetList = [[AEWorkSetList alloc]initWithAPIName:[DBNAPIList getWorkSetAPI]];
    self.workSetList.delegate = self;
    
    [self.workSetList getMostRecentWorkSets];
    [self.gmGridView reloadData];
    
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:235.0/255.0 alpha:1];
    
}

- (void)initNavItem{
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.navigationItem.title = @"精选图库";
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick event:@"yqh002"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    double cellCount = [self.workSetList.workSetArr count];
    return cellCount;
}

- (CGSize)sizeForItemsInGMGridView:(GMGridView *)gridView
{
    return   CGSizeMake(150, 130);
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return   CGSizeMake(150, 130);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
    // CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[AEWorkSetGridCell alloc]init];
        cell.backgroundColor = [UIColor redColor];
    }
    //    cell.backgroundColor = [UIColor redColor];
    
    [((AEWorkSetGridCell *)cell)configureWithWorkSet:[self.workSetList.workSetArr objectAtIndex:index]];
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return NO; //index % 2 == 0;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    AEWorkSet *tmp = (AEWorkSet *)[self.workSetList.workSetArr objectAtIndex:position];
    AEWorkSetDetailsController *controlller = [[AEWorkSetDetailsController alloc] initWithWorkSet:tmp];
    [self.navigationController pushViewController:controlller animated:YES];
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    
}


#pragma mark -
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
    CGFloat scrollPosition = scrollView.frame.size.height - (scrollView.contentSize.height - scrollView.contentOffset.y);
    if (scrollPosition >= 60.0 && !self.workSetList.isLoading) {
        [self.workSetList getPrevWorkSets];
    }

 }

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}

#pragma mark - DBNTopicListDelegate
- (void)dataEntriesLoaded:(DBNDataEntries *)dataEntries {
    [[DBNStatusView sharedDBNStatusView] dismiss];
    [self.gmGridView reloadData];
    
}

- (void)dataEntries:(DBNDataEntries *)dataEntries LoadError:(NSString *)error {
}



@end
