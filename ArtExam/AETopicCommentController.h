//
//  AETopicCommentController.h
//  ArtExam
//
//  Created by dahai on 14-9-16.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"
#import "UIPlaceHolderTextView.h"
#import "DBNAddPhotoView.h"

@interface AETopicCommentController : DBNViewController<DBNAddPhotoViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topicBgView;

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *contentView;

@property (weak, nonatomic) IBOutlet DBNAddPhotoView *picView;

@property (nonatomic) int postId;
@property (nonatomic) int commentId;

@property (nonatomic, copy) void(^BackAction)(UIViewController *controller);

- (instancetype)initWithPostId:(int)pId;
- (instancetype)initWithPostId:(int)pId andCommentId:(int)cId;

@end
