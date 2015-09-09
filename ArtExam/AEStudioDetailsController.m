//
//  AEStudioDetailsController.m
//  ArtExam
//
//  Created by dkllc on 14-9-11.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEStudioDetailsController.h"
#import "AEStudio.h"
#import "AETopic.h"
#import "AETopicListCell.h"
#import "AETopicDetailsController.h"
#import "UIImageView+AFNetworking.h"
#import "DBNUtils.h"
#import "AEShowColleagePicsController.h"
#import "AENewTopicController.h"
#import "DBNImageView.h"
#import "AEAdList.h"
#import "AEWorkSetsController.h"
#import "AETopicDetailsController.h"
#import "AEQuestionDetailController.h"
#import "AEColleageDetailController.h"
#import "AEWebController.h"
#import "DBNStatusView.h"
#import "DBNLoginViewController.h"
#import "DBNWebViewController.h"

@interface AEStudioDetailsController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,DBNDataEntriesDelegate>{
    
    BOOL _isCollect;
}

@property (nonatomic, weak) IBOutlet UIScrollView *container;
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UILabel *timeLbl;
@property (nonatomic, weak) IBOutlet UILabel *scaleLbl;
@property (nonatomic, weak) IBOutlet UILabel *addressLbl;
@property (nonatomic, weak) IBOutlet UILabel *phoneLbl;
@property (nonatomic, weak) IBOutlet UITableView *topicsTV;
@property (nonatomic, weak) IBOutlet UIView *topView;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet M80AttributedLabel *picNumLbl;
@property (nonatomic, weak) IBOutlet UIScrollView *picSV;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *personValueView;
@property (weak, nonatomic) IBOutlet UILabel *personValueLabel;
@property (nonatomic ,strong) DBNImageGallery *imageGallery;

@property (nonatomic, strong) NSMutableArray *postArr;
@property (nonatomic, strong) AEStudio *studio;

@property (nonatomic, strong) AEAdList *adList;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *studioIntroView;
@property (weak, nonatomic) IBOutlet UIView *worksView;
@property (weak, nonatomic) IBOutlet UIView *lineView;


- (IBAction)onClickStudioIntro:(id)sender;

@end

static NSString* cellIdentifier = @"AETopicListCell";

@implementation AEStudioDetailsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _isCollect = YES;
    }
    return self;
}

- (instancetype)initWithStudioId:(int)sId{
    self = [super init];
    if (self) {
        self.studioId = sId;
    }
    
    return self;
}

