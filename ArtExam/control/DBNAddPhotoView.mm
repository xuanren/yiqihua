//
//  DBNAddPhotoView.m
//  Dabanniu_Salon
//
//  Created by shaofeng wang on 13-7-18.
//  Copyright (c) 2013年 Dabanniu. All rights reserved.
//

#import "DBNAddPhotoView.h"
#import "DBNPhotoImport.h"
#import "CVUtils.h"

@implementation DBNAddPhotoView

@synthesize photoBts = _photoBts;
@synthesize photos = _photos;
@synthesize photoToDelete = _photoToDelete;
@synthesize rootController = _rootController;
@synthesize maxPhotos = _maxPhotos;
@synthesize imgGallery = _imgGallery;
@synthesize photoImport = _photoImport;
@synthesize delegate;

- (id)initWithFrameAndRootViewController:(CGRect)frame
                          rootController:(UIViewController *)controller
                               maxPhotos:(int)maxNumOfPhotos
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.photoBtnHeight = frame.size.height - PADDING * 2;
        self.photoBts = [[NSMutableArray alloc] initWithCapacity:1];
        self.photos = [[NSMutableArray alloc] initWithCapacity:0];
        self.currentX = PADDING;
        
        self.rootController = controller;
        self.photoImport = [[DBNPhotoImport alloc] initWithRootViewController:self.rootController];
        self.photoImport.delegate = self;
        self.photoImport.allowImportMutipleImgs = YES;
        self.maxPhotos = maxNumOfPhotos <= 0 ? MAX_PHOTO : maxNumOfPhotos;
        self.editable = NO;

        [self addBtn:PADDING];
        
        [self updatePhotos];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.photoBtnHeight = self.frame.size.height - PADDING * 2;
        self.photoBts = [[NSMutableArray alloc] initWithCapacity:1];
        self.photos = [[NSMutableArray alloc] initWithCapacity:0];
        self.currentX = PADDING;

        self.photoImport = [[DBNPhotoImport alloc] initWithRootViewController:self.rootController];
        self.photoImport.delegate = self;
        self.photoImport.allowImportMutipleImgs = YES;
        self.maxPhotos = MAX_PHOTO;
        self.editable = NO;
        
        [self addBtn:PADDING];
        
        [self updatePhotos];
        
    }
    return self;
}

- (void) addBtn:(int)currX
{
    UIImageView *btn = [[UIImageView alloc] initWithFrame:CGRectMake(currX, PADDING, self.photoBtnHeight, self.photoBtnHeight)];
    btn.userInteractionEnabled = true;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    
    [btn addGestureRecognizer:singleTap];
    [self.photoBts addObject:btn];
    [self addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"topic-add-pic-btn"]];
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    UIImageView *btn = (UIImageView*)sender.view;
    NSInteger index = [self.photoBts indexOfObject:btn];
    if(index != NSNotFound) {
        if(index == [self.photos count]) { //添加照片            [photoImport importPhoto];
           // [self.photoImport importPhotoFrom:[self convertRect:btn.frame toView:self.rootController.view]];
            if (self.delegate) {
                [self.delegate photoAddInProgress];
            }
            [self.photoImport importPhoto];
        } else { //删除照片
            UIActionSheet *sharePhotoSheet = [[UIActionSheet alloc] initWithTitle:@"您确实要删除这张图片吗？"
                                                                         delegate:self
                                                                cancelButtonTitle:@"取消"
                                                           destructiveButtonTitle:@"确认删除"
                                                                otherButtonTitles:nil, nil];
            sharePhotoSheet.tag=ACTION_SHEET_TAG_DELETE_PHOTO;
            sharePhotoSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
            [sharePhotoSheet showInView:[self superview]];
            _photoToDelete = index;
        }
    }
}


