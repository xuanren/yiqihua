//
//  DBNPhotoImport.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 1/16/13.
//
//

#import "DBNPhotoImport.h"
#import "CVUtils.h"

@implementation DBNPhotoImport

@synthesize rootController;
@synthesize delegate;
@synthesize isUserMakeover;

- (id)initWithRootViewController:(UIViewController*)vc{
    self = [super init];
    if(self) {
        self.rootController = vc;
        isUserMakeover=NO;
        _allowImportMutipleImgs = NO;
    }
    return self;
}

- (void)importPhoto {
    UIActionSheet *sharePhotoSheet;
    if (isUserMakeover) {
        sharePhotoSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"拍照", @"从相册选择",@"打扮历史", nil];
    }else{
        sharePhotoSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照", @"从相册选择", nil];

    }
  
    sharePhotoSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [sharePhotoSheet showInView:rootController.view];
    [sharePhotoSheet release];
}

- (void)importPhotoShowActionSheetFromController:(UIViewController *)controller{
    UIActionSheet *sharePhotoSheet;
    if (isUserMakeover) {
        sharePhotoSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照", @"从相册选择",@"打扮历史", nil];
    }else{
        sharePhotoSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"拍照", @"从相册选择", nil];
        
    }
    
    sharePhotoSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    if ([controller isKindOfClass:[UITabBarController class]]) {
        [sharePhotoSheet showFromTabBar:((UITabBarController *)controller).tabBar];
    }else{
        [sharePhotoSheet showInView:rootController.view];
    }
     [sharePhotoSheet release];
}

- (void)showMyPhotoController {
//    // add background to rootController's view and add tap gesture on it.
//    UIWindow *mainWindow = [[UIApplication sharedApplication].delegate window];
//    if(!_bgView) {
//        _bgView = [[UIView alloc] initWithFrame:mainWindow.bounds];
//        _bgView.backgroundColor = [UIColor blackColor];
//        _bgView.opaque = NO;
//        _bgView.alpha = 0.5;
//        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
//        tapGesture.cancelsTouchesInView = NO;
//        tapGesture.delaysTouchesEnded = NO;
//        tapGesture.delegate = self;
//        [_bgView addGestureRecognizer:tapGesture];
//        [tapGesture release];
//    }
//    [mainWindow addSubview:_bgView];
//
//    if(!_myPhotoController) {
//        _myPhotoController = [[DBNMyPhotoViewController alloc] init];
//        _myPhotoController.delegate = self;
//    }
//    CGRect photoFrame = _myPhotoController.view.frame;
//    photoFrame.origin.y = mainWindow.frame.size.height;
//    _myPhotoController.view.frame = photoFrame;
//    [mainWindow addSubview:_myPhotoController.view];
// 
//    photoFrame.origin.y = mainWindow.frame.size.height - photoFrame.size.height;
//    [UIView animateWithDuration:0.5
//                     animations:^(void){
//                         _myPhotoController.view.frame = photoFrame;
//                     }
//                     completion:^(BOOL finished) {
//                         
//                     }
//     ];
//    [_myPhotoController switchTab:_myPhotoController.myMakeoverBtn];    //默认打开打扮历史
    
//    DBNShowMakeOverListController *controller = [[DBNShowMakeOverListController alloc]init];
//    controller.isChoosePhoto = YES;
//    controller.delegate = self;
//    [self.rootController.navigationController pushViewController:controller animated:YES];
//    [controller release];
}

- (void)hideMyPhotoController {
//    UIWindow *mainWindow = [[UIApplication sharedApplication].delegate window];
//    CGRect photoFrame = _myPhotoController.view.frame;
//    photoFrame.origin.y = mainWindow.frame.size.height;
//    [UIView animateWithDuration:0.5
//                     animations:^(void){
//                         _myPhotoController.view.frame = photoFrame;
//                     }
//                     completion:^(BOOL finished) {
//                         [_bgView removeFromSuperview];
//                         [_myPhotoController.view removeFromSuperview];
//                     }
//     ];
}

