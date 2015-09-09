//
//  DBNPhotoCollection.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 9/22/13.
//
//

#import <UIKit/UIKit.h>

@interface DBNPhotoCollection : UIView

@property (nonatomic, retain) NSArray *photoArray;
@property (nonatomic) BOOL showLargeImg;
@property (nonatomic) float photoPadding;
@property (nonatomic) float photoWidth;
@property (nonatomic) float largePhotoWidth;
@property (nonatomic) float paddingL;

+ (float)heightForImages:(NSArray*)imgArr photoWidth:(float)w photoPadding:(float)p showLargeImg:(BOOL)b;

- (void)setLargeModeWithPhotoWidth:(float)w;
- (void)setThumbModeWithPhotoWidth:(float)w;

@end
