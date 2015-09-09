//
//  AEQuestionDetailController.m
//  ArtExam
//
//  Created by dahai on 14-9-10.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEQuestionDetailController.h"
#import "AETCommentCell.h"
#import "AEQuestionDetailCell.h"
#import "AETeacherIntroController.h"
#import "PullTableView.h"
#import "AEAnswerList.h"
#import "AETeacherAnswerController.h"
#import "AECertificationHintView.h"
#import "AEApplyForCertificationTeacherController.h"
#import "DBNStatusView.h"
#import "AETeacherAnswerController.h"

@interface AEQuestionDetailController ()
<
DBNDataEntriesDelegate,
AECertificationHintViewDelegate
>
{
    float _upSlide;
}

@property (nonatomic, strong) AETeacherIntroController *tdController;
@property (nonatomic, strong) AEAnswerList *answerList;


@property (weak, nonatomic) IBOutlet PullTableView *deatilTableView;
@property (nonatomic) int questionId;


@end

static NSString* firstIdentifer = @"firstCell";

@implementation AEQuestionDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(instancetype)initWithQuestionId:(int)qId{
    self = [super init];
    if (self) {
        self.questionId = qId;
    }
    return self;
}


- (void)dealloc{
    
    [_tdController.view removeFromSuperview];
    
    //self.answerList.delegate = nil;
    [self.answerList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"问题详情";
    
    [self.deatilTableView registerNib:[UINib nibWithNibName:@"AEQuestionDetailCell" bundle:nil] forCellReuseIdentifier:firstIdentifer];
    
    self.tdController = [[AETeacherIntroController alloc]initWithNibName:@"AETeacherIntroController" bundle:nil];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [window addSubview:_tdController.view];
    _tdController.view.alpha = 0;
    
    self.answerList = [[AEAnswerList alloc]initWithAPIName:[DBNAPIList getQuestionDetailsAPI] andQUestionId:self.questionId];
    self.answerList.delegate = self;
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"加载中..."];

    [self refreshTable];
    
    self.deatilTableView.pullBackgroundColor = self.view.backgroundColor;

}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.answerList.answerArr count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"commentCell";
    AETCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (indexPath.row == 0) {
        
        AEQuestionDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:firstIdentifer forIndexPath:indexPath];
        cell.rootController = self;
        [cell configureWithQuestion:self.answerList.question];
        
        return cell;
    }
    
    if (cell == nil) {
        
        cell = [[AETCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        
    }
    
    if (indexPath.row > 0) {
        
        [cell updataQuestion:[self.answerList.answerArr objectAtIndex:indexPath.row - 1]];
    }
    
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        float height = [AEQuestionDetailCell heightForQuestionInfoCellWithQuestion:self.answerList.question];
        return height + 20 + 15;
    }else{
        
        float height = [AETCommentCell heightForCommentCellWithAnswer:[self.answerList.answerArr objectAtIndex:indexPath.row - 1]];
        
        return height + 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)] ;
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row > 0) {
        
        [_tdController configureWithTchInfo:[(AEAnswer *)[self.answerList.answerArr objectAtIndex:indexPath.row - 1] user]];
        
        _tdController.view.alpha = 1;
        
    }
    
    
}


#pragma mark -- Refresh and load more methods
- (void)refreshTable
{
    //显示刷新的时的时间
    //    self.homeworkTableView.pullLastRefreshDate = [NSDate date];
        
    [self.answerList getMostRecentAnswers];
    
    self.deatilTableView.pullTableIsRefreshing = NO;
}

- (void)loadMoreDataToTable
{
    
    [self.answerList getPrevAnswers];
    
    self.deatilTableView.pullTableIsLoadingMore = NO;
    
    
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

#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    [self.deatilTableView reloadData];
    
    [[DBNStatusView sharedDBNStatusView] dismiss];

}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}


- (IBAction)onClickAnswer:(UIButton *)sender {
    
    if ([[DBNUser sharedDBNUser] userRole] != AETeacher) {
        
        AECertificationHintView *hintView = [[[NSBundle mainBundle] loadNibNamed:@"AECertificationHintView" owner:nil options:nil] lastObject];
        
        hintView.type = Certification_Type;
        
        hintView.delegate = self;
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window addSubview:hintView];
    }else{
        
        AETeacherAnswerController *answerController = [[AETeacherAnswerController alloc] initWithQuestionId:self.answerList.question.questionId];
        [self.navigationController pushViewController:answerController animated:YES];
    }
}

#pragma mark -- AECertificationHintViewDelegate
- (void)selectType:(ChoiceType)type{
    
    if (type == Share_Type) {
        
        
    }else if (type == Certification_Type){
        
        AEApplyForCertificationTeacherController *controller = [[AEApplyForCertificationTeacherController alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_upSlide > scrollView.contentOffset.y) {
        
        [UIView animateWithDuration:0.5 animations:^{
           
            _answerView.alpha = 0;
            
        }];
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _answerView.alpha = 1;
            
        }];
    }
    
    if (scrollView.contentOffset.y == 0) {
        
        _answerView.alpha = 1;
    }
    
    _upSlide = scrollView.contentOffset.y;
}
@end
