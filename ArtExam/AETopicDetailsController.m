//
//  AETopicDetailsController.m
//  ArtExam
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AETopicDetailsController.h"
#import "AETopicCommentCell.h"
#import "AETopicDetailsCell.h"
#import "AECommentList.h"
#import "AETopicCommentController.h"
#import "AETopicCommentController.h"
#import "DBNSnsShareController.h"
#import "AEAppDelegate.h"
#import "DBNStatusView.h"
#import "DBNLoginViewController.h"

@interface AETopicDetailsController ()
<
UITableViewDelegate
,UITableViewDataSource
,DBNDataEntriesDelegate
>

@property (nonatomic, strong) AECommentList *commentList;
@property (nonatomic, strong) DBNSnsShareController *shareController;
@property (nonatomic, weak) IBOutlet UIButton *phraiseBtn;
@property (nonatomic, weak) IBOutlet UIView *bottomView;
@property (nonatomic)     BOOL animationFinished;


@end

static NSString* cellIdentifier1 = @"AETopicDetailsCell";
static NSString* cellIdentifier2 = @"AETopicCommentCell";


@implementation AETopicDetailsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithPostId:(int)pId{
    self = [super init];
    if (self) {
        self.postId = pId;
    }
    return self;
}

- (void)dealloc{
    
    [self.commentList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.commentTV registerNib:[UINib nibWithNibName:@"AETopicDetailsCell" bundle:nil] forCellReuseIdentifier:cellIdentifier1];
    
    [self.commentTV registerNib:[UINib nibWithNibName:@"AETopicCommentCell" bundle:nil] forCellReuseIdentifier:cellIdentifier2];
    
    self.commentTV.dataSource = self;
    self.commentTV.delegate = self;
    
    [self.commentTV setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    self.commentList = [[AECommentList alloc]initWithAPIName:[DBNAPIList getPostDetailsAPI] andPostId:self.postId];
    self.commentList.delegate = self;
    [self.commentList getMostRecentComments];
    
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"加载中"];
    
    self.animationFinished = YES;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AEAppDelegate *appDelegate = (AEAppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.rootNavController == self.navigationController) {
        appDelegate.rootNavController.navigationBarHidden = NO;
    }
    
}

- (void)initNavItem{
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.navigationItem.title = @"话题详情";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction methords
- (IBAction)commentAction:(id)sender{
    
//    if (![DBNUser sharedDBNUser].loggedIn) {
//        
//        [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能评论哦" dismissAfter:3.0];
//        return;
//    }
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }

    
    AETopicCommentController *controller = [[AETopicCommentController alloc]initWithPostId:self.postId];
    controller.BackAction = ^(UIViewController *controller){
        [self.commentList getMostRecentComments];
        [controller.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)phraseAction:(id)sender{
    
//    if (![DBNUser sharedDBNUser].loggedIn) {
//        
//        [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能给赞哦！" dismissAfter:3.0];
//        return;
//    }
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.postId) forKey:@"postId"];
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList phrasePostAPI] parameters:params needIdInfo:YES success:^(AFHTTPRequestOperation *operation, id JSON) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError * erorr) {
        
    }];
    
    self.phraiseBtn.selected = !self.phraiseBtn.selected;
}

- (IBAction)shareAction:(id)sender{
    
//    if (![DBNUser sharedDBNUser].loggedIn) {
//        
//        [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能分享哦" dismissAfter:3.0];
//        return;
//    }
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }

    
    NSMutableDictionary *shareInfo = [NSMutableDictionary dictionary];
    if (self.commentList.topic.content != nil) {
        [shareInfo setObject:self.commentList.topic.content forKey:@"content"];
    }
    if (self.commentList.topic.title != nil) {
        [shareInfo setObject:self.commentList.topic.title forKey:@"title"];

    }
    
    
    if (!self.shareController) {
        self.shareController  = [[DBNSnsShareController alloc]initWithRootController:self andShareImg:nil andShareIno:shareInfo];
    }
    
    [self.shareController showShareMyView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commentList.commentArr count] + 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        AETopicDetailsCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1 forIndexPath:indexPath];
        cell.rootController = self;
        [cell configureWithTopic:self.commentList.topic];
        return cell;
    }
    
    AETopicCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
    cell.rootController = self;
//    [cell configureWithTopic:self.commentList.topic];
    AEComment *comment = [self.commentList.commentArr objectAtIndex:indexPath.row - 1];
    [cell configureWithComment:[self.commentList.commentArr objectAtIndex:indexPath.row -1]];
    
    
    
    cell.replyButtonDidPressed = ^{
        AETopicCommentController *controller = [[AETopicCommentController alloc] initWithPostId:self.postId andCommentId:comment.commentId];
        controller.BackAction = ^( UIViewController *controller){
            [controller.navigationController popViewControllerAnimated:YES];
            [self.commentList getMostRecentComments];
        };
        [self.navigationController pushViewController:controller animated:YES];
    };

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
       return  [AETopicDetailsCell heightForTopicDetailCellWithTopic:self.commentList.topic];
    }
    
    return [AETopicCommentCell heightForTopicDetailCellWithComment:[self.commentList.commentArr objectAtIndex:indexPath.row - 1]];
}

#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
    
    //[self requestTodayHomeworkListRefresh];
    
    [self.commentList getMostRecentComments];
    
    self.commentTV.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    
    NSLog(@"vvvvvvv");
    
}


#pragma mark -- 下拉刷新和上拉加载 PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.2f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:0.2f];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    float offsetY = scrollView.contentOffset.y;
    
//    CGFloat scrollPosition = scrollView.frame.size.height - (scrollView.contentSize.height - scrollView.contentOffset.y);
//    if (scrollPosition >= 60.0) {
//        //to do
//    }
    
    if(offsetY > _prevScrollViewOffsetY) { // 向上滑动
        
        if (self.animationFinished) {
            CGRect tmp = self.bottomView.frame;
            tmp.origin.y = self.view.frame.size.height;
            self.animationFinished = NO;
            [UIView animateWithDuration:0.5 animations:^{
                self.bottomView.frame = tmp;
            } completion:^(BOOL finished) {
                self.animationFinished = YES;
            }];
        }
    }
    else if(offsetY < _prevScrollViewOffsetY) { // 向下滑动
        if (self.animationFinished) {
            CGRect tmp = self.bottomView.frame;
            tmp.origin.y = self.view.frame.size.height - self.bottomView.frame.size.height;
            self.animationFinished = NO;
            [UIView animateWithDuration:0.5 animations:^{
                self.bottomView.frame = tmp;
            } completion:^(BOOL finished) {
                self.animationFinished = YES;
            }];
        }
    }
    
    if (scrollView.contentOffset.y == 0) {
        
        CGRect tmp = self.bottomView.frame;
        tmp.origin.y = self.view.frame.size.height - self.bottomView.frame.size.height;
        self.animationFinished = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomView.frame = tmp;
        } completion:^(BOOL finished) {
            self.animationFinished = YES;
        }];
    }
    
    _prevScrollViewOffsetY = offsetY;
    
}


#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    [[DBNStatusView sharedDBNStatusView] dismiss];
    if (self.commentList) {
        if (self.commentList.topic.isPhraised) {
            self.phraiseBtn.selected = YES;
        }else{
            self.phraiseBtn.selected = NO;
        }
        
        self.circleId = self.commentList.topic.circleId;
    }
    
    [self.commentTV reloadData];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    [[DBNStatusView sharedDBNStatusView] dismiss];
}


@end
