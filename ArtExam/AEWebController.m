//
//  AEWebController.m
//  ArtExam
//
//  Created by dahai on 14-10-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEWebController.h"

@interface AEWebController ()

@property (nonatomic, strong) NSString *loadUrl;

@end

@implementation AEWebController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithWebInfo:(NSDictionary *)webInfo{
    
    self = [super init];
    if (self) {
        
        self.loadUrl = [webInfo objectForKey:@"url"];
        self.title = [webInfo objectForKey:@"title"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [self setCustomBackButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
}

- (void)showData
{
    NSURL *url = [NSURL URLWithString:_loadUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    
    [self.appointWebView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark -- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    BOOL should = YES;
    
    return should;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *theTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationController.title = theTitle;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
