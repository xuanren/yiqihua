//
//  AEArtStudioController.h
//  ArtExam
//
//  Created by chen on 15/8/7.
//  Copyright (c) 2015年 chen. All rights reserved.
//


#import "AEColleageViewController.h"
#import "AEImageTitleCell.h"
#import "AEColleageDetailController.h"
#import "DBNImageView.h"
#import "AESearchViewController.h"
#import "AEAdList.h"
#import "DBNUtils.h"
#import "DBNStatusView.h"
#import "AEStudioCollectionViewCell.h"
#import "ParseJson.h"
#import "PullCollectionView.h"
#import "DBNWebViewController.h"
#import "AEArtStudioDetailEViewController.h"


@interface AEArtStudioController : DBNViewController<UICollectionViewDataSource,UICollectionViewDelegate,DBNDataEntriesDelegate>
{
    UIScrollView *m_picScrollView;
    UIView *m_adView;
    UILabel *m_adTitleLabel;
    NSMutableArray *m_arrStudioList;
    UIPageControl *m_pageControl;
    PullCollectionView *m_collectionView;
}
@property (nonatomic, strong) AEAdList *adList;
@end
