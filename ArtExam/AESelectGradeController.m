//
//  AESelectGradeController.m
//  ArtExam
//
//  Created by dahai on 14-9-24.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AESelectGradeController.h"
#import "AESelectGradeCell.h"

@interface AESelectGradeController (){
    
    int _currIndex;
}

@property (nonatomic, strong) NSMutableArray *gradeList;

@property (weak, nonatomic) IBOutlet UITableView *gradeTableView;

@end


static NSString *identifer = @"gradeCell";
@implementation AESelectGradeController

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
    
    [self.gradeTableView registerNib:[UINib nibWithNibName:@"AESelectGradeCell" bundle:nil] forCellReuseIdentifier:identifer];
    
    [self requestGradeList];
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.title = @"选择年级";
    
    _currIndex = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 网络请求
- (void)requestGradeList{
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getGradeListAPI] parameters:nil needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id json) {
        
        self.gradeList = [[NSMutableArray alloc]initWithArray:[[json objectForKey:@"data"] objectForKey:@"positionList"]];
        [_gradeTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        

    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.gradeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AESelectGradeCell* cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    
    [cell configureWithGradeInfo:[self.gradeList objectAtIndex:indexPath.row]];
    
    if (_currIndex == indexPath.row) {
        
        cell.markImgView.hidden = NO;
    }else{
        
        cell.markImgView.hidden = YES;
    }
    
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    _currIndex = indexPath.row;
    
    [tableView reloadData];
    
    [DBNUser sharedDBNUser].position = [self.gradeList objectAtIndex:indexPath.row];
}

@end
