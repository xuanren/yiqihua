//
//  DBNWebViewController.m
//  Dabanniu_Hair
//
//  Created by Cao Jianglong on 8/15/13.
//
//

#import "DBNWebViewController.h"
#import "AEArtVInformationController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>

@interface DBNWebViewController ()

@property (strong, nonatomic) NSString *titleStr;

@end

@implementation DBNWebViewController

@synthesize webView = _webView;
@synthesize busyIcon = _busyIcon;
@synthesize navBackBtn = _navBackBtn;
@synthesize navForwardBtn = _navForwardBtn;
@synthesize urlStr = _urlStr;
@synthesize webTitle = _webTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithWebUrl:(NSString *)url{
    self = [super init];
    if (self) {
        self.urlStr = url;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"a_wenzhang_share"] style:UIBarButtonItemStylePlain target:self action:@selector(share_in_wechat_and_more:)];

    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.webView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    UIImage *img = [UIImage imageNamed:@"web-img-bg"];
    [self.bottomBarBg setImage:[img stretchableImageWithLeftCapWidth:img.size.width/2.0 topCapHeight:img.size.height/2.0]];
    
    [self.busyIcon startAnimating];
}
- (void)share_in_wechat_and_more:(id)sender
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:self.urlStr
                                     images:@[[UIImage imageNamed:@"about_icon.png"]]
                                        url:[NSURL URLWithString:self.urlStr]
                                      title:@"  "
                                       type:SSDKContentTypeWebPage];
    [ShareSDK showShareActionSheet:sender
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state,
                                     SSDKPlatformType platformType,
                                     NSDictionary *userData,
                                     SSDKContentEntity *contentEntity,
                                     NSError *error, BOOL end) {
                   switch (state) {
                       case SSDKResponseStateSuccess:
                           NSLog(@"分享成功");
                           break;
                       case SSDKResponseStateFail:
                           NSLog(@"分享失败");
                           break;
                       default:
                           break;
                   }
               }];
}
- (void)addNavigationCollectionItemSearch
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 26, 30, 30)];
    [rightBtn addTarget:self action:@selector(onClickCollect:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"a_wenzhang_like.png"] forState:UIControlStateNormal];
    
    [self.navigationController.view addSubview:rightBtn];
    
}
-(void)onClickCollect:(UIButton *)sender
{
    NSLog(@"收藏");
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

- (void)initNavItem{
    [super initNavItem];
    [super setCustomBackButton];
//    if (_titleStr) {
//        self.title = _titleStr;
//    }else{
//        if(self.webTitle)
//        {
//           self.navigationItem.title = self.webTitle;
//        }
//    }
    self.busyIcon = [[[UIActivityIndicatorView alloc] init] autorelease];
    self.busyIcon.hidesWhenStopped = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.busyIcon];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
- (void)setUrlStr:(NSString *)urlStr{
    if (_urlStr == urlStr)  return;
    [_urlStr release];
    _urlStr = [urlStr retain];
    
    if(self.isViewLoaded) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
        [self.busyIcon startAnimating];
    }
}

#pragma mark - IBAction methords
- (IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.busyIcon startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.busyIcon stopAnimating];
    self.navBackBtn.enabled = self.webView.canGoBack;
    self.navForwardBtn.enabled = self.webView.canGoForward;
    
//    if (self.showVideoTitle) {
//        [self createVideoWebPageTitle];
//    }else if(!self.webTitle) {
//        NSString *theTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//        self.navigationItem.title = theTitle;
//    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.busyIcon stopAnimating];
    self.navBackBtn.enabled = self.webView.canGoBack;
    self.navForwardBtn.enabled = self.webView.canGoForward;
}

//- (void)createVideoWebPageTitle{
//    NSString *theTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
//    lbl.numberOfLines = 1;
//    lbl.textColor = [UIColor whiteColor];
//    lbl.font = [UIFont systemFontOfSize:13.0];
//    lbl.backgroundColor = [UIColor clearColor];
//    lbl.text = theTitle;
//    [lbl sizeToFit];

////    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, lbl.frame.size.width, lbl.frame.size.height)];
//    self.navigationItem.titleView = lbl;
//    
//    [lbl release];
//}

- (void)dealloc{
    [_bottomBarBg release];
    [_urlStr release];
    [_webView release];
    [_navForwardBtn release];
    [_navBackBtn release];
    [_busyIcon release];
    [_webTitle release];
    [super dealloc];
}

@end
