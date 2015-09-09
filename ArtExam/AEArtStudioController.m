//
//  AEArtStudioController.m
//  ArtExam
//
//  Created by chen on 15/8/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "AEArtStudioController.h"
#import "AEArtVInformationController.h"

@interface AEArtStudioController ()
@end

@implementation AEArtStudioController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)registerCollectionCellClass
{
    for (int i = 0; i <= m_arrStudioList.count;  i ++)
    {
        if (i == 0)
        {
            [m_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%d",i]];
        }
        else
        {
            [m_collectionView registerClass:[AEStudioCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%d",i]];
        }
    }
}
- (void)InitCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    m_collectionView = [[PullCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 115) collectionViewLayout:layout];
    m_collectionView.delegate = self;
    m_collectionView.dataSource = self;
    m_collectionView.pullCollectionDelegate = self;
    m_collectionView.backgroundColor = [UIColor whiteColor];
    [self registerCollectionCellClass];
    m_collectionView.dataSource = self;
    m_collectionView.delegate = self;
    [self.view addSubview:m_collectionView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
   
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    [self initNavItem];
    [self createAdView];
    [self addNavigationRightItemSearch];
    
    UITapGestureRecognizer *tab_ad_recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerAd:)];
    [m_adView addGestureRecognizer:tab_ad_recognizer];
    UIPanGestureRecognizer *scroll_recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerAd:)];
    [m_picScrollView addGestureRecognizer:scroll_recognizer];
    
    NSDictionary *dic_all_studio_info = [ParseJson parseJsonToDictionary:[NSURL URLWithString:@"http://www.yiqihua.cn/artbox/studio/qlist.do"]];
    m_arrStudioList = [[NSMutableArray alloc]initWithCapacity:0];
    [m_arrStudioList addObjectsFromArray:[[dic_all_studio_info objectForKey:@"data"]objectForKey:@"studiosList"]];
    
    [self InitCollectionView];
    //获取广告列表
    self.adList = [[AEAdList alloc] initWithAPIName:[DBNAPIList getAdListAPI] andFrom:0];
    _adList.delegate = self;
    [_adList getadList];
    [self addNavigationInformation];
    
    }
