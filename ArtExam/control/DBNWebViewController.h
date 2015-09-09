//
//  DBNWebViewController.h
//  Dabanniu_Hair
//
//  Created by Cao Jianglong on 8/15/13.
//
//

#import <UIKit/UIKit.h>
#import "DBNViewController.h"

@interface DBNWebViewController : DBNViewController <UIWebViewDelegate>
{
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView *busyIcon;
@property (nonatomic, retain) IBOutlet UIButton *navBackBtn;
@property (nonatomic, retain) IBOutlet UIButton *navForwardBtn;
@property (nonatomic, retain) IBOutlet UIImageView *bottomBarBg;
@property (nonatomic, retain) NSString *urlStr;
@property (nonatomic, retain) NSString *webTitle;
@property (nonatomic) BOOL showVideoTitle;

- (id)initWithWebUrl:(NSString *)url;

- (IBAction)back:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)refresh:(id)sender;

@end
