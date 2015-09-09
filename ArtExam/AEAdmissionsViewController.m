//
//  AEAdmissionsViewController.m
//  ArtExam
//
//  Created by Zhengen on 15-6-18.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "AEAdmissionsViewController.h"
#import "AETitleCell.h"
#import "AEAdmissionsList.h"
#import "AEAdmissions.h"
#import "AEWebController.h"
#import "DBNWebViewController.h"

@interface AEAdmissionsViewController ()<DBNDataEntriesDelegate>
@property (nonatomic, strong) AEAdmissionsList *admissionsList;
@end

static NSString *identifier = @"titleCell";

@implementation AEAdmissionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.admissionsList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_listTableView registerNib:[UINib nibWithNibName:@"AETitleCell" bundle:nil] forCellReuseIdentifier:identifier];

        _admissionsList = [[AEAdmissionsList alloc] initWithAPIName:[DBNAPIList getColleageIntroListAPI]];
        _admissionsList.delegate = self;
        [_admissionsList getMostRecentAdmissionsListWihtSid:_colleageID];
    
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

        self.navigationItem.title =@"招生简章";
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_admissionsList.admissionsAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AETitleCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

        [cell configureWithAdmissions:[_admissionsList.admissionsAry objectAtIndex:indexPath.row]];

    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 43;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *tmpUrl;

        AEAdmissions *admissions = [_admissionsList.admissionsAry objectAtIndex:indexPath.row];
        tmpUrl = [[ROOTURL stringByAppendingString:ADMISSIONSINFO]stringByAppendingString:admissions.idStr];

    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:tmpUrl];
    
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    
    [self.listTableView reloadData];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}


@end
