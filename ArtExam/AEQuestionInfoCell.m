//
//  AEShowInfoCell.m
//  ArtExam
//
//  Created by dahai on 14-9-10.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEQuestionInfoCell.h"
#import "UIImageView+AFNetworking.h"
#import "DBNUtils.h"
#import "AEUserCenterController.h"

@interface AEQuestionInfoCell ()

@property (nonatomic, strong) UIView *lookupView;
@property (nonatomic, strong) AEQuestion *question;

@end

static const float paddingL = 12;
static const float paddingT = 5;

@implementation AEQuestionInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)initialization{
    
    self.frame = CGRectMake(7, 0, 306, 124);

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(7, 0, self.frame.size.width, self.frame.size.height)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    CGRect tmpRect = CGRectMake(paddingL, paddingT, 34, 34);
    float paddingH = 5;
    float paddingV = 10;
    
    self.logoImgView = [[UIImageView alloc] initWithFrame:tmpRect];
    _logoImgView.layer.cornerRadius = tmpRect.size.width / 2.0;
    _logoImgView.layer.masksToBounds = YES;
    _logoImgView.image = [UIImage imageNamed:@"common_defaultAvatar.png"];
    [bgView addSubview:_logoImgView];
    
    self.logoImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [self.logoImgView addGestureRecognizer:tapGesture];
    
    tmpRect.origin.x += tmpRect.size.width + paddingH;
    tmpRect.size.height = 16;
    tmpRect.size.width = 200;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:tmpRect];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:15.f];
    _nameLabel.textColor = [DBNUtils getColor:@"33363B"];
    [bgView addSubview:_nameLabel];
    
    tmpRect.origin.y += tmpRect.size.height;
    
    self.starTimeLabel = [[UILabel alloc] initWithFrame:tmpRect];
    _starTimeLabel.backgroundColor = [UIColor clearColor];
    _starTimeLabel.font = [UIFont systemFontOfSize:12.f];
    _starTimeLabel.textColor = [DBNUtils getColor:@"AAB0BA"];
    [bgView addSubview:_starTimeLabel];
    
    float oneV = paddingT*2+_logoImgView.frame.size.height;
    tmpRect.size.width = 29;
    tmpRect.size.height = 17;
    tmpRect.origin.y = (oneV - tmpRect.size.height) / 2.0;
    tmpRect.origin.x = self.frame.size.width - tmpRect.size.width;
    
    self.lookupView = [[UIView alloc] initWithFrame:tmpRect];
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _lookupView.frame.size.width, _lookupView.frame.size.height)];
    bgImg.image = [UIImage imageNamed:@"mark_read.png"];
    [_lookupView addSubview:bgImg];
    [bgView addSubview:_lookupView];
    
    tmpRect = CGRectMake(0, oneV, bgView.frame.size.width, 1);
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:tmpRect];
    lineImg.image = [UIImage imageNamed:@"questionAnswer_dividingline.png"];
    [bgView addSubview:lineImg];
    
    tmpRect.origin.x = paddingL;
    tmpRect.origin.y += tmpRect.size.height + paddingV;
    tmpRect.size.width = 80;
    tmpRect.size.height = 60;
    
    self.worksImgView = [[DBNImageView alloc] initWithFrame:tmpRect];
    [bgView addSubview:_worksImgView];
    
    tmpRect.origin.y -= 2;
    tmpRect.origin.x += tmpRect.size.width + paddingH;
    tmpRect.size.width = self.frame.size.width- tmpRect.origin.x - paddingL;
    
    self.worksDescribe = [[UILabel alloc] initWithFrame:tmpRect];
    _worksDescribe.backgroundColor = [UIColor clearColor];
    _worksDescribe.font = [UIFont systemFontOfSize:13.f];
    _worksDescribe.textColor = [DBNUtils getColor:@"69707a"];
    _worksDescribe.numberOfLines = 0;
    [bgView addSubview:_worksDescribe];
    
    self.backgroundColor = [DBNUtils getColor:@"e6e6e6"];
    
    self.worksImgView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0  blue:220/255.0  alpha:1.0];;
    self.nameLabel.text = @"Colorful_Birl";
    self.worksDescribe.text = @"老师帮忙看看我的素描怎么样啊老师帮忙看看我的素描怎么样啊老师帮忙看看我的素描怎么样啊老师帮忙看看我的素描怎么样啊";
    
}

- (void)setCurrTimeStamp:(long long)currTimeStamp {
    _currTimeStamp = currTimeStamp;
    
    self.starTimeLabel.text = [DBNUtils time:currTimeStamp since:self.question.subTime];

    [self.starTimeLabel setNeedsDisplay];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)gesture{
    
    AEUserCenterController *controller = [[AEUserCenterController alloc]initWithUserId:self.question.user.userId];
    [self.rootController.navigationController pushViewController:controller animated:YES];
}

- (void)setIsLookUp:(BOOL)isLookUp{
    
    _isLookUp = isLookUp;
    
    if (!_isLookUp) {
        
        self.lookupView.hidden = YES;
    }else{
        
        self.lookupView.hidden = NO;
    }
}

- (void)layoutSubviews{
    
    CGRect tmpRect = self.worksDescribe.frame;
    tmpRect.size.width =self.frame.size.width- self.worksImgView.frame.origin.x - paddingL - 85;
    _worksDescribe.frame = tmpRect;
    
    [self.worksDescribe sizeToFit];
    tmpRect = self.worksDescribe.frame;
   
    if (tmpRect.size.height > 64) {
        
        tmpRect.size.height = 64;
        self.worksDescribe.frame = tmpRect;
        self.worksDescribe.numberOfLines = 0;
    }
    
}

-(void)configureWithQuestion:(AEQuestion*)question{
    
    self.question = question;
    
    if ([question.pics count] > 0) {
        NSDictionary *tmpDic = [question.pics objectAtIndex:0];
        
//        __weak AEQuestionInfoCell* weak_self = self;
        
        [self.worksImgView setImageWithURL:[NSURL URLWithString:[tmpDic objectForKey:@"url"]] placeholderImage:nil];
         
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[tmpDic objectForKey:@"url"]]
//                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                  timeoutInterval:60.0];
//        [self.worksImgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            //            [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
//            [weak_self.worksImgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        }];
        
    }else [self.worksImgView setImage:nil];
    
    if (![question.user.avatarUrl isEqualToString:@""] && question.user.avatarUrl != nil) {
        
        [self.logoImgView setImageWithURL:[NSURL URLWithString:question.user.avatarUrl] placeholderImage:nil];
//        __weak AEQuestionInfoCell* weak_self = self;
//        
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:question.user.avatarUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.f];
//        
//        [self.logoImgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            
//            [weak_self.logoImgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//            
//        }];
    }else [self.logoImgView setImage:nil];
    
    
    self.worksDescribe.text = [NSString stringWithFormat:@"%@",question.mydescription];
    self.nameLabel.text = question.user.userName;
    
//    long long now = [[NSDate date] timeIntervalSince1970];
//    self.starTimeLabel.text = [DBNUtils time:now since:question.subTime];
    
    
    if (question.isMarked) {
        
        self.lookupView.hidden = NO;
    }else{
        
        self.lookupView.hidden = YES;
    }
}

@end
