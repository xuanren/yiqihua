//
//  AEMyCollectionImageListController.m
//  ArtExam
//
//  Created by dahai on 14-10-13.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEMyCollectionImageListController.h"
#import "AEWorkGridCell.h"
#import "DBNImageGallery.h"

@interface AEMyCollectionImageListController ()<GMGridViewDataSource,GMGridViewActionDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)DBNImageGallery *imageGallery;
@property (nonatomic)int userId;

@end

@implementation AEMyCollectionImageListController
@synthesize gmGridView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUserId:(int)uid{
    
    self = [super init];
    if (self) {
        
        self.userId = uid;
    }
    return self;
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.title = @"收藏的图片";
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
    
    [self requestCollectImg];
    
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:235.0/255.0 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 网络请求
- (void)requestCollectImg{
    
    NSMutableDictionary *parametes = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    [parametes setValue:@(_userId) forKeyPath:@"uid"];
    [parametes setValue:@"images" forKeyPath:@"type"];
    [parametes setValue:@"0" forKeyPath:@"cursor"];
    [parametes setValue:@"20" forKeyPath:@"num"];
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getCollectListAPI] parameters:parametes needIdInfo:NO success:^(AFHTTPRequestOperation *opertion, id json) {
        
        NSLog(@"imgList ====== %@",json);
        if ([[json objectForKey:@"code"] intValue] == 0) {
            
            self.picArr = [[json objectForKey:@"data"] objectForKey:@"dataList"];
            
            [gmGridView reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *opertion, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [self.picArr count];
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
    
    NSString *tmp = [[self.picArr objectAtIndex:index] objectForKey:@"url"];
    [((AEWorkGridCell *)cell)setImgUrl:tmp];
    
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
    if(!self.picArr) return;
    int index = position;
    NSMutableArray *orgPics = [[NSMutableArray alloc] initWithCapacity:[self.picArr count]];
    for (NSDictionary *dic in self.picArr) {
        [orgPics addObject:[dic objectForKey:@"url"]];
    }
    
    self.imageGallery = [[DBNImageGallery alloc] init];
    
    [self.imageGallery setImageArray:orgPics currentIndex:index andIsFromNet:YES];
    [self.imageGallery show];
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    
}

@end
