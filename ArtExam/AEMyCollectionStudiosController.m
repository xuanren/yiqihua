//
//  AEMyCollectionStudiosController.m
//  ArtExam
//
//  Created by dkllc on 14-9-21.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEMyCollectionStudiosController.h"
#import "AEStudioList.h"
#import "AEStudioCell.h"
#import "AEStudioDetailsController.h"

@interface AEMyCollectionStudiosController ()
<
UITableViewDelegate
,UITableViewDataSource
,DBNDataEntriesDelegate
>

@property (nonatomic) int userId;
@property (nonatomic, strong) AEStudioList *studioList;
@property (nonatomic, weak) IBOutlet UITableView *studioTV;

@end

static NSString* cellIdentifier = @"AEStudioCell";


@implementation AEMyCollectionStudiosController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithUID:(int)uId{
    self = [super init];
    if (self) {
        self.userId = uId;
    }
    return self;
}

- (void)dealloc{
    
    [self.studioList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.studioList = [[AEStudioList alloc]initWithAPIName:[DBNAPIList getCollectListAPI]];
    self.studioList.delegate = self;
    [self.studioList getMyStudiosWithUserId:self.userId];
    
    [self.studioTV registerNib:[UINib nibWithNibName:@"AEStudioCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.title = @"收藏的画室";
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
    return [self.studioList.studioArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AEStudioCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithStudio:[self.studioList.studioArr objectAtIndex:indexPath.row]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AEStudio *studio = [self.studioList.studioArr objectAtIndex:indexPath.row];
    
    AEStudioDetailsController *controller = [[AEStudioDetailsController alloc]initWithStudioId:studio.studioId];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


#pragma mark - DBNTopicListDelegate
- (void)dataEntriesLoaded:(DBNDataEntries *)dataEntries {
    [self.studioTV reloadData];
    
}

- (void)dataEntries:(DBNDataEntries *)dataEntries LoadError:(NSString *)error {
}


@end
