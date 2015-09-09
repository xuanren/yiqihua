//
//  DBNPhotoCollection.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 9/22/13.
//
//

#import "DBNPhotoCollection.h"
#import "DBNImageView.h"
#import "UIImageView+AFNetworking.h"
#import "DBNImageGallery.h"

@implementation DBNPhotoCollection

@synthesize photoArray = _photoArray;
@synthesize photoPadding = _photoPadding;
@synthesize photoWidth = _photoWidth;
@synthesize showLargeImg = _showLargeImg;
@synthesize largePhotoWidth = _largePhotoWidth;

+ (float)heightForImages:(NSArray*)imgArr photoWidth:(float)w photoPadding:(float)p showLargeImg:(BOOL)b {
    if(!imgArr || [imgArr count] == 0) return 0;
    if(!b) {
        int imgCount = [imgArr count];
        int maxPhotoInARow = 3;
        if(imgCount == 4) maxPhotoInARow = 2;
        int row = (imgCount - 1) / maxPhotoInARow + 1;
        return row * w + (row - 1) * p;
    }
    float h = 0;
    for(int i = 0; i < [imgArr count]; i++) {
        NSDictionary *photoData = [imgArr objectAtIndex:i];
        BOOL hasDim = NO;   // 是否有图片尺寸
        if([photoData objectForKey:@"width"] && [photoData objectForKey:@"height"]) hasDim = YES;
        float picW = [[photoData objectForKey:@"width"] floatValue];
        float picH = [[photoData objectForKey:@"height"] floatValue];
        
        if(hasDim && picW > 0) {
            h += w * picH / picW;
        }
        else {
            h += w;
        }
        
        if(i < [imgArr count] - 1) {
            h += p * 1.5;
        }
    }
    
    return h;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.photoPadding = 5;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.photoPadding = 5;
    }
    return self;
}

- (void)setLargeModeWithPhotoWidth:(float)w {
    self.showLargeImg = YES;
    self.largePhotoWidth = w;
}

- (void)setThumbModeWithPhotoWidth:(float)w {
    self.showLargeImg = NO;
    self.photoWidth = w;
}

- (void)setPhotoArray:(NSArray *)photoArray {
    if(_photoArray == photoArray) return;
    [_photoArray release];
    _photoArray = [photoArray retain];
    
    for(UIView *subView in self.subviews) {
        if ([subView isMemberOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    float w, h;
    w = h = 0;
    int maxPhotoInARow = 3;
    if([_photoArray count] == 4) maxPhotoInARow = 2;
    
    for(int i = 0; i < [_photoArray count]; i++) {
        NSDictionary *photoData = [_photoArray objectAtIndex:i];
        
        CGRect imgFrame;
        if(self.showLargeImg) {
            BOOL hasDim = NO;   // 是否有图片尺寸
            if([photoData objectForKey:@"width"] && [photoData objectForKey:@"height"]) hasDim = YES;
            float picW = [[photoData objectForKey:@"width"] floatValue];
            float picH = [[photoData objectForKey:@"height"] floatValue];
            if(hasDim) {
                imgFrame = CGRectMake(self.paddingL, h, self.largePhotoWidth, self.largePhotoWidth * picH / picW);
            }
            else {
                imgFrame = CGRectMake(self.paddingL, h, self.largePhotoWidth, self.largePhotoWidth);
            }
        }
        else {
            imgFrame = CGRectMake(w, h, self.photoWidth, self.photoWidth);
        }
        
        DBNImageView *imgView = [[DBNImageView alloc] initWithFrame:imgFrame];
        
        NSString *imgURLKey = self.showLargeImg ? @"url" : @"thumb-s";
        UIImage *placeHolderImg = self.showLargeImg ? [UIImage imageNamed:@"dbn-logo-placeholder-large"] : [UIImage imageNamed:@"dbn-logo-placeholder-small"];
        if([photoData objectForKey:imgURLKey] && ![[photoData objectForKey:imgURLKey] isEqualToString:@""]) {
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[photoData objectForKey:imgURLKey]]
                                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                            timeoutInterval:60.0];
            [imgView setImageWithURLRequest:request placeholderImage:placeHolderImg success:nil failure:nil];
            [request release];
            
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageGallery:)];
            [imgView addGestureRecognizer:tapGesture];
            [tapGesture release];
        }
        [self addSubview:imgView];
        
        if(self.showLargeImg) {
            h += imgFrame.size.height;
            if(i < [_photoArray count] - 1) h += self.photoPadding * 1.5;
        }
        else {
            w += self.photoWidth + self.photoPadding;
            if(i % maxPhotoInARow == maxPhotoInARow - 1) {
                h += self.photoWidth;
                w = 0;
                if(i < [_photoArray count] -1)  h += self.photoPadding;
            }
        }        
    }
    if([_photoArray count] % maxPhotoInARow > 0 && !self.showLargeImg) h += self.photoWidth;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
    
    [self invalidateIntrinsicContentSize];
}

- (void)openImageGallery:(UITapGestureRecognizer*)gesture {
    if(!self.photoArray) return;
    int index = [self.subviews indexOfObject:gesture.view];
    NSMutableArray *orgPics = [[NSMutableArray alloc] initWithCapacity:[self.photoArray count]];
    for (NSDictionary *dic in self.photoArray) {
        [orgPics addObject:[dic objectForKey:@"url"]];
    }
    DBNImageGallery *imgGallery = [[DBNImageGallery alloc] init];
    [imgGallery setImageArray:orgPics currentIndex:index andIsFromNet:YES];
    [imgGallery show];
    [orgPics release];
}

- (CGSize)intrinsicContentSize{
    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    return size;
}
- (void)dealloc {
    [_photoArray release];
    [super dealloc];
}

@end
