//
//  AEQuestionBankAndHotController.m
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEQuestionBankAndHotController.h"
#import "AETitleCell.h"
#import "AEQuestionBankList.h"
#import "AEQuestionBank.h"
#import "AEWebController.h"
#import "DBNWebViewController.h"
#import "AEColleageIntroList.h"
@interface AEQuestionBankAndHotController ()<DBNDataEntriesDelegate>

@property (nonatomic, strong) AEQuestionBankList *questionList;
@property (nonatomic, strong) AEColleageIntroList *colleageIntroList;

@end

static NSString *identifier = @"titleCell";

@implementation AEQuestionBankAndHotController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.questionList clearDelegateAndCancelRequests];
    [self.colleageIntroList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_listTableView registerNib:[UINib nibWithNibName:@"AETitleCell" bundle:nil] forCellReuseIdentifier:identifier];

    
    // ** _isColleageIntroList来指定：加载题库or简章列表
    if (!_isColleageIntroList) {
        //往年考题
        self.questionList = [[AEQuestionBankList alloc] initWithAPIName:[DBNAPIList getQuestionBankAPI]];
        self.questionList.delegate = self;
        self.questionList.colleageID = _colleageID;
        [self.questionList getMostRecentQuestionList];
    }else {
        //招生简章
        _colleageIntroList = [[AEColleageIntroList alloc] initWithAPIName:[DBNAPIList getColleageIntroListAPI]];
        _colleageIntroList.delegate = self;
        [_colleageIntroList getMostRecentIntroListWihtSid:_colleageID];
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
    if (_isColleageIntroList) {
        self.navigationItem.title =@"简章";
    }else{
        self.navigationItem.title =@"考题库";
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_isColleageIntroList) {
        return [_colleageIntroList.colleageIntroListArr count];
    }
    return [_questionList.questionBankAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AETitleCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (_isColleageIntroList) {
        [cell configureWithColleageIntro:[_colleageIntroList.colleageIntroListArr objectAtIndex:indexPath.row]];
    }else{
        [cell configureWithQuestionBank:[_questionList.questionBankAry objectAtIndex:indexPath.row]];
    }

    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 43;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *tmpUrl;
    if (_isColleageIntroList) {
        //简章
        AEColleageIntro *inTro = [_colleageIntroList.colleageIntroListArr objectAtIndex:indexPath.row];
       // paraStr = inTro. ;
    }else{
        //题库
        AEQuestionBank *qb = [_questionList.questionBankAry objectAtIndex:indexPath.row];
        tmpUrl = [[ROOTURL stringByAppendingString:EXAMINFO]stringByAppendingString:qb.idStr];
    }
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
