//
//  AEQuestionDetailCell.m
//  ArtExam
//
//  Created by dahai on 14-9-10.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEQuestionDetailCell.h"
#import "UIImageView+AFNetworking.h"
#import "DBNUtils.h"
#import "AEUserCenterController.h"


@interface AEQuestionDetailCell ()

@property (nonatomic) int userId;
@property (nonatomic, strong) AEQuestion *question;

@end
@implementation AEQuestionDetailCell

- (void)awakeFromNib
{
    // Initialization code
    
    [self initialization];
    
    self.worksImgView.showLargeImg = YES;
    self.worksImgView.backgroundColor = [UIColor clearColor];
    
    [self.worksImgView setLargeModeWithPhotoWidth:310];

}

- (void)initialization{
    
    _logoImgView.layer.cornerRadius = _logoImgView.frame.size.width / 2.0;
    _logoImgView.layer.masksToBounds = YES;
    
    self.logoImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self.logoImgView addGestureRecognizer:tapGesture];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)gesture{
    
    AEUserCenterController *controller = [[AEUserCenterController alloc]initWithUserId:self.userId];
    [self.rootController.navigationController pushViewController:controller animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.describeLabel sizeToFit];
    
    float height = [DBNPhotoCollection heightForImages:_question.pics photoWidth:310 photoPadding:5 showLargeImg:YES];
    
    CGRect tmpRect = self.worksImgView.frame;
    tmpRect.size.height = height;
    self.worksImgView.frame = tmpRect;

    tmpRect = self.describeLabel.frame;
    tmpRect.origin.y = self.worksImgView.frame.origin.y + self.worksImgView.frame.size.height + 5;
    tmpRect.size.width = 284;
    self.describeLabel.frame = tmpRect;
    
    tmpRect = _bgView.frame;
    tmpRect.size.height = self.describeLabel.frame.origin.y + self.describeLabel.frame.size.height + 10;
    _bgView.frame = tmpRect;
    
}

+(float)heightForQuestionInfoCellWithQuestion:(AEQuestion *)question{
    
    float h = 62;
    
    h +=[DBNPhotoCollection heightForImages:question.pics photoWidth:300 photoPadding:5 showLargeImg:YES];
    
    UILabel *contentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,320 - 36, 0)];
    contentLbl.numberOfLines = 0;
    contentLbl.font = [UIFont systemFontOfSize:13.0];
    contentLbl.text = question.mydescription;
    [contentLbl sizeToFit];
    
    CGRect tmpRect = contentLbl.frame;
    tmpRect.origin.y = h + 5;
    
    h = tmpRect.origin.y + tmpRect.size.height;
    
    return h;
}

-(void)configureWithQuestion:(AEQuestion*)question{
    
//    if ([question.pics count] > 0) {
//        NSDictionary *tmpDic = [question.pics objectAtIndex:0];
//        
//        __weak AEQuestionDetailCell* weak_self = self;
//        
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[tmpDic objectForKey:@"url"]]
//                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                  timeoutInterval:60.0];
//        [self.worksImgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            //            [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
//            [weak_self.worksImgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
//            
//            float height = [DBNPhotoCollection heightForImages:question.pics photoWidth:300 photoPadding:5 showLargeImg:YES];
//            
//            CGRect tmpRect = self.worksImgView.frame;
//            tmpRect.size.height = height;
//            self.worksImgView.frame = tmpRect;
//
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        }];
//        
//    }else [self.worksImgView setImage:nil];
    
    self.question = question;
    
    self.worksImgView.photoArray = question.pics;
    
    if (![question.user.avatarUrl isEqualToString:@""] && question.user.avatarUrl != nil) {
        
        __weak AEQuestionDetailCell* weak_self = self;
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:question.user.avatarUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.f];
        
        [self.logoImgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            [weak_self.logoImgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
    }else [self.logoImgView setImage:nil];

    self.userId = question.user.userId;
    
    long long now = [[NSDate date] timeIntervalSince1970];
    self.startTimeLabel.text = [DBNUtils time:now since:question.subTime];
    self.stdNameLabel.text = question.user.userName;
    self.scroceLabel.text = [NSString stringWithFormat:@"%d",question.score];
    
    if (question.score > 0) {
        
        _scroceView.hidden = NO;
        [self.scroceView currentScore:[NSString stringWithFormat:@"%d",question.score]];
    }else{
        
        _scroceView.hidden = YES;
    }
    
    self.describeLabel.text = question.mydescription;
}


@end
