//
//  AECirclesController.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AECirclesController.h"
#import "AEAppDelegate.h"
#import "AECircleCell.h"
#import "AECircleList.h"
#import "DBNUtils.h"
#import "AECircleTopicListController.h"

@interface AECirclesController ()
<
UITableViewDataSource
,UITableViewDelegate
,DBNDataEntriesDelegate
>

@property (nonatomic, weak) IBOutlet UITableView *circleTV;

@property  (nonatomic, strong) AECircleList *circleList;

@end

static NSString* cellIdentifier = @"AECircleCell";


@implementation AECirclesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.circleTV.delegate = self;
    self.circleTV.dataSource = self;
    
    [self.circleTV registerNib:[UINib nibWithNibName:@"AECircleCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.circleList = [[AECircleList alloc]initWithAPIName:[DBNAPIList getCircleListAPI]];
    self.circleList.delegate = self;
    [self.circleList getAllCircles];
    
    self.view.backgroundColor = [DBNUtils getColor:@"3e4651"];
    self.circleTV.backgroundColor = [UIColor clearColor];
    
    //self.navigationItem.title = @"圈子";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.circleTV reloadData];
    
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.rootNavController.navigationBarHidden = YES;
    [appDelegate.rootNavController setNavigationBarHidden:YES animated:YES];
}

- (void)initNavItem{
    
    [super initNavItem];
    
    //[super setCustomBackButton];
    self.navigationController.navigationItem.leftBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.circleList.circleArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AECircleCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithCircle:[self.circleList.circleArr objectAtIndex:indexPath.row]];
    
    if (indexPath.row%2 == 1) {
        cell.backgroundColor = [DBNUtils getColor:@"3e4651"];
    }else{
        cell.backgroundColor = [DBNUtils getColor:@"3a424d"];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;

    AECircle *circle = [self.circleList.circleArr objectAtIndex:indexPath.row];
    AECircleTopicListController *controller = [[AECircleTopicListController alloc]initWithCircle:circle];
    [appDelegate.rootNavController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    [self.circleTV reloadData];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

@end