- (void)createAdView
{
    m_adView = [[UIView alloc]initWithFrame:CGRectMake(0, -15, self.view.frame.size.width, 217)];
    m_picScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 145)];
    m_picScrollView.delegate = self;
    [m_adView addSubview:m_picScrollView];
    //广告标题
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 115, self.view.frame.size.width, 30)];
    [m_adView addSubview:titleView];
    m_pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(230, 121, 90, 21)];
    [m_adView addSubview:m_pageControl];
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    
    m_adTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 121, self.view.frame.size.width-28, 21)];
    [m_adView addSubview:m_adTitleLabel];
    
    //右
    UIView *t_titleViewBtnRt = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+5, 145, self.view.frame.size.width/2, 71)];
    [m_adView addSubview:t_titleViewBtnRt];
    t_titleViewBtnRt.backgroundColor = [UIColor clearColor];
    UILabel *t_m_UIbutText = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4, 155, 75, 40)];
    t_m_UIbutText.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    t_m_UIbutText.text = @"画室省份";
    t_m_UIbutText.textColor = [UIColor blackColor];
    
    UILabel *t_m_m_UIbutText = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4, 175, 75, 40)];
    t_m_m_UIbutText.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    t_m_m_UIbutText.text = @"按省份找画室";
    t_m_m_UIbutText.textColor = [UIColor grayColor];
    UIImageView *m_imageBtn = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+5+15, 157, 55, 55)];
    m_imageBtn.image = [UIImage imageNamed:@"artstudio_anshengfeng.png"];
    [m_adView addSubview:t_m_UIbutText];
    [m_adView addSubview:t_m_m_UIbutText];
    [m_adView addSubview:m_imageBtn];
}
//添加资讯跳转事件
-(void)addNavigationInformation
{
    UIButton *titleViewBtnRt = [[UIButton alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width/2-5, 71)];
    titleViewBtnRt.backgroundColor = [UIColor clearColor];
    [m_collectionView addSubview:titleViewBtnRt];

    [titleViewBtnRt addTarget:self action:@selector(jump_to_info) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *m_UIbutText = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4, 155, 75, 40)];
    m_UIbutText.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    m_UIbutText.text = @"画室资讯";
    m_UIbutText.textColor = [UIColor blackColor];
    
    UILabel *m_m_UIbutText = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4, 175, 75, 40)];
    m_m_UIbutText.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    m_m_UIbutText.text = @"画室最新动态";
    m_m_UIbutText.textColor = [UIColor grayColor];
    
    UIImageView *imageBtn = [[UIImageView alloc] initWithFrame:CGRectMake(15, 157, 55, 55)];
    imageBtn.image = [UIImage imageNamed:@"artstudio_huashizixun.png"];
    [m_adView addSubview:m_UIbutText];
    [m_adView addSubview:m_m_UIbutText];
    [m_adView addSubview:imageBtn];
}
- (void)jump_to_info
{
    AEArtVInformationController *controller = [[AEArtVInformationController alloc] init];
    controller.title = @"画室资讯";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

//添加搜索按钮
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
- (void)onClickSearch:(id)sender
{
    AESearchViewController *controller = [[AESearchViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)initNavItem{
    [super initNavItem];
    [self titleView];
}

- (void)titleView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    areaLabel.backgroundColor = [UIColor clearColor];
    areaLabel.textColor = [UIColor whiteColor];
    areaLabel.textAlignment = NSTextAlignmentCenter;
    areaLabel.font = [UIFont systemFontOfSize:20.f];
    areaLabel.text = @"画室精选";
    [titleView addSubview:areaLabel];
}
- (void)showAdvertisInfo{
    m_adTitleLabel.textColor = [DBNUtils getColor:@"33363B"];
    if ([_adList.adAry count] > 0) {
        m_adTitleLabel.text = [[_adList.adAry objectAtIndex:0] descStr];
    }
    m_pageControl.numberOfPages = [self.adList.adAry count];
    
    for (int i = 0; i < [self.adList.adAry count]; i++) {
        AEAdvertisement *ad = [self.adList.adAry objectAtIndex:i];
        NSString *url = ad.imgUrl;
        if (url != nil) {
            
            __block DBNImageView *tmpImg = [[DBNImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, 181)];
            UIImage *img = [UIImage imageNamed:@"a_home_loading"];
            [tmpImg setImageWithURL:[NSURL URLWithString:url] placeholderImage:img];
            [m_picScrollView addSubview:tmpImg];
        };
    }
    
    m_picScrollView.contentSize = CGSizeMake([self.adList.adAry count] * self.view.frame.size.width, m_picScrollView.frame.size.height);
}
#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    
    if ([dataEntries isKindOfClass:[AEAdList class]]) {
        
        [self showAdvertisInfo];
    }else{
        
        [m_collectionView reloadData];
    }
    
    [[DBNStatusView sharedDBNStatusView] dismiss];
    
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    [[DBNStatusView sharedDBNStatusView] showStatus:error dismissAfter:2];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int num = lroundf(scrollView.contentOffset.x/self.view.frame.size.width);
    m_pageControl.currentPage = num;
    
    AEAdvertisement *ad = [self.adList.adAry objectAtIndex:num];
    m_adTitleLabel.text = ad.descStr;
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (m_arrStudioList.count + 1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)indexPath.row;
    NSString* identifier = [NSString stringWithFormat:@"%d",row];
    
    if (row == 0)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
        }
        [cell addSubview:m_adView];
        return cell;
    }
    else
    {
        AEStudioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[AEStudioCollectionViewCell alloc]initWithFrame:CGRectMake(5, 0, self.view.frame.size.width/2-10, 145)];
        }
        
        [cell setCellInfo:[m_arrStudioList objectAtIndex:(indexPath.row - 1)]];
        return cell;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGSizeMake(self.view.frame.size.width, 130);
    }else
    {
        return CGSizeMake(self.view.frame.size.width/2 - 10,145);
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 定义左右cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//选中collectionviewcell的触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic_info = [m_arrStudioList objectAtIndex:indexPath.row-1];
    AEArtStudioDetailEViewController *viewController = [[AEArtStudioDetailEViewController alloc]initWithStudioInfoDictionary:dic_info];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
#pragma mark - PullCollectionViewDelegate
- (void)pullCollectionViewDidTriggerRefresh:(PullCollectionView*)pullCollectionView
{
    [self performSelector:@selector(refreshCollectionView) withObject:nil afterDelay:0.2f];
}
- (void)pullCollectionViewDidTriggerLoadMore:(PullCollectionView*)pullCollectionView
{
    [self performSelector:@selector(loadMoreDataToCollectionView) withObject:nil afterDelay:0.2f];
}
- (void)refreshCollectionView
{
    m_collectionView.pullTableIsRefreshing = NO;
    NSLog(@"refreshCollectionView");
}
- (void)loadMoreDataToCollectionView
{
    NSString *str_url = [NSString stringWithFormat:@"http://www.yiqihua.cn/artbox/studio/qlist.do?pageNumber=%d",m_arrStudioList.count/10+1];
    NSDictionary *dic_all_studio_info = [ParseJson parseJsonToDictionary:[NSURL URLWithString:str_url]];
    [m_arrStudioList addObjectsFromArray:[[dic_all_studio_info objectForKey:@"data"]objectForKey:@"studiosList"]];
    [self registerCollectionCellClass];
    [m_collectionView reloadData];
    NSLog(@"loadMoreDataToCollectionView");
    m_collectionView.pullTableIsLoadingMore = NO;
}
#pragma mark - 点击广告的事件
- (void)panGestureRecognizerAd:(UIPanGestureRecognizer *)panGestureRecognizer
{
    double speedX = [panGestureRecognizer velocityInView:panGestureRecognizer.view].x;
    double swipe_length = m_picScrollView.contentOffset.x;
    if (speedX>0 && swipe_length > m_picScrollView.frame.size.width/2)
    {
        [UIView animateWithDuration:0.3 animations:^{
            m_picScrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
    if (speedX<0&&swipe_length < m_picScrollView.frame.size.width/2)
    {
        [UIView animateWithDuration:0.3 animations:^{
            m_picScrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
        }];
    }
}
- (void)tapGestureRecognizerAd:(UITapGestureRecognizer *)sender {
    
    AEAdvertisement *ad = [_adList.adAry objectAtIndex:m_pageControl.currentPage];
    
    NSString *tmpUrl = [[ROOTURL stringByAppendingString:@"phone/adwareContent.do?beanid="] stringByAppendingString:ad.tid];
    
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:tmpUrl];
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    controller.hidesBottomBarWhenPushed = NO;
}

@end
