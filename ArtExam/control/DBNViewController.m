//
//  DBNViewController.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 10/31/13.
//
//

#import "DBNViewController.h"
#import "DBNStatusView.h"

@interface DBNViewController ()

@end

@implementation DBNViewController
@synthesize enterMode = _enterMode;

+ (UIBarButtonItem*)barButtonItemWithImage:(UIImage*)img target:(id)target action:(SEL)action {
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:img forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return customBarItem;
}

+ (UIBarButtonItem*)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStyleBordered
                                                            target:target
                                                            action:action];
    return item;
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:[NSString stringWithFormat:@"    %@",title] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    CGSize titleSize = [title sizeWithFont:button.titleLabel.font forWidth:100 lineBreakMode:NSLineBreakByWordWrapping];
    button.frame = CGRectMake(0, 0, titleSize.width + 20, 31);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return [customBarItem autorelease];
     */
}

+ (UIBarButtonItem*)barButtonItemWithBgImage:(UIImage*)img andTitle:(NSString *)tilte target:(id)target action:(SEL)action{
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2] forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    //button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:tilte forState:UIControlStateNormal];
    
    CGSize titleSize = [tilte sizeWithFont:button.titleLabel.font forWidth:100 lineBreakMode:NSLineBreakByWordWrapping];
    button.frame = CGRectMake(0, 0, titleSize.width + 20, img.size.height);
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return customBarItem;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [[DBNStatusView sharedDBNStatusView] dismiss];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
	[self initNavItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavItem {
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
}

- (void) setCustomBackButton
{
    UIImage *buttonImage = [UIImage imageNamed:@"navigation_back.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
}

- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
