//
//  AEHorizonPicsView.m
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEHorizonPicsView.h"
#import "GMGridViewLayoutStrategies.h"
#import "DBNImageView.h"
#import "UIImageView+AFNetworking.h"
#import "AEPicGridViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "DBNImageGallery.h"

@interface AEHorizonPicsView ()
<GMGridViewDataSource
,GMGridViewActionDelegate
>

@property (nonatomic) float cellHeight;
@property (nonatomic) float cellWidth;
@property (nonatomic ,strong) DBNImageGallery *imageGallery;

@end

//static const float paddingL = 10.0;
//static const float paddingT = 10.0;
//static const float spaceH =10.0;


@implementation AEHorizonPicsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit{
    self.gridView = [[GMGridView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
    _gridView.style = GMGridViewStylePush;
    _gridView.itemSpacing = 5;
    _gridView.minEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.cellHeight = self.frame.size.height - _gridView.minEdgeInsets.top - _gridView.minEdgeInsets.bottom;
    self.cellWidth = 90;
//    _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth;


    
    _gridView.centerGrid = NO;
    _gridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];
    _gridView.clipsToBounds = YES;
    _gridView.backgroundColor = [UIColor clearColor];
    _gridView.showsHorizontalScrollIndicator = NO;
    _gridView.mainSuperView = self;
    [self addSubview:_gridView];
    _gridView.dataSource = self;
    _gridView.actionDelegate = self;
    [_gridView reloadData];
    
    CGSize itemSize = [self GMGridView:self.gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    CGSize minSize  = CGSizeMake(itemSize.width  + _gridView.minEdgeInsets.right + _gridView.minEdgeInsets.left,
                                 itemSize.height + _gridView.minEdgeInsets.top   + _gridView.minEdgeInsets.bottom);
    
    
//    CGRect frame1 = CGRectMake(10, 10, minSize.width, self.view.bounds.size.height - minSize.height - 30);
    CGRect frame = CGRectMake(10, 0, self.bounds.size.width , minSize.height);
    self.gridView.frame = frame;
    
    self.numBg = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width - 30, (self.frame.size.height - 15)/2.0, 60, 15)];
    self.clipsToBounds = YES;
    self.numBg.backgroundColor = [UIColor blackColor];
    self.numBg.alpha = 0.5;
    self.numBg.layer.cornerRadius = 12.0;
    self.numBg.layer.masksToBounds = YES;
    
    self.numLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 30, 15)];
    self.numLbl.backgroundColor = [UIColor clearColor];
    self.numLbl.textColor = [UIColor whiteColor];
    self.numLbl.font = [UIFont systemFontOfSize:13.0];
    [self.numBg addSubview:self.numLbl];
    self.numLbl.textAlignment = NSTextAlignmentCenter;
    self.numLbl.text = @"3";
    
    [self addSubview:self.numBg];
}

- (void)setPicArr:(NSArray *)picArr{
    _picArr = picArr;
    
    if ([_picArr count] < 3) {
        self.numBg.hidden = YES;
    }else {
        self.numBg.hidden = NO;
        self.numLbl.text = [NSString stringWithFormat:@"%d张",[_picArr count]];
    }
    
    [self.gridView reloadData];
}

- (void)setElementWidth:(float)width{
    self.cellWidth = width;
    [_gridView reloadData];
    
    CGSize itemSize = [self GMGridView:self.gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    CGSize minSize  = CGSizeMake(itemSize.width  + _gridView.minEdgeInsets.right + _gridView.minEdgeInsets.left,
                                 itemSize.height + _gridView.minEdgeInsets.top   + _gridView.minEdgeInsets.bottom);
    
    CGRect frame = CGRectMake(10, 0, self.bounds.size.width , minSize.height);
    self.gridView.frame = frame;
}

#pragma mark GMGridViewDataSource

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [self.picArr count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(self.cellWidth, self.cellHeight);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[AEPicGridViewCell alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    }
    
    NSDictionary *tmpDic = [self.picArr objectAtIndex:index];
    [((AEPicGridViewCell *)cell)loadImgWithUrl:[tmpDic objectForKey:@"url"]];
    return cell;
}


- (BOOL)GMGridView:(GMGridView *)gridView canDeleteItemAtIndex:(NSInteger)index
{
    return NO;
}

#pragma mark GMGridViewActionDelegate
- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    if(!self.picArr) return;
    int index = position;
    NSMutableArray *orgPics = [[NSMutableArray alloc] initWithCapacity:[self.picArr count]];
    for (NSDictionary *dic in self.picArr) {
        [orgPics addObject:[dic objectForKey:@"url"]];
    }
    
    self.imageGallery = [[DBNImageGallery alloc] init];
    _imageGallery.isHiddenCollectBtn = YES;
    
    [self.imageGallery setImageArray:orgPics currentIndex:index andIsFromNet:YES];
    [self.imageGallery show];
    NSLog(@"taped");
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
}

- (void)GMGridView:(GMGridView *)gridView processDeleteActionForItemAtIndex:(NSInteger)index
{
}


@end
