//
//  AEFindController.m
//  ArtExam
//
//  Created by dkllc on 14-9-2.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEFindController.h"
#import "AEFindTableViewCell.h"
#import "AEStudioViewController.h"
#import "AEColleageViewController.h"
#import "AEApplyForCertificationTeacherController.h"

@interface AEFindController ()
<
UITableViewDataSource
,UITableViewDelegate
>
@end

static NSString* cellIdentifier = @"AEFindTableViewCell";


@implementation AEFindController

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
    // Do any additional setup after loading the view from its nib.
    [self.findTV registerNib:[UINib nibWithNibName:@"AEFindTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.findTV.tableFooterView = footer;
    
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)initNavItem{
    [super initNavItem];
    self.navigationItem.title = @"发现";
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick event:@"yqh021"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AEFindTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
        {
            [MobClick event:@"yqh022"];
            cell.avatarImg.image = [UIImage imageNamed:@"find_studio.png"];
            cell.titleLbl.text = @"画室";
        }
            break;
        case 1:
        {
            [MobClick event:@"yqh023"];
            cell.avatarImg.image = [UIImage imageNamed:@"find_college.png"];
            cell.titleLbl.text = @"院校";

        }
            break;

        case 2:
        {
            [MobClick event:@"yqh024"];
            cell.avatarImg.image = [UIImage imageNamed:@"find_applyfor_teacher.png"];
            cell.titleLbl.text = @"申请认证老师";

        }
            break;

            
        default:
            break;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.section) {
        case 0:
        {
            AEStudioViewController *controller = [[AEStudioViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1:
        {
            AEColleageViewController *controller = [[AEColleageViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];

        }
            break;

        case 2:
        {
            AEApplyForCertificationTeacherController *controller = [[AEApplyForCertificationTeacherController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;

            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2.5;
}

@end
