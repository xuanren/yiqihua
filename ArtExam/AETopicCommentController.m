//
//  AETopicCommentController.m
//  ArtExam
//
//  Created by dahai on 14-9-16.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AETopicCommentController.h"
#import "DBNStatusView.h"
#import "DBNUserDefaults.h"
#import "DBNUtils.h"
#import "DBNLoginViewController.h"

@interface AETopicCommentController ()

@end

@implementation AETopicCommentController

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
- (instancetype)initWithPostId:(int)pId andCommentId:(int)cId{
    self = [super init];
    if (self) {
        self.postId = pId;
        self.commentId = cId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"评论";
    
    _topicBgView.layer.cornerRadius = 6.0f;
    _topicBgView.layer.masksToBounds = YES;
    
    _contentView.placeholder = @"写评论...";
    _contentView.font = [UIFont systemFontOfSize:13.f];
    
    self.picView.delegate = self;
    self.picView.photoImport.rootController = self;
    self.picView.clipsToBounds = YES;
    self.picView.editable = YES;
    
    [self addNavigationRightItem];
    
    // Do any additional setup after loading the view from its nib.
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.contentView resignFirstResponder];
}

- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 23);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [rightBtn addTarget:self action:@selector(onClickSend:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"t_statistics.png"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"t_statistics_dis.png"] forState:UIControlStateHighlighted];
    [rightBtn setTitle:@"发 送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[DBNUtils getColor:@"40c157"] forState:UIControlStateNormal];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (IBAction)onClickSend:(id)sender{
    
//    if (![DBNUser sharedDBNUser].loggedIn) {
//        
//        [[DBNStatusView sharedDBNStatusView] showStatus:@"你还未登录，需要登录才能评论" dismissAfter:3.0];
//        return;
//    }
    
    if (![DBNUser sharedDBNUser].loggedIn) {
        DBNLoginViewController *controller = [[DBNLoginViewController alloc]init];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    if (self.contentView.text != nil && ![self.contentView.text isEqualToString:@""]) {
        [params setObject:self.contentView.text forKey:@"content"];
    }else{
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"内容不能为空！" dismissAfter:3.0f];
        return;
    }
    
    [params setObject:@(self.postId) forKey:@"postId"];
    if (self.commentId > 0) {
        [params setObject:@(self.commentId) forKey:@"commentId"];

    }
    [params setObject:@"ios" forKey:@"device"];
    [params setObject:[DBNUserDefaults sharedDBNUserDefaults].appVersion forKey:@"version"];
    if ([DBNUser sharedDBNUser].sessionKey) {
        [params setObject:[DBNUser sharedDBNUser].sessionKey forKey:@"session"];
    }
    
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"发送中..."];
    
    AFHTTPRequestOperation *operation  = [[DBNAPIClient sharedClient] postmultipartFormDataPath:[DBNAPIList commentPostAPI] parameters:params constructingBody:^(id<AFMultipartFormData>formData) {
        
        for(int i = 0; i < [self.picView.photos count]; i++) {
            NSString *imgName = @"imgurl";
            NSData *photoData = UIImageJPEGRepresentation([self.picView.photos objectAtIndex:i], 0.85);
            [formData appendPartWithFileData:photoData
                                        name:[NSString stringWithFormat:@"%d",i]
                                    fileName:imgName
                                    mimeType:@"image/jpeg"];
        }
        
    } needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        if ([[JSON objectForKey:@"code"] intValue] != 0) {
            [[DBNStatusView sharedDBNStatusView] showStatus:[JSON objectForKey:@"error"] dismissAfter:2.0];
            return ;
        }
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"回复成功" dismissAfter:2.0];
//        [self.navigationController popViewControllerAnimated:YES];
        self.BackAction(self);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [[DBNStatusView sharedDBNStatusView] showStatus:@"请检查网络" dismissAfter:2.0];
    }];
    
    [[DBNAPIClient sharedClient] enqueueHTTPRequestOperation:operation];
    
    [operation start];
}

#pragma mark - DBNAddPhotoViewDelegate
- (void)photoAddInProgress{
    
}

- (void)photoAdded:(DBNAddPhotoView*)view  andImg:(UIImage *)img{
    
}

- (void)photoRemoved:(DBNAddPhotoView*)view andImg:(UIImage *)img{
    
    
}

@end
