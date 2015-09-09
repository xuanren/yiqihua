//
//  AESetController.m
//  ArtExam
//
//  Created by dahai on 14-9-12.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AESetController.h"
#import "SYDLSetCell.h"
#import "AEFeedbackController.h"
#import "AEModifyPersonalInfoController.h"
#import "AEAboutUsVC.h"
#import "MobClick.h"
#import "DBNStatusView.h"
#import "DBNLoginViewController.h"

@interface AESetController ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *titleAry;

@property (weak, nonatomic) IBOutlet UITableView *setTableView;

@property (nonatomic, strong) UIAlertView *alerView;

@end

@implementation AESetController

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
    
    NSArray *array = [NSArray arrayWithObjects:@"个人资料", nil];
    NSArray *array1 = [NSArray arrayWithObjects:@"当前版本", nil];
    NSArray *array2 = @[@"给我们评分"];
    NSArray *array3 = @[@"关于我们"];
    NSArray *array4 = @[@"退出登录"];
    self.titleAry = [[NSMutableArray alloc] initWithObjects:array,array1,array2,array3, nil];
    
    if ([[DBNUser sharedDBNUser] isLoggedIn]) {
        
        [_titleAry addObject:array4];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    [super initNavItem];
    [super setCustomBackButton];
    self.navigationItem.title = @"设置";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//给我评分
- (void)giveMeTheScore
{
    NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d", 911325680];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

//检测新版本
- (void)newVersions
{
   
    [MobClick checkUpdate];
    [MobClick checkUpdateWithDelegate:self selector:@selector(isHavnNewVersion:)];
}

- (void)isHavnNewVersion:(NSDictionary *)info{
    
    if ([[info objectForKey:@"update"] intValue] == NO) {
        
            [[DBNStatusView sharedDBNStatusView] showStatus:@"当前已是最新版本" dismissAfter:3.0f];
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_titleAry count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger tempCount = [[_titleAry objectAtIndex:section] count];
    return tempCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"topcell";
    SYDLSetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        
        cell = [[SYDLSetCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    cell.isShowSwitch = NO;
    
    cell.titleLabel.text = [[self.titleAry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
            cell.isShowArrow = NO;
            cell.promptLabel.text = [NSString stringWithFormat:@"v-%@",[info objectForKey:(NSString *)kCFBundleVersionKey]];
        }
    }
    
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        
        [MobClick event:@"yqh042"];
        
        if (![DBNUser sharedDBNUser].loggedIn) {
            
            [self alertViewPrompt];
            return;
        }
        
        AEModifyPersonalInfoController *controller = [[AEModifyPersonalInfoController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
//            [self newVersions];
            return;
//            [MobClick event:@"yqh043"];
//            AEFeedbackController *controller = [[AEFeedbackController alloc]init];
//            [self.navigationController pushViewController:controller animated:YES];

        }else if (indexPath.row == 1){
            
            
            
        }
    }else if (indexPath.section == 2){
        
        [MobClick event:@"yqh044"];
        [self giveMeTheScore];
    }else if (indexPath.section == 3){
        
        [MobClick event:@"yqh045"];
        AEAboutUsVC *controller = [[AEAboutUsVC alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        
    }else if (indexPath.section == 4){
        
        [MobClick event:@"yqh046"];
        
        self.alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [_alerView show];
        
//        [[DBNUser sharedDBNUser] logout];
//        [_titleAry removeLastObject];
//        [tableView reloadData];
    }
}

- (void)alertViewPrompt{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册登录做有身份的小伙伴!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (_alerView == alertView) {
        
        if (buttonIndex == 0) {
            
            
        }else{
            
            [[DBNUser sharedDBNUser] logout];
            [_titleAry removeLastObject];
            [_setTableView reloadData];
        }
        
    }else{
        
        if (buttonIndex == 0) {
            
            
        }else{
            
            if (![DBNUser sharedDBNUser].loggedIn) {
                DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
                [self presentViewController:controller animated:YES completion:nil];
                return;
            }
        }
        
        
    }
    
}

@end
