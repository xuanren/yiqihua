//
//  DBNPhotoUploadItem.h
//  Dabanniu_Salon
//
//  Created by shaofeng wang on 13-7-20.
//  Copyright (c) 2013年 Dabanniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBNImageUploadItem : NSObject

@property(nonatomic, weak) UIImage* image;
@property(nonatomic, weak) NSOperation *operation;
@property(nonatomic) long imageId;

+(DBNImageUploadItem*) itemWithData:(UIImage *)image imgId:(int)imageId;


@end
