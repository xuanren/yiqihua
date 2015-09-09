//
//  AEMatriculateViewController.h
//  ArtExam
//
//  Created by Zhengen on 15-6-10.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "AEMatriculateViewController.h"
#import "AETitleCell.h"
#import "AEMatriculateList.h"
#import "AEMatriculate.h"
#import "AEWebController.h"
#import "DBNWebViewController.h"

@interface AEMatriculateViewController ()<DBNDataEntriesDelegate>
@property (nonatomic, strong) AEMatriculateList *matriculateList;
@end

static NSString *identifier = @"titleCell";

@implementation AEMatriculateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.matriculateList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_listTableView registerNib:[UINib nibWithNibName:@"AETitleCell" bundle:nil] forCellReuseIdentifier:identifier];

        _matriculateList = [[AEMatriculateList alloc] initWithAPIName:[DBNAPIList getMatriculateAPI]];
        _matriculateList.delegate = self;
        [_matriculateList getMostRecentMatriculateListWihtSid:_colleageID];
    
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

        self.navigationItem.title =@"录取规则";
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_matriculateList.matriculateAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AETitleCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
        [cell configureWithMatriculate:[_matriculateList.matriculateAry objectAtIndex:indexPath.row]];

    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 43;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *tmpUrl;

        AEMatriculate *matr = [_matriculateList.matriculateAry objectAtIndex:indexPath.row];
        tmpUrl = [[ROOTURL stringByAppendingString:MATRICINFO]stringByAppendingString:matr.idStr];

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
