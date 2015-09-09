//
//  DBNStatusView.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBNStatusView : UIView {
    UIActivityIndicatorView *ind;
    UITextView *busyTextView;
    UILabel *statusView;
}

+ (DBNStatusView*)sharedDBNStatusView;

- (id)init;
- (void)showBusyStatus:(NSString*)str;
- (void)showStatus:(NSString*)str dismissAfter:(float)delay;
- (void)dismiss;

@end
