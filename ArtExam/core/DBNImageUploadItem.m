//
//  DBNPhotoUploadItem.m
//  Dabanniu_Salon
//
//  Created by shaofeng wang on 13-7-20.
//  Copyright (c) 2013年 Dabanniu. All rights reserved.
//

#import "DBNImageUploadItem.h"

@implementation DBNImageUploadItem

@synthesize image = _image;
@synthesize imageId = _imageId;
@synthesize operation = _operation;

- (id) init
{
    self = [super init];
    if(self) {
        self.imageId = -1;
    }
    return self;
}

+(DBNImageUploadItem*) itemWithData:(UIImage *)image imgId:(int)imageId;
{
    DBNImageUploadItem* item = [[DBNImageUploadItem alloc]init];
    item.image = image;
    item.imageId = imageId;
    return item;
}

@end
