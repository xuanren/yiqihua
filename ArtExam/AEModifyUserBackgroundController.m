//
//  AEModifyUserBackgroundController.m
//  ArtExam
//
//  Created by dahai on 14-10-13.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEModifyUserBackgroundController.h"
#import "AEWorkGridCell.h"
#import "DBNImageGallery.h"
#import "DBNStatusView.h"

@interface AEModifyUserBackgroundController ()<GMGridViewDataSource,GMGridViewActionDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)DBNImageGallery *imageGallery;

@property (nonatomic, strong)NSString *index;
@end

@implementation AEModifyUserBackgroundController
@synthesize gmGridView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.title = @"背景图片";
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
    gmGridView.minEdgeInsets = UIEdgeInsetsMake(6, 0, 6, 0);
    gmGridView.itemSpacing = 10 ;
    gmGridView.centerGrid = NO;
    gmGridView.actionDelegate = self;
    gmGridView.dataSource = self;
    gmGridView.editing = NO;
    
    self.picArr = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 9; i ++) {
        
        NSString *imgName = [NSString stringWithFormat:@"userCenter_background_0%d.jpg",i+1];
        [_picArr addObject:imgName];
    }
    
    [gmGridView reloadData];
    self.view.backgroundColor = [UIColor lightGrayColor];
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
    
    NSString *tmp = [self.picArr objectAtIndex:index];
    [((AEWorkGridCell *)cell)setImgName:tmp];
    
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
    NSString *imgIndex = [NSString stringWithFormat:@"%d",position+1];
    
    self.index = imgIndex;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认修改背景图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}

- (void)GMGridViewDidTapOnEmptySpace:(GMGridView *)gridView
{
    
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        
    }else if(buttonIndex == 1){
        
        [[NSUserDefaults standardUserDefaults] setValue:_index forKeyPath:@"imgIndex"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