- (void)dealloc{
    
    [self.adList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.personValueView.clipsToBounds = YES;
    self.personValueView.layer.cornerRadius = 12.f;
    self.personValueView.layer.masksToBounds = YES;
    
    //获取广告列表
    self.adList = [[AEAdList alloc] initWithAPIName:[DBNAPIList getAdListAPI] andFrom:2];
    _adList.delegate = self;
    [_adList getadList];
    
    
    [self.topicsTV registerNib:[UINib nibWithNibName:@"AETopicListCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.topicsTV.dataSource = self;
    self.topicsTV.delegate = self;
    
    self.topicsTV.scrollEnabled = NO;
    self.topicsTV.backgroundColor = [UIColor clearColor];
    
    self.picSV.pagingEnabled = YES;
    self.picSV.delegate = self;
    
    [self.topicsTV setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    //[self addNavigationRightItemCollect];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.studioId) forKey:@"studioId"];
    
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"加载中..."];

    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getStudioDetailsAPI] parameters:params needIdInfo:YES success:^(AFHTTPRequestOperation *operation, id JSON) {
        if ([[JSON objectForKey:@"code"] intValue] != 0) {
            NSLog(@"[%@]:%@",[DBNAPIList getStudioDetailsAPI],[JSON objectForKey:@"error"]);
            return ;
        }
        
        self.studio = [[AEStudio alloc]initWithAttributes:[[JSON objectForKey:@"data"] objectForKey:@"studio"]];
        
        NSArray *tmpArr = [[[JSON objectForKey:@"data"] objectForKey:@"studio"]objectForKey:@"posts"];
        self.postArr = [self getObjectsFromNSArray:tmpArr];
        NSLog(@"json:%@",JSON);
        
        [self showStudioInfo];
        
        [[DBNStatusView sharedDBNStatusView] dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
#ifdef DEBUG
        NSLog(@"error:（%@）:%@",[DBNAPIList getStudioDetailsAPI],error);
#endif

        [[DBNStatusView sharedDBNStatusView] dismiss];
    }];
}

- (void)initNavItem{
    [super initNavItem];
    
    [super setCustomBackButton];
    self.navigationItem.title = @"画室详情";
}

- (void)addNavigationRightItemCollect
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn addTarget:self action:@selector(onClickCollect:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"btn_notToCollect.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)showStudioInfo{
    self.nameLbl.text = self.studio.name;
    self.scaleLbl.text = [NSString stringWithFormat:@"%d",self.studio.scale];
    self.timeLbl.text = self.studio.startTime;
    self.addressLbl.text = [NSString stringWithFormat:@"画室地址：%@",self.studio.address];
    self.phoneLbl.text = [NSString stringWithFormat:@"联系电话：%@",self.studio.phone];
    
    self.personValueLabel.text = [NSString stringWithFormat:@"人气值：%lld",self.studio.popularity];
    
    [self.topicsTV reloadData];
    
    if (self.studio.isFavorite == 1) {
        
        [_collectBtn setImage:[UIImage imageNamed:@"studio_colect_pre.png"] forState:UIControlStateNormal];
    }
    
    //self.pageControl.numberOfPages = [self.studio.picArr count];
    
    if ([self.studio.picArr count]) {
        NSDictionary *tmp = [self.studio.picArr objectAtIndex:0];
        [self.imgView setImageWithURL:[NSURL URLWithString:[tmp objectForKey:@"url"]]];
    }
    
//    self.picNumLbl.text = [NSString stringwi];
    
    NSArray *colors = [NSArray arrayWithObjects:[DBNUtils getColor:@"ed561e"],[DBNUtils getColor:@"7f7f7f"], nil];
    NSString *tmpStr = [NSString stringWithFormat:@"%d",[self.studio.picArr count]];
    NSArray *textArr = [NSArray arrayWithObjects:tmpStr,@"张照片",nil];
    
    for (NSString *text in textArr)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        
        if ([text isEqualToString:@"张照片"]) {
            [attributedText setTextColor:[colors objectAtIndex:1]];
        }else [attributedText setTextColor:[colors objectAtIndex:0]];
        
        [self.picNumLbl appendAttributedText:attributedText];
    }

    [self showAdvertisInfo];
    
//    for (int i = 0; i < [self.studio.picArr count]; i++) {
//        NSDictionary *dic = [self.studio.picArr objectAtIndex:i];
//        NSString *url = [dic objectForKey:@"url"];
//        if (url != nil) {
//            
//           __block DBNImageView *tmpImg = [[DBNImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, 130)];
//            
//            [tmpImg setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
//            
////            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]
////                                                          cachePolicy:NSURLRequestReturnCacheDataElseLoad
////                                                      timeoutInterval:60.0];
////            [tmpImg setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
////                //            [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
//////                [tmpImg performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
////            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
////            }];
//            
//            [self.picSV addSubview:tmpImg];
//        };
//    }
//    
//    self.picSV.contentSize = CGSizeMake([self.studio.picArr count] * self.view.frame.size.width, 130);
    
    [self recFrame];
}

- (void)recFrame{

    [self.addressLbl sizeToFit];
    
    float currY = 0;
    CGRect tmp = self.addressView.frame;
    tmp.size.height = _addressLbl.frame.origin.y + _addressLbl.frame.size.height;
    self.addressView.frame = tmp;
    currY = tmp.origin.y + tmp.size.height - 3;
    
    tmp = self.phoneView.frame;
    tmp.origin.y = currY;
    self.phoneView.frame = tmp;
    currY = tmp.origin.y + tmp.size.height + 9;
    
    tmp = self.studioIntroView.frame;
    tmp.origin.y = currY;
    self.studioIntroView.frame = tmp;
    currY = tmp.origin.y + tmp.size.height;
    
    tmp = self.worksView.frame;
    tmp.origin.y = currY;
    self.worksView.frame = tmp;
    currY = tmp.origin.y + tmp.size.height + 9;
    
    tmp = self.lineView.frame;
    tmp.origin.y = currY;
    self.lineView.frame = tmp;
    
    float topViewH = tmp.origin.y + tmp.size.height;
    
    tmp = self.topView.frame;
    tmp.size.height = topViewH;
    self.topView.frame = tmp;
    
    ///////////////////////////////
    
    tmp = self.topicsTV.frame;
    tmp.size.height = self.topicsTV.contentSize.height;
    tmp.origin.y = self.topView.frame.origin.y + self.topView.frame.size.height;
    self.topicsTV.frame = tmp;
    
    self.container.contentSize = CGSizeMake(self.view.frame.size.width, self.topicsTV.frame.origin.y + self.topicsTV.frame.size.height + 30);

}

- (NSMutableArray*)getObjectsFromNSArray:(NSArray*)arr {
    if(arr == nil) return nil;
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[arr count]];
    for (NSDictionary *attributes in arr) {
        
        AETopic *post = [[AETopic alloc] initWithAttributes:attributes];
        [mutablePosts addObject:post];
        
    }
    return mutablePosts;
}

