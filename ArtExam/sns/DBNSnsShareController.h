//
//  DBNSnsShareController.h
//  Dabanniu_Hair
//
//  Created by Cao Jianglong on 11/13/13.
//
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface DBNSnsShareController : UIViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate>{
     UIView *_bgView;
}

@property (nonatomic) BOOL isShowing;
@property (nonatomic,assign) UIViewController *rootController;
@property (nonatomic,retain) UIImage *shareImg;
@property (nonatomic, retain) NSDictionary *shareInfo;

-(id)initWithRootController:(UIViewController *)vc andShareImg:(UIImage *)img andShareIno:(NSDictionary *)info;

- (void)showShareMyView;
- (void)hideMyShareView;

- (IBAction)shareToWeiboAction:(id)sender;
- (IBAction)shareToQQSpaceAction:(id)sender;
- (IBAction)shareTOWenxinAction:(id)sender;
- (IBAction)shareTOWenxinFriendsAction:(id)sender;
- (IBAction)reportAction:(id)sender;
- (IBAction)onClickCancel:(id)sender;

@end
