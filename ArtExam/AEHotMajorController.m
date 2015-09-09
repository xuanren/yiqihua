//
//  AEHotMajorController.m
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEHotMajorController.h"
#import "AETitleCell.h"
#import "AEHotMajorList.h"
#import "AEHotMajor.h"
#import "AEWebController.h"
#import "DBNWebViewController.h"

#import "AEEadress.h"   //校考
#import "AEEadressList.h"
@interface AEHotMajorController ()<DBNDataEntriesDelegate>

@property (nonatomic, strong) AEHotMajorList *hotMajorList; //热门专业
@property (nonatomic, strong) AEEadressList  *eadressList; // 校考

@end

static NSString *identifier = @"titleCell";

@implementation AEHotMajorController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.hotMajorList clearDelegateAndCancelRequests];
    [self.eadressList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_listTableVIew registerNib:[UINib nibWithNibName:@"AETitleCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    if (_isHotMajor) {
        self.hotMajorList = [[AEHotMajorList alloc] initWithAPIName:[DBNAPIList getHotMajorListAPI]];
        self.hotMajorList.delegate = self;
        [self.hotMajorList getMostRecentHotMajorList];
    } else{
        _eadressList = [[AEEadressList alloc]initWithAPIName:[DBNAPIList getEadressListAPI]];
        _eadressList.delegate = self;
        [_eadressList getMostRecentEadressList];
    }
 
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
    if (_isHotMajor) {
        self.navigationItem.title =@"热门专业";
    }else{
        self.navigationItem.title =@"考点查询";
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isHotMajor) {
        return [_hotMajorList.hotMajorAry count];
    }
    return [_eadressList.eadressListArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AETitleCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (_isHotMajor) {
        [cell configureWithHotMajor:[_hotMajorList.hotMajorAry objectAtIndex:indexPath.row]];
    }else{
        [cell configureWithEadress:[_eadressList.eadressListArr objectAtIndex:indexPath.row]];
    }
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 43;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *tmpUrl;
    if (_isHotMajor) {
        AEHotMajor *qb = [_hotMajorList.hotMajorAry objectAtIndex:indexPath.row];
        tmpUrl = [[ROOTURL stringByAppendingString:HOTMAJOR]stringByAppendingString:qb.idStr];
    }else{
        AEEadress *eadress = [_eadressList.eadressListArr objectAtIndex:indexPath.row];
        tmpUrl = [[ROOTURL stringByAppendingString:[DBNAPIList getEadressListContentAPI]] stringByAppendingString:eadress.eadressID];
    }
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:tmpUrl];
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    
    [self.listTableVIew reloadData];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

@end