- (IBAction)shouPics:(id)sender{
    if ([self.studio.picArr count] > 0) {
        AEShowColleagePicsController *controller = [[AEShowColleagePicsController alloc]initWithWorkSet:self.studio.picArr];
        controller.title = [NSString stringWithFormat:@"%@作品",self.studio.name];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (IBAction)commentAction:(id)sender{
    AENewTopicController *controller = [[AENewTopicController alloc]initWithCircleId:5];//画室圈子的id
    controller.studioId = self.studioId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int num = lroundf(self.picSV.contentOffset.x/self.view.frame.size.width);
    self.pageControl.currentPage = num;
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.postArr count] > 0) {
        return 1;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AETopicListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithTopic:[self.postArr objectAtIndex:indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AETopic *topic = [self.postArr objectAtIndex:indexPath.row];
    
    AETopicDetailsController *controller = [[AETopicDetailsController alloc]initWithPostId:topic.topicId];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [AETopicListCell heightForTopicListCellWithTopic:[self.postArr objectAtIndex:indexPath.row]];
}

- (void)showAdvertisInfo{
    
    self.pageControl.numberOfPages = [self.studio.picArr count];
    
    for (int i = 0; i < [self.studio.picArr count]; i++) {
        NSDictionary *ad = [self.studio.picArr objectAtIndex:i];
        NSString *url = [ad objectForKey:@"url"];
        if (url != nil) {
            
            __block DBNImageView *tmpImg = [[DBNImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, 181)];
            
            [tmpImg setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            
            [self.picSV addSubview:tmpImg];
        };
    }
    
    self.picSV.contentSize = CGSizeMake([self.studio.picArr count] * self.view.frame.size.width, _picSV.frame.size.height);
}

#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    
    if ([dataEntries isKindOfClass:[AEAdList class]]) {
        
        //[self showAdvertisInfo];
    }
    
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

#pragma mark --  GestureRecognizer
- (IBAction)tapGestureRecognizerAd:(UITapGestureRecognizer *)sender {
    
    if(!self.studio.picArr) return;
    int index = self.pageControl.currentPage;
    NSMutableArray *orgPics = [[NSMutableArray alloc] initWithCapacity:[self.studio.picArr count]];
    for (NSDictionary *dic in self.studio.picArr) {
        [orgPics addObject:[dic objectForKey:@"url"]];
    }
    
    self.imageGallery = [[DBNImageGallery alloc] init];
    _imageGallery.isHiddenCollectBtn = YES;
    
    [self.imageGallery setImageArray:orgPics currentIndex:index andIsFromNet:YES];
    [self.imageGallery show];
}

#pragma mark -- IBAction
- (IBAction)onClickCollect:(UIButton *)sender{
    
    [sender setImage:[UIImage imageNamed:@"studio_colect_pre.png"] forState:UIControlStateNormal];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [parameters setValue:@"studios" forKey:@"type"];
    [parameters setValue:@(self.studio.studioId) forKey:@"tid"];
    
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
                
                [sender setImage:[UIImage imageNamed:@"studio_colect_pre.png"] forState:UIControlStateNormal];
            }else{
                
                [[DBNStatusView sharedDBNStatusView] showStatus:@"取消收藏" dismissAfter:3.0];
                [sender setImage:[UIImage imageNamed:@"studio_colect.png"] forState:UIControlStateNormal];
            }
            
        }else if ([[json objectForKey:@"code"] intValue] == 22){
            
            [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能收藏" dismissAfter:3.0];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
- (IBAction)onClickStudioIntro:(id)sender {
    
//    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"简介",@"title",[NSString stringWithFormat:@"http://aed.bdqrc.cn/studio/intro/studioid/%d",self.studio.studioId],@"url", nil];
    
    NSString *str = [NSString stringWithFormat:@"%@studio/intro/studioid/%d",kWebUrl,self.studio.studioId];
    
//    str = @"http://ae.bdqrc.cn/college/getpage/id/80";
    
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:str];
    [self.navigationController pushViewController:controller animated:YES];
    
//    AEWebController *controller = [[AEWebController alloc] initWithWebInfo:dic];
//    [self.navigationController pushViewController:controller animated:YES];
}
@end
