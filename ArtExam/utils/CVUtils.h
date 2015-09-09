//
//  CVUtils.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//#include <opencv2/opencv.hpp>
//#include <vector>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CVUtils : NSObject

// RGB image to Grayscale image. Return an autoreleased image
+ (UIImage*)UIImage2Grayscale:(UIImage*)img;

/*
 this function resize an image while correct the image's orientation.
 An autoreleased image is returned
 */
+ (UIImage*)resizeImageWithOrientation:(UIImage*)img withSize:(CGSize)newSize;

/*
 this function correct the image's orientation.
 An autoreleased image is returned
 */
+ (UIImage*)correctUIImageOrientation:(UIImage*)img;

// flip image horizantally or vertically. Return an autoreleased image
+ (UIImage*)flipImage:(UIImage*)img isHorizantal:(BOOL)h;
+ (UIImage*)createThumbnail:(UIImage*)img thumbSize:(CGSize)sz;
/*
 create a copy of the original image for sharing purpose. If the original image's dimension is large than
 MAX_SHARE_PHOTO_SIZE, downsize it. Return a retained image
 */
+ (UIImage*)createShareImage:(UIImage*)img;

/*
 create a copy of the original image for sharing long image(长图片). If the original image's width is large than
 MAX_SHARE_PHOTO_SIZE, downsize it. Return an autoreleased image
 */
+ (UIImage*)createLongShareImage:(UIImage*)img;

//+ (std::vector<cv::Point2f>)NSArrayPts2stdArrayPts:(NSArray*)nsPts;
//+ (NSArray*)stdArrayPts2NSArrayPts:(std::vector<cv::Point2f>)stdPts;
//+ (CGRect)getBounds:(std::vector<cv::Point2f>)stdPts;

// get RGBA buffer from UIImage. Need to release the memory after usage.
+ (unsigned char*)imageBufferFromUIImage:(UIImage*)image;
+ (unsigned char*)imageBufferFromUIImage:(UIImage *)image withMask:(UIImage*)mask;

@end
