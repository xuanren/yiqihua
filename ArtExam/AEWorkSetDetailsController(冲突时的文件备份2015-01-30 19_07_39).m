//
//  AEWorkSetDetailsController.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEWorkSetDetailsController.h"
#import "AEWorkGridCell.h"
#import "DBNImageGallery.h"
#import "DBNStatusView.h"
#import "DBNLoginViewController.h"

@interface AEWorkSetDetailsController ()
<
GMGridViewDataSource
,GMGridViewActionDelegate
,UIScrollViewDelegate
>{
    
    BOOL _isCollect;
}

@property (nonatomic ,strong) DBNImageGallery *imageGallery;

@end

@implementation AEWorkSetDetailsController

@synthesize gmGridView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _isCollect = YES;
    }
    return self;
}

- (instancetype)initWithWorkSet:(AEWorkSet *)workSet{
    self = [super init];
    if (self) {
        self.workSet = workSet;
    }
    return self;
}

- (void)initNavItem{
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.navigationItem.title = @"画室";
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
    gmGridView.minEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    gmGridView.itemSpacing = 5 ;
    gmGridView.centerGrid = NO;
    gmGridView.actionDelegate = self;
    gmGridView.dataSource = self;
    gmGridView.editing = NO;
    
    [gmGridView reloadData];
    
    self.navigationItem.title = self.workSet.mydescription;
    
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:235.0/255.0 alpha:1];
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
    return [self.workSet.picArr count];
}

- (CGSize)sizeForItemsInGMGridView:(GMGridView *)gridView
{
    return   CGSizeMake(100, 100);
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return   CGSizeMake(100, 100);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    //NSLog(@"Creating view indx %d", index);
    
    // CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        cell = [[AEWorkGridCell alloc]init];
        cell.backgroundColor = [UIColor redColor];
    }
    //    cell.backgroundColor = [UIColor redColor];
    NSString *tempId = [[self.workSet.picArr objectAtIndex:index] objectForKey:@"id"];
    NSString *imgUrl = [[ROOTURL stringByAppendingString:IMGURL] stringByAppendingString:tempId];
    [((AEWorkGridCell *)cell)setImgUrl:imgUrl];
    
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
    
    if(!self.workSet.picArr) return;
    int index = position;
    NSMutableArray *orgPics = [[NSMutableArray alloc] initWithCapacity:[self.workSet.picArr count]];
    for (NSDictionary *dic in self.workSet.picArr) {
        NSString *urlStr = [[ROOTURL stringByAppendingString:IMGURL] stringByAppendingString:[dic objectForKey:@"id"]];
        [orgPics addObject:urlStr];
    }
    
    self.imageGallery = [[DBNImageGallery alloc] init];
    _imageGallery.isHiddenCollectBtn = NO;
    
    __weak AEWorkSetDetailsController *setC = self;
        self.imageGallery.buttonTaped = ^(int index){
            
            NSLog(@"查看的当前图片index：%d",index);
            NSString *abludId = [[setC.workSet.picArr objectAtIndex:index] objectForKey:@"id"];
            
            [setC collectAlubmId:abludId index:index];
        };
    
    self.imageGallery.scrollAction = ^(int index){
        
        NSLog(@"scoll === index  %d",index);
        
        NSDictionary *albumDic = [setC.workSet.picArr objectAtIndex:index];
        if ([[albumDic objectForKey:@"isFavorite"] intValue] == 1) {
         
            [setC.imageGallery.collectBtn setImage:[UIImage imageNamed:@"btn_collect.png"] forState:UIControlStateNormal];
        }else{
            
            
            [setC.imageGallery.collectBtn setImage:[UIImage imageNamed:@"btn_notToCollect.png"] forState:UIControlStateNormal];
        }
        
    };
    
    [self.imageGallery setImageArray:orgPics currentIndex:index andIsFromNet:YES];
    [self.imageGallery show];
    
    NSDictionary *albumDic = [self.workSet.picArr objectAtIndex:index];
    if ([[albumDic objectForKey:@"isFavorite"] intValue] == 1) {
        
        [self.imageGallery.collectBtn setImage:[UIImage imageNamed:@"btn_collect.png"] forState:UIControlStateNormal];
    }else{
        
        
        [self.imageGallery.collectBtn setImage:[UIImage imageNamed:@"btn_notToCollect.png"] forState:UIControlStateNormal];
    }
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    
}

#pragma mark -- 收藏
- (void)collectAlubmId:(NSString *)alubmId index:(int)index{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [parameters setValue:@"images" forKey:@"type"];
    [parameters setValue:alubmId forKey:@"tid"];
    
//    if (![DBNUser sharedDBNUser].loggedIn) {
//        
//        [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能收藏" dismissAfter:3.0];
//        return;
//    }
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        
        [self.imageGallery closeAction:nil];
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }

    NSMutableDictionary *albumDic = [self.workSet.picArr objectAtIndex:index];
    
    [albumDic setValue:@(1) forKeyPath:@"isFavorite"];
    [self.imageGallery.collectBtn setImage:[UIImage imageNamed:@"btn_collect.png"] forState:UIControlStateNormal];
   
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getCollectAPI] parameters:parameters needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id json) {
        
        if ([[json objectForKey:@"code"] intValue] == 0) {
            
            NSDictionary *data = [json objectForKey:@"data"];
            
            if ([[data objectForKey:@"state"] intValue] == 1) {
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"收藏成功" dismissAfter:3.0];
                [self.imageGallery.collectBtn setImage:[UIImage imageNamed:@"btn_collect.png"] forState:UIControlStateNormal];
            }else{
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"取消收藏" dismissAfter:3.0];
                [self.imageGallery.collectBtn setImage:[UIImage imageNamed:@"btn_notToCollect.png"] forState:UIControlStateNormal];
            }
            
        }else if ([[json objectForKey:@"code"] intValue] == 22){
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能收藏" dismissAfter:3.0];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


@end
