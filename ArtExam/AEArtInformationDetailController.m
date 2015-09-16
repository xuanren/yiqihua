//
//  AEArtInformationDetailController.m
//  ArtExam
//
//  Created by renxuan on 15/9/5.
//  Copyright (c) 2015年 renxuan. All rights reserved.
//

#import "AEArtInformationDetailController.h"
#import "DBNDataEntries.h"
#import "DBNStatusView.h"
#import "DBNLoginViewController.h"
#import "DBNWebViewController.h"
@interface AEArtInformationDetailController ()<DBNDataEntriesDelegate>
{
    BOOL _isCollect;
}

@end

@implementation AEArtInformationDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationShareItemSearch];
    [self addNavigationCollectionItemSearch];
    
}
//添加分享按钮
-(void)addNavigationShareItemSearch
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"a_wenzhang_share"] style:UIBarButtonItemStylePlain target:self action:@selector(share_in_wechat_and_more)];
}
- (void)share_in_wechat_and_more
{
    NSLog(@"分享");
}
//添加收藏按钮
- (void)addNavigationCollectionItemSearch
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 26, 30, 30)];
    [rightBtn addTarget:self action:@selector(onClickCollect:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"a_wenzhang_like.png"] forState:UIControlStateNormal];
    
    [self.navigationController.view addSubview:rightBtn];

}
- (void)onClickCollect:(UIButton *)sender{
    
    [sender setImage:[UIImage imageNamed:@"a_wenzhang_like_sele.png"] forState:UIControlStateNormal];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [parameters setValue:@"studios" forKey:@"type"];
    
    if (_isCollect) {
        
        _isCollect = NO;
    }else{
        
        _isCollect = YES;
    }
    
    //    if (![DBNUser sharedDBNUser].loggedIn) {
    //
    //        [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能收藏" dismissAfter:3.0];
    //        return;
    //    }
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getCollectAPI] parameters:parameters needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id json) {
        
        if ([[json objectForKey:@"code"] intValue] == 0) {
            
            NSDictionary *data = [json objectForKey:@"data"];
            
            if ([[data objectForKey:@"state"] intValue] == 1) {
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"收藏成功" dismissAfter:3.0];
                
                [sender setImage:[UIImage imageNamed:@"a_wenzhang_like_sele.png"] forState:UIControlStateNormal];
            }else{
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"取消收藏" dismissAfter:3.0];
                [sender setImage:[UIImage imageNamed:@"a_wenzhang_like.png"] forState:UIControlStateNormal];
            }
            
        }else if ([[json objectForKey:@"code"] intValue] == 22){
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能收藏" dismissAfter:3.0];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
