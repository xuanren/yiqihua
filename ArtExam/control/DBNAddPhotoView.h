//
//  DBNAddPhotoView.h
//  Dabanniu_Salon
//
//  Created by shaofeng wang on 13-7-18.
//  Copyright (c) 2013年 Dabanniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBNPhotoImport.h"
#import "UIImageView+AFNetworking.h"
#import "DBNImageGallery.h"

#define MAX_PHOTO 9
#define PADDING 0
#define PHOTO_ITEM_GAP 10

#define ACTION_SHEET_TAG_DELETE_PHOTO 1

@class DBNAddPhotoView;
@protocol DBNAddPhotoViewDelegate <UIScrollViewDelegate>

- (void)photoAddInProgress;
- (void)photoAdded:(DBNAddPhotoView*)view  andImg:(UIImage *)img;
- (void)photoRemoved:(DBNAddPhotoView*)view andImg:(UIImage *)img;

@end

@interface DBNAddPhotoView : UIScrollView<DBNPhotoImportDelegate, UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic, assign) id<DBNAddPhotoViewDelegate> delegate;

@property(nonatomic) int photoBtnHeight;
@property(nonatomic) int currentX;
@property(nonatomic) int photoToDelete;
@property(nonatomic) int maxPhotos;

@property(nonatomic, assign) UIViewController* rootController;

@property(nonatomic, retain) NSMutableArray *photos;
@property(nonatomic, retain) NSMutableArray *photoBts;
@property(nonatomic, retain) NSMutableArray *delBtns;

@property (nonatomic) BOOL editable;

@property(nonatomic, retain) DBNPhotoImport *photoImport;
@property(nonatomic) int clickedBtn;
@property(nonatomic, retain) DBNImageGallery *imgGallery;

- (id)initWithFrameAndRootViewController:(CGRect)frame  rootController:(UIViewController *)controller maxPhotos:(int)maxNumOfPhotos;
- (void)addImages:(NSArray *)imgs;

@end
