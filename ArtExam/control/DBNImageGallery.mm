//
//  DBNImageGallery.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 1/15/13.
//
//

#import "DBNImageGallery.h"
#import "UIImageView+AFNetworking.h"
#import "DBNStatusView.h"

@implementation DBNImageGallery

@synthesize scrollView;
@synthesize navBar;
@synthesize navItem;
@synthesize imgURLs;
@synthesize imgViewArr;
@synthesize saveBtn;
@synthesize numLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _currInd = 0;
        _topBarShowing = YES;
        _isZoomed=NO;
        _isHiddenCollectBtn = YES;
        imgViewArr = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    saveBtn.hidden=NO;
    if(self.imgURLs) {
        [self loadImageStack];
    }
    self.wantsFullScreenLayout = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];

    self.navBar.translucent = YES;
    self.navBar.opaque = YES;
    self.navBar.tintColor = [UIColor clearColor];
    self.navBar.backgroundColor = [UIColor clearColor];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
//    if (!self.isHiddenCollectBtn) {
//        self.collectBtn.hidden = NO;
//    }
    self.collectBtn.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAction:(id)sender {
    _isShowing = NO;
    [UIView animateWithDuration:0.3
                     animations:^(void){
                         self.view.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self.view removeFromSuperview];
//                         [self autorelease];
                     }
     ];
 
}

-(IBAction)saveImageToPhotoAlbum:(id)sender{
    UIImageView *currImgView = (UIImageView*)[self.imgViewArr objectAtIndex:_currInd];
    UIImageWriteToSavedPhotosAlbum(currImgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"保存中"];
}

- (IBAction)collectPicAction:(id)sender{
    self.buttonTaped(_currInd);
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary*)info {
    [[DBNStatusView sharedDBNStatusView] showStatus:@"保存完成" dismissAfter:1.0];
}

- (void)show {
    _isShowing = YES;
    CGRect tmpFrame=self.view.frame;
//    tmpFrame.origin.y=[UIApplication sharedApplication].keyWindow.frame.size.height;
    tmpFrame.size.height=[UIApplication sharedApplication].keyWindow.frame.size.height;
    self.view.frame=tmpFrame;
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    self.view.alpha = 0.0;
    [UIView animateWithDuration:0.5
                     animations:^(void){
                          self.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                    }
     ];
}

- (void)showFromView:(UIView*)showView {
    _isShowing = YES;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _showRect = [keyWindow convertRect:showView.bounds fromView:showView];
    CGRect tmpFrame = self.view.frame;
    tmpFrame.size.height = keyWindow.frame.size.height;
    
    self.view.frame = _showRect;
    self.view.alpha = 0.0;
    [keyWindow addSubview:self.view];
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         self.view.frame = tmpFrame;
                         self.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                     }
     ];
}

- (void)setImageArray:(NSArray*)imgs currentIndex:(int)ind andIsFromNet:(BOOL) isNet {
    self.imgURLs = imgs;
    _currInd = ind;
    _isFromNet=isNet;
    if(self.isViewLoaded) {
        [self loadImageStack];
    }
}

#pragma mark - Private Methods
- (void)loadImageStack {
    CGRect tmp=self.scrollView.frame;
    self.scrollView.frame=CGRectMake(tmp.origin.x,tmp.origin.y, tmp.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height);
    
    
    CGSize scrollSize = self.scrollView.frame.size;
    CGSize size = CGSizeMake(0, scrollSize.height);
    for (int i = 0; i < [self.imgURLs count]; i++) {
        UIScrollView *container = [[UIScrollView alloc] initWithFrame:CGRectMake(size.width, 0,scrollSize.width, scrollSize.height)];
        container.backgroundColor = [UIColor blackColor];
        container.maximumZoomScale = 5.0;
        container.minimumZoomScale = 1.0;
        container.contentSize = scrollSize;
        container.delegate = self;
       
        UITapGestureRecognizer *twoTapsGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTwoTapsGesture:)];
        twoTapsGesture.numberOfTapsRequired=2;
        [twoTapsGesture setDelaysTouchesBegan:YES];
        [container addGestureRecognizer:twoTapsGesture];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [container addGestureRecognizer:gesture];
        [gesture setDelaysTouchesBegan:YES];
        [gesture requireGestureRecognizerToFail:twoTapsGesture];
