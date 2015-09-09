//
//  AESegalView.h
//  ArtExam
//
//  Created by 360 on 14-12-19.
//  Copyright (c) 2014年 360. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AESegalView : UIView

+ (instancetype)segalViewWith:(void(^)(int selectedIndex))menuBlock;

@end
