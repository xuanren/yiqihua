//
//  AEStudioDetailsController.h
//  ArtExam
//
//  Created by dkllc on 14-9-11.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBNViewController.h"
#import "M80AttributedLabel.h"


@interface AEStudioDetailsController : DBNViewController{
}

@property (nonatomic) int studioId;

- (instancetype)initWithStudioId:(int)sId;

@end
