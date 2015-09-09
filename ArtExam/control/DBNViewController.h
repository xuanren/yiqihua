//
//  DBNViewController.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 10/31/13.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    pushMode = 0,
    presentModelMode = 1,
} PresentMode;

@interface DBNViewController : UIViewController

@property (nonatomic) PresentMode enterMode;

+ (UIBarButtonItem*)barButtonItemWithImage:(UIImage*)img target:(id)target action:(SEL)action;
+ (UIBarButtonItem*)barButtonItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem*)barButtonItemWithBgImage:(UIImage*)img andTitle:(NSString *)tilte target:(id)target action:(SEL)action;

- (void)initNavItem;
- (void) setCustomBackButton;
- (void) back;

@end
