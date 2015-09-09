//
//  AENewTopicController.h
//  ArtExam
//
//  Created by dahai on 14-9-16.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"
#import "UIPlaceHolderTextView.h"
#import "DBNAddPhotoView.h"

@interface AENewTopicController : DBNViewController<DBNAddPhotoViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topicBgView;

@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *contentView;

@property (weak, nonatomic) IBOutlet DBNAddPhotoView *picView;

@property (nonatomic) int circleId;

@property (nonatomic) int studioId;

- (instancetype)initWithCircleId:(int)cId;

@end
