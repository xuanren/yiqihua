//
//  DBNPhotoImport.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 1/16/13.
//
//  导入图片，选项有：拍照，从相册中挑选，以及从打扮历史中选择。

#import <Foundation/Foundation.h>
#import "QBImagePickerController.h"

@class DBNPhotoImport;
@protocol DBNPhotoImportDelegate <NSObject>

//- (void)photoImport:(DBNPhotoImport*)import didImportPhoto:(UIImage*)img;
- (void)photoImportDidCancel:(DBNPhotoImport*)import;

@optional
//- (void)photoImport:(DBNPhotoImport *)import didImportPhotos:(NSArray *)imgs;

@end

@interface DBNPhotoImport : NSObject <UIActionSheetDelegate, UIImagePickerControllerDelegate,
                                      UINavigationControllerDelegate,
                                      UIGestureRecognizerDelegate,QBImagePickerControllerDelegate>
{
    UIView *_bgView;    //black background view for _myPhotoController
}

@property (nonatomic, assign) UIViewController *rootController;
@property (nonatomic, assign) id<DBNPhotoImportDelegate> delegate;
@property (nonatomic) BOOL isUserMakeover;
@property (nonatomic) BOOL  allowImportMutipleImgs;

- (id)initWithRootViewController:(UIViewController*)vc;

- (void)importPhoto;
- (void)importPhotoShowActionSheetFromController:(UIViewController *)controller;

//请不要用以下方法
- (void)showMyPhotoController;
- (void)hideMyPhotoController;

@end