//        [gesture release];
//        [twoTapsGesture release];
        
      
      
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollSize.width, scrollSize.height)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicator.frame = CGRectMake((scrollSize.width-indicator.frame.size.width)/2, (scrollSize.height-indicator.frame.size.height)/2,
                                     indicator.frame.size.width, indicator.frame.size.height);
        indicator.hidesWhenStopped = YES;
        [indicator startAnimating];
        [container addSubview:indicator];
        [container addSubview:imgView];
        [scrollView addSubview:container];
        
        if (_isFromNet) {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.imgURLs objectAtIndex:i]]
                                                     cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                 timeoutInterval:60.0];
            [imgView setImageWithURLRequest: request
                           placeholderImage:nil
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                        imgView.image = image;
                                        [indicator stopAnimating];
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                        [indicator stopAnimating];
                                    }];
        }else{
            imgView.image=[[UIImage alloc] initWithContentsOfFile:[self.imgURLs objectAtIndex:i]];
        }
 
     
        size.width += scrollSize.width;
        [imgViewArr addObject:imgView];
//        [imgView release];
//        [container release];
//        [indicator release];
    }
    scrollView.contentSize = size;
    scrollView.pagingEnabled = YES;
    CGRect newFrame = CGRectMake(_currInd*scrollSize.width, 0, scrollSize.width, scrollSize.height);
    [scrollView scrollRectToVisible:newFrame animated:NO];
    //self.navBar.topItem.title = [NSString stringWithFormat:@"(%d/%d)", _currInd+1, [self.imgViewArr count]];
    [self.numLbl setText:[NSString stringWithFormat:@"%d/%d", _currInd+1, [self.imgViewArr count]]];
}

- (void)handleTapGesture:(UITapGestureRecognizer*)gesture {
    
//    [self toggleTopBar];
    if (_isShowing) {
        _isShowing = NO;
        [self closeAction:nil];
    }else{
        _isShowing = YES;
        [self show];
    }
}

-(void)handleTwoTapsGesture:(UITapGestureRecognizer*)gesture{
    UIScrollView *tapView = (UIScrollView *)gesture.view;
    if (!_isZoomed) {
        CGPoint pt= [gesture locationInView:self.scrollView];
        CGSize scrollSize=self.scrollView.frame.size;
        [tapView zoomToRect:CGRectMake(pt.x-scrollSize.width/4,pt.y-scrollSize.height/4,scrollSize.width/2,scrollSize.height/2) animated:YES];
        _isZoomed=YES;

    }else
    {
         [tapView zoomToRect:CGRectMake(0,0,320,480) animated:YES];
        _isZoomed=NO;
    }
}

- (void)toggleTopBar {
    [[UIApplication sharedApplication] setStatusBarHidden:_topBarShowing];
    self.navBar.hidden = _topBarShowing;
    _topBarShowing = !_topBarShowing;
}

- (void)scrollToPageIndex:(int)ind {
    if(ind != _currInd) {
        _currInd = ind;
        //self.navBar.topItem.title = [NSString stringWithFormat:@"(%d/%d)", _currInd+1, [self.imgViewArr count]];
        [self.numLbl setText:[NSString stringWithFormat:@"%d/%d", _currInd+1, [self.imgViewArr count]]];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    if(aScrollView == scrollView) {
        CGFloat pageWidth = scrollView.bounds.size.width ;
        float fractionalPage = scrollView.contentOffset.x / pageWidth ;
        NSInteger nearestNumber = lround(fractionalPage) ;
        if(nearestNumber < [self.imgViewArr count]){
            [self scrollToPageIndex:nearestNumber];
            
            if (self.scrollAction) {
                self.scrollAction(nearestNumber);
            }
        }
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView1 {
    for (UIImageView *imgView in imgViewArr) {
        if(imgView.superview == scrollView1) return imgView;
    }
    return nil;
}

- (void)dealloc {
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
//    [numLbl release];
//    [scrollView release];
//    [navBar release];
//    [navItem release];
//    [imgURLs release];
//    [imgViewArr release];
//    [saveBtn release];
//    [super dealloc];
}

@end
