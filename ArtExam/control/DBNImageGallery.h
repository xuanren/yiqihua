//
//  DBNImageGallery.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 1/15/13.
//
//

#import <UIKit/UIKit.h>
#import "DBNActionBarButton.h"

@interface DBNImageGallery : UIViewController <UIScrollViewDelegate>{
    int _currInd;
    BOOL _topBarShowing;
    BOOL _isZoomed;
    BOOL _isFromNet;
    BOOL _isShowing;
    CGRect _showRect;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;
@property (nonatomic, retain) IBOutlet DBNActionBarButton *saveBtn;
@property (nonatomic, retain) IBOutlet UILabel *numLbl;
@property (nonatomic, retain) NSArray *imgURLs;
@property (nonatomic, retain) NSMutableArray *imgViewArr;
@property (nonatomic) BOOL isHiddenCollectBtn;

@property (nonatomic, copy) void (^buttonTaped)(int index);
@property (nonatomic, copy) void (^scrollAction)(int index);

@property (retain, nonatomic) IBOutlet UIButton *collectBtn;

- (IBAction)closeAction:(id)sender;
- (IBAction)saveImageToPhotoAlbum:(id)sender;
- (IBAction)collectPicAction:(id)sender;
- (void)show;
- (void)showFromView:(UIView*)showView;

- (void)setImageArray:(NSArray*)imgs currentIndex:(int)ind andIsFromNet:(BOOL) isNet;

// 请不要用以下方法，系统内部会调用这些方法
- (void)toggleTopBar;
- (void)loadImageStack;
- (void)scrollToPageIndex:(int)ind;

@end
