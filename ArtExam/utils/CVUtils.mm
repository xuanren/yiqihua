//
//  CVUtils.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 5/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CVUtils.h"
#import "DBNConsts.h"

@implementation CVUtils

+ (UIImage*)UIImage2Grayscale:(UIImage*)image {
    if(!image) return nil;
    
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGImageRelease(imageRef);
    
    // Return the new grayscale image
    return newImage;
}

+ (UIImage*)resizeImageWithOrientation:(UIImage*)img withSize:(CGSize)newSize {
    CGImageRef imgRef = img.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > newSize.width || height > newSize.height) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = newSize.width;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = newSize.height;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = img.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    //TODO:: set interpolation quality.
    //CGContextSetInterpolationQuality(context, quality);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

+ (UIImage*)correctUIImageOrientation:(UIImage*)img {
    CGImageRef imgRef = img.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = img.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -1, 1);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

+ (UIImage*)flipImage:(UIImage*)img isHorizantal:(BOOL)h {
    CGImageRef imgRef = img.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    if(h) {
        transform = CGAffineTransformMakeTranslation(width, 0.0);
        transform = CGAffineTransformScale(transform, -1.0, 1.0);
    }
    else {
        transform = CGAffineTransformMakeTranslation(0.0, height);
        transform = CGAffineTransformScale(transform, 1.0, -1.0);
    }
    
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -height);
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
    
}