#pragma mark - DBNShowMakeOverListControllerDelegate
//- (void)selectedItem:(DBNShowMakeOverListController *)controller{
//    UIImage *originImg = [[UIImage alloc]initWithContentsOfFile:controller.imgPath];
//    UIImage *correctImg = [CVUtils correctUIImageOrientation:originImg];
//    [self.delegate photoImport:self didImportPhoto:correctImg];
//    [controller.navigationController popViewControllerAnimated:NO];
//}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:    // take photo
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [rootController presentModalViewController:picker animated:YES];
            [picker release];
            return;
        }
        case 1:    // choose photo from album
        {
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
                QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.filterType = QBImagePickerControllerFilterTypePhotos;
                imagePickerController.allowsMultipleSelection = self.allowImportMutipleImgs;
                if (self.allowImportMutipleImgs) {
                    imagePickerController.maximumNumberOfSelection = 9;
                }
                
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
                navigationController.navigationBar.translucent = NO;
                [rootController presentViewController:navigationController animated:YES completion:NULL];
                [imagePickerController release];
                [navigationController  release];
                return;
            }
            
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [rootController presentViewController:picker animated:YES completion:^{
                
            }];
            [picker release];
            return;
        }
        default:
            break;
    }
    if (isUserMakeover&&buttonIndex==2) {
        [self showMyPhotoController];
        return;
    }
}

#pragma mark - gesture handler
- (void)handleTapGesture:(UITapGestureRecognizer*)sender {
    CGPoint tapPoint = [sender locationInView:_bgView];
    UIView *viewAtBottomOfHeirachy = [_bgView hitTest:tapPoint withEvent:nil];
    if(![viewAtBottomOfHeirachy isKindOfClass:[UIButton class]]) {
        [self hideMyPhotoController];
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [rootController dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage *correctImg = [CVUtils correctUIImageOrientation:image];
        [self.delegate photoImport:self didImportPhoto:correctImg];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [rootController dismissViewControllerAnimated:YES completion:^{
        [self.delegate photoImportDidCancel:self];
    }];
}

#pragma mark - QBImagePickerControllerDelegate

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
{
    NSLog(@"*** imagePickerController:didSelectAsset:");
    [rootController dismissViewControllerAnimated:YES completion:^{
        UIImage *image =  [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
        UIImage *correctImg = [CVUtils correctUIImageOrientation:image];
        [self.delegate photoImport:self didImportPhoto:correctImg];
    }];

}

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    NSLog(@"*** imagePickerController:didSelectAssets:");
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:3];
    for (ALAsset *assert in assets) {
        UIImage *img = [UIImage imageWithCGImage:[[assert defaultRepresentation] fullScreenImage]];
        UIImage *correctImg = [CVUtils correctUIImageOrientation:img];
        [tmpArr addObject:correctImg];
    }
    
    [rootController dismissViewControllerAnimated:YES completion:^{
        [self.delegate photoImport:self didImportPhotos:tmpArr];
    }];

    
}

//- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
//{
//    NSLog(@"*** imagePickerControllerDidCancel:");
//    [rootController dismissViewControllerAnimated:YES completion:^{
//        [self.delegate photoImportDidCancel:self];
//    }];
//}



#pragma mark -
#pragma mark DBNMyPhotoViewControllerDelegate
- (void)myPhotoSelected:(NSString *)photoName {
    [self hideMyPhotoController];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:photoName];
    [self.delegate photoImport:self didImportPhoto:image];
    [image release];
}

- (void)myMakeoverSelected:(NSString *)makeoverName {
    if(isUserMakeover) {
        [self hideMyPhotoController];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:makeoverName];
        [self.delegate photoImport:self didImportPhoto:image];
        [image release];
    }
}

- (void)dealloc {
    [_bgView release];
//    [_myPhotoController release];
    [super dealloc];
}

@end
