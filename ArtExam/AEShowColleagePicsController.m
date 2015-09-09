//
//  AEShowColleagePicsController.m
//  ArtExam
//
//  Created by dkllc on 14-9-21.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEShowColleagePicsController.h"
#import "AEWorkGridCell.h"
#import "DBNImageGallery.h"

@interface AEShowColleagePicsController ()
<
GMGridViewDataSource
,GMGridViewActionDelegate
,UIScrollViewDelegate
>
@property (nonatomic, strong)DBNImageGallery *imageGallery;

@end

@implementation AEShowColleagePicsController

@synthesize gmGridView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithWorkSet:(NSArray *)picArr{
    self = [super init];
    if (self) {
        self.picArr = picArr;
    }
    return self;
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

    
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:235.0/255.0 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
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
    NSString *tmp = [[self.picArr objectAtIndex:index] objectForKey:@"id"];
    //[((AEWorkGridCell *)cell) setImgUrl:tmp];
    [((AEWorkGridCell *) cell) configureWithWorkSet:[self.picArr objectAtIndex:index]];
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
        NSString * imgUrl = [[ROOTURL stringByAppendingString:IMGDOWNLOADURL] stringByAppendingString:[dic objectForKey:@"id"]];
        [orgPics addObject:imgUrl];
    }
    
    self.imageGallery = [[DBNImageGallery alloc] init];    
    
    [self.imageGallery setImageArray:orgPics currentIndex:index andIsFromNet:YES];
    [self.imageGallery show];
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    
}


@end