+ (UIImage*)createThumbnail:(UIImage*)img thumbSize:(CGSize)sz {
    CGSize orgSize = img.size;
    CGSize newSize;
    CGFloat scale = [[UIScreen mainScreen] scale];
    if(scale > 1) {
        sz.width *= scale;
        sz.height *= scale;
    }
    float hRatio = sz.width / orgSize.width;
    float wRatio = sz.height / orgSize.height;
    float ratio = wRatio > hRatio ? wRatio : hRatio;
    newSize.width = orgSize.width * ratio;
    newSize.height = orgSize.height * ratio;
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [img drawInRect:CGRectMake(0, 0, newSize.width/scale, newSize.height/scale)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect cropRect = CGRectMake((newSize.width-sz.width)/2, (newSize.height-sz.height)/2, sz.width, sz.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([newImage CGImage], cropRect);
    UIImage *thumbImg = [[UIImage alloc] initWithCGImage:imageRef];
    return thumbImg;
}

+ (UIImage*)createShareImage:(UIImage*)img {
    UIImage *rtnImage;
    CGSize orgSize = CGSizeMake(CGImageGetWidth(img.CGImage), CGImageGetHeight(img.CGImage));
    if(orgSize.width > MAX_SHARE_PHOTO_SIZE || orgSize.height > MAX_SHARE_PHOTO_SIZE) {
        float wRatio = MAX_SHARE_PHOTO_SIZE / orgSize.width;
        float hRatio = MAX_SHARE_PHOTO_SIZE / orgSize.height;
        float ratio = wRatio < hRatio ? wRatio : hRatio;
        CGSize newSize = CGSizeMake(orgSize.width * ratio, orgSize.height * ratio);
        UIGraphicsBeginImageContext(newSize);
        [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        rtnImage = [newImage retain];
    }
    else {
        rtnImage = [img retain];
    }
    return rtnImage;
}

+ (UIImage*)createLongShareImage:(UIImage*)img {
    CGSize orgSize = CGSizeMake(CGImageGetWidth(img.CGImage), CGImageGetHeight(img.CGImage));
    float ratio = 1;
    if(orgSize.width > MAX_SHARE_PHOTO_SIZE) {
        ratio = MAX_SHARE_PHOTO_SIZE / orgSize.width;
    }
    CGSize newSize = CGSizeMake(orgSize.width * ratio, orgSize.height * ratio);
    UIGraphicsBeginImageContext(newSize);
    [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//+ (std::vector<cv::Point2f>)NSArrayPts2stdArrayPts:(NSArray*)nsPts {
//    std::vector<cv::Point2f> rtnPts;
//    if(!nsPts) return rtnPts;
//    
//    for (NSDictionary *ptObj in nsPts) {
//        cv::Point2f pt;
//        pt.x = [[ptObj objectForKey:@"x"] floatValue];
//        pt.y = [[ptObj objectForKey:@"y"] floatValue];
//        rtnPts.push_back(pt);
//    }
//    return rtnPts;
//}

//+ (NSArray*)stdArrayPts2NSArrayPts:(std::vector<cv::Point2f>)stdPts {
//    NSMutableArray *nsArr = [NSMutableArray arrayWithCapacity:stdPts.size()];
//    for(int i = 0; i < stdPts.size(); i++) {
//        NSDictionary *ptObj = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:stdPts[i].x], @"x",
//                               [NSNumber numberWithFloat:stdPts[i].y], @"y",
//                               nil];
//        [nsArr addObject:ptObj];
//    }
//    return nsArr;
//}

//+ (CGRect)getBounds:(std::vector<cv::Point2f>)stdPts {
//    CGRect bounds = CGRectMake(0, 0, 0, 0);
////    if(stdPts.size() == 0) return bounds;
////    
////    bounds.origin.x = stdPts[0].x;
////    bounds.origin.y = stdPts[0].y;
////    
////    for(int i = 1; i < stdPts.size(); i++) {
////        if(stdPts[i].x < bounds.origin.x) {
////            bounds.size.width += bounds.origin.x - stdPts[i].x;
////            bounds.origin.x = stdPts[i].x;
////        }
////        if(stdPts[i].x >= (bounds.origin.x + bounds.size.width)) {
////            bounds.size.width += stdPts[i].x - (bounds.origin.x + bounds.size.width);
////        }
////        if(stdPts[i].y < bounds.origin.y) {
////            bounds.size.height += bounds.origin.y - stdPts[i].y;
////            bounds.origin.y = stdPts[i].y;
////        }
////        if(stdPts[i].y >= (bounds.origin.y + bounds.size.height)) {
////            bounds.size.height += stdPts[i].y - (bounds.origin.y + bounds.size.height);
////        }
////    }
//    return bounds;
//}

+ (unsigned char*)imageBufferFromUIImage:(UIImage*)image {
    if(!image) return nil;
    int imgWidth = image.size.width;
    int imgHeight = image.size.height;
    unsigned char *imgBuf = new unsigned char[4 * imgWidth * imgHeight];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	// Create a context to draw into the allocated image data
	CGContextRef imgContext = CGBitmapContextCreate(imgBuf, imgWidth, imgHeight, 8, 4 * imgWidth, colorSpace,
													kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	CGContextClearRect(imgContext, CGRectMake(0, 0, imgWidth, imgHeight));
	CGContextDrawImage(imgContext, CGRectMake(0, 0, imgWidth, imgHeight), image.CGImage);
	CGContextRelease(imgContext);
    CGColorSpaceRelease(colorSpace);
    return imgBuf;
}

+ (unsigned char*)imageBufferFromUIImage:(UIImage *)image withMask:(UIImage*)mask {
    int imgWidth = CGImageGetWidth(image.CGImage);
    int imgHeight = CGImageGetHeight(image.CGImage);
    int bufSize = imgWidth * imgHeight * 4;
    unsigned char *imgBuf = new unsigned char[bufSize];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	// Create a context to draw into the allocated image data
	CGContextRef imgContext = CGBitmapContextCreate(imgBuf, imgWidth, imgHeight, 8, 4 * imgWidth, colorSpace,
													kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Big);
	
	CGContextDrawImage(imgContext, CGRectMake(0, 0, imgWidth, imgHeight), image.CGImage);
	CGContextRelease(imgContext);
    CGColorSpaceRelease(colorSpace);
    
    unsigned char *maskBuf = new unsigned char[imgWidth * imgHeight];
    CGColorSpaceRef graySpace = CGColorSpaceCreateDeviceGray();
    CGContextRef maskContext = CGBitmapContextCreate(maskBuf, imgWidth, imgHeight, 8, imgWidth, graySpace, kCGImageAlphaNone);
    CGContextDrawImage(maskContext, CGRectMake(0, 0, imgWidth, imgHeight), mask.CGImage);
    CGColorSpaceRelease(graySpace);
    CGContextRelease(maskContext);
    int i, j;
    for(j = 0; j < imgHeight; j++) {
        for(i = 0; i < imgWidth; i++) {
            int ind1 = (j * imgWidth + i);
            int ind2 = ind1 * 4;
            imgBuf[ind2 + 3] = maskBuf[ind1];
        }
    }
    delete[] maskBuf;
    return imgBuf;
}

@end
