//
//  AEArtVInformationController.m
//  ArtExam
//
//  Created by renxuan on 15/8/19.
//  Copyright (c) 2015年 renxuan. All rights reserved.
//

#import "AEArtVInformationController.h"
#import "AEArtInformationViewCell.h"
#import "AEArtStudioDetailEViewController.h"
#import "ParseJson.h"
#import "DBNImageView.h"
#import "DBNWebViewController.h"
#import "LoadMoreTableFooterView.h"
#import "AEArtInformationDetailController.h"
#import "DBNStatusView.h"
#import "DBNDataEntries.h"


@interface AEArtVInformationController ()
@end

@implementation AEArtVInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    m_tableView =[[PullTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 70)];
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.pullDelegate = self;
    [self.view addSubview:m_tableView];

    NSDictionary *dic_all_info = [ParseJson parseJsonToDictionary:[NSURL URLWithString:@"http://www.yiqihua.cn/artbox/phone/newsList.do"]];
    m_arrInfos = [[NSMutableArray alloc]initWithCapacity:0];
    [m_arrInfos addObjectsFromArray:[dic_all_info objectForKey:@"rows"]];
    [self refreshTable];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return m_arrInfos.count ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - PullCTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.2f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:0.2f];
}
- (void)refreshTable
{
    m_tableView.pullTableIsRefreshing = NO;
    NSLog(@"refreshTableView");
}
- (void)loadMoreDataToTable
{
    NSString *str_url = [NSString stringWithFormat:@"http://www.yiqihua.cn/artbox/phone/newsList.do?pageNumber=%d",m_arrInfos.count/10+1];
    NSDictionary *dic_all_info = [ParseJson parseJsonToDictionary:[NSURL URLWithString:str_url]];
    [m_arrInfos addObjectsFromArray:[dic_all_info objectForKey:@"rows"]];
    [m_tableView reloadData];
    NSLog(@"loadMoreDataToTableView");
    m_tableView.pullTableIsLoadingMore = NO;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   
    AEArtInformationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[AEArtInformationViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dic_info = [m_arrInfos objectAtIndex:indexPath.row];
    NSString *str_img_url = [NSString stringWithFormat:@"http://www.yiqihua.cn/artbox/phone/idownload.do?fileid=%@",[dic_info objectForKey:@"cover"]];
    NSURL *imgUrl = [NSURL URLWithString:str_img_url];
    [cell.ImageView setImageWithURL:imgUrl placeholderImage:nil];
    cell.info.text = [dic_info objectForKey:@"title"];
    cell.readnumberprefix.text = @"阅读量 ";
    cell.readnumber.text = [[dic_info objectForKey:@"views"] stringValue];
    cell.date.text = [dic_info objectForKey:@"cdateString"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [MobClick event:@"yqh026"];
    NSDictionary *dic_info = [m_arrInfos objectAtIndex:indexPath.row];
    NSString *str_url = [NSString stringWithFormat:@"http://www.yiqihua.cn/artbox/phone/newsDetail.do?beanid=%@",[dic_info objectForKey:@"id"]];
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:str_url];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];

}

@end