- (void) updatePhotos
{
    //create DelBtns
    if (self.delBtns == nil) {
        _delBtns = [[NSMutableArray alloc]initWithCapacity:3];
    }
    
    [self.delBtns removeAllObjects];
    
    //调整button的个数
    float currX = PADDING;
    if([self.photoBts count] - 1 < [self.photos count] && [self.photoBts count] < self.maxPhotos)
    {
        int num = [self.photos count] - [self.photoBts count] + 1;
        currX = PADDING+ (PHOTO_ITEM_GAP + self.photoBtnHeight) * [self.photoBts count] - PHOTO_ITEM_GAP;
        for(int i = 0; i < num; i++) {
            currX += PHOTO_ITEM_GAP;
            [self addBtn:currX];
            currX += self.photoBtnHeight;
        }
    } else if([self.photoBts count] - 1 > [self.photos count]) {
        //删除多余的imageview
        int num = [self.photoBts count] - 1 - [self.photos count];
        for (int i = 0; i < num; i++) {
            UIImageView *btn = [self.photoBts objectAtIndex:[self.photoBts count]- 1 -i];
            [btn removeFromSuperview];
            [self.photoBts removeObjectAtIndex:[self.photoBts count]- 1];
        }
    }
   
    //如果照片数目和按钮数目相同，则在最后增加一个添加照片按钮
    if([self.photoBts count] == [self.photos count] && [self.photoBts count] < self.maxPhotos) {
        currX += PHOTO_ITEM_GAP;
        NSLog(@"add last button");
        [self addBtn:currX];
    }

    //展示当前已有的照片
    for (int i = 0; i < [self.photos count]; i++) {
        UIImageView * btn = [self.photoBts objectAtIndex:i];
        btn.contentMode = UIViewContentModeScaleAspectFill;
        btn.clipsToBounds = YES;
        [btn setImage:[self.photos objectAtIndex:i]];
        
        //添加删除按钮
        UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect tmpFrame = delBtn.frame;
        [delBtn setImage:[UIImage imageNamed:@"error_delete"] forState:UIControlStateNormal];
        tmpFrame.origin.x = btn.frame.size.width -20;
        tmpFrame.origin.y = 2;
        tmpFrame.size.width = 18;
        tmpFrame.size.height = 18;
        delBtn.frame = tmpFrame;
        delBtn.hidden = YES;
        [delBtn addTarget:self action:@selector(delAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn addSubview:delBtn];
        [self.delBtns addObject:delBtn];
    }
    
    if([self.photoBts count] == [self.photos count] + 1) {
        UIImageView * btn = [self.photoBts objectAtIndex:[self.photoBts count] - 1];
        [btn setImage:[UIImage imageNamed:@"topic-add-pic-btn"]];
        
        for(UIView *view in btn.subviews){
            if ([view isKindOfClass:[UIButton class]]) {
                view.hidden = YES;
            }
        }
    }
    
//    //最后的个button展示“添加照片”
//    if ([self.photoBts count] > [self.photos count]) {
//        UIImageView *btn = [self.photoBts objectAtIndex:[self.photoBts count]- 1];
//        [btn setImage:[UIImage imageNamed:@"topic-add-pic-btn"]];
//    }
//    
    //更新scrollView的contentSize
    int numOfPhotoBtns = [self.photoBts count];
   [self setContentSize:CGSizeMake((2 * PADDING + self.photoBtnHeight * numOfPhotoBtns + PHOTO_ITEM_GAP * (numOfPhotoBtns - 1)), 2 * PADDING + self.photoBtnHeight)];
    
    for(UIButton *btn in self.delBtns){
        btn.hidden = !_editable;
    }
    
    

}

- (IBAction)delAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    self.photoToDelete = [self.delBtns indexOfObject:btn];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确实要删除这张图片吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    [alert release];
}


- (void)setEditable:(BOOL)editable{
    if (_editable == editable) return;
    _editable = editable;
    
    for(UIButton *btn in self.delBtns){
        btn.hidden = !_editable;
    }
}

- (void)setPhotos:(NSMutableArray *)photos{
    if (_photos == photos) {
        return;
    }
    [_photos release];
    _photos = [photos retain];
    [self cleanSubViews];
    [self updatePhotos];
}

- (void)cleanSubViews{
    for(UIView *view in self.subviews){
        [view removeFromSuperview];
    }
}

- (void)addImages:(NSArray *)imgs{
    if (self.photos == nil) {
        _photos = [[NSMutableArray alloc] initWithCapacity:3];
    }
    for(UIImage *img in imgs){
        [self.photos addObject:img];
        [self updatePhotos];
    }
    
    if (self.contentSize.width > self.frame.size.width) {
        if ([self.photoBts count] > [self.photos count]) {
            UIImageView *btn = [self.photoBts objectAtIndex:[self.photoBts count]- 1];
            [self scrollRectToVisible:btn.frame animated:YES];
        }
    }
}

#pragma mark -
#pragma mark DBNPhotoImportDelegate
- (void)photoImport:(DBNPhotoImport*)import didImportPhoto:(UIImage*)img
{
    UIImage *shareImg = [CVUtils createLongShareImage:img];
    if([self.photos count] < self.maxPhotos) {
        
        [self.photos addObject:shareImg];
        [self updatePhotos];
    
        if (self.contentSize.width > self.frame.size.width) {
            if ([self.photoBts count] > [self.photos count]) {
                UIImageView *btn = [self.photoBts objectAtIndex:[self.photoBts count]- 1];
                [self scrollRectToVisible:btn.frame animated:YES];
            }
        }
        
        if(self.delegate) {
            [self.delegate photoAdded:self andImg:shareImg];
        }
    }
}

- (void)photoImport:(DBNPhotoImport *)import didImportPhotos:(NSArray *)imgs{
    for(UIImage *img in imgs)
    {
        UIImage *shareImg = [CVUtils createLongShareImage:img];
        if([self.photos count] < self.maxPhotos) {
            
            [self.photos addObject:shareImg];
            [self updatePhotos];
            
            if (self.contentSize.width > self.frame.size.width) {
                if ([self.photoBts count] > [self.photos count]) {
                    UIImageView *btn = [self.photoBts objectAtIndex:[self.photoBts count]- 1];
                    [self scrollRectToVisible:btn.frame animated:YES];
                }
            }
            
            if(self.delegate) {
                [self.delegate photoAdded:self andImg:shareImg];
            }
        }
    }
}

- (void)photoImportDidCancel:(DBNPhotoImport*)import
{
    
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (self.delegate) {
            [self.delegate photoRemoved:self andImg:[self.photos objectAtIndex:self.photoToDelete]];
        }
        
        [self.photos removeObjectAtIndex:self.photoToDelete];
        [self updatePhotos];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if (self.delegate) {
            [self.delegate photoRemoved:self andImg:[self.photos objectAtIndex:self.photoToDelete]];
        }
        
        [self.photos removeObjectAtIndex:self.photoToDelete];
        [self.delBtns removeObjectAtIndex:self.photoToDelete];
        [self updatePhotos];
    }
}


- (void)dealloc{
    [_delBtns release];
    [_imgGallery release];
    [_photoImport release];
    [_photoBts release];
    [_photos release];
    [super dealloc];
}

@end
