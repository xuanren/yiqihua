//
//  EKWImageTitleCell.m
//  EKWStudent
//
//  Created by dahai on 14-7-28.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEImageTitleCell.h"


@interface AEImageTitleCell ()

@property (nonatomic, strong) UIButton *addBtn;

@end

static const float paddingL = 13;
static const float paddingT = 10;

@implementation AEImageTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    self.frame = CGRectMake(0, 0, 320, 75);
    
    CGRect tmpRect = CGRectMake(paddingL, (self.frame.size.height - 60) / 2.0, 90, 60);
    float paddV = 5;
    
    self.iconImgView = [[DBNImageView alloc] initWithFrame:tmpRect];
    self.iconImgView.image = [UIImage imageNamed:@" "];
    [self addSubview:_iconImgView];

    tmpRect.origin.x = tmpRect.origin.x + tmpRect.size.width + paddV;
    tmpRect.size.width = self.frame.size.width - tmpRect.origin.x - 40 - paddingL-paddV;
    tmpRect.size.height = 18;
    tmpRect.origin.y = (self.frame.size.height - tmpRect.size.height) / 2.0;
    
    self.titleLabel = [self labelFrarm:tmpRect titleFontSize:14.f titleColor:[UIColor blackColor]];
    [self addSubview:_titleLabel];
    
    tmpRect.origin.y = paddingT;
    
    self.upTitleLabel = [self labelFrarm:tmpRect titleFontSize:14.f titleColor:[UIColor blackColor]];
    [self addSubview:_upTitleLabel];
    
    tmpRect.origin.y = self.frame.size.height - paddingT - 18;
    
    self.downTitleLabel = [self labelFrarm:tmpRect titleFontSize:12.f titleColor:[UIColor blackColor]];
    
    [self addSubview:_downTitleLabel];
    
    tmpRect.origin.x = self.frame.size.width - paddingL - 50;
    tmpRect.origin.y = (self.frame.size.height - 21) / 2.0;
    tmpRect.size.width = 50;
    tmpRect.size.height = 21;
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = tmpRect;
    [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"ekw_addTopicBtn_def.png"] forState:UIControlStateNormal];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"ekw_addTopicBtn_dis.png"] forState:UIControlStateHighlighted];
    [_addBtn addTarget:self action:@selector(onClickAdd:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    _iconImgView.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1];
    _isShowUpDownTitle = YES;
    
    self.titleLabel.text = @"211 工程院校";
    self.upTitleLabel.text = @"清华大学美术学院";
    self.downTitleLabel.text = @"人气值：9713";
}

- (UILabel *)labelFrarm:(CGRect)frame titleFontSize:(float)size titleColor:(UIColor *)color{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:size];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    
    return label;
}

- (IBAction)onClickAdd:(id)sender{
    
    if (_delegate) {
        
        [_delegate imageTitleCell:self selectTypeId:@""];
    }
}

- (void)setIconSize:(CGSize)iconSize{

    CGRect tmpRect = CGRectMake(paddingL, (80 - iconSize.height)/2.0, iconSize.width, iconSize.height);
    float paddV = 5;
    
    self.iconImgView.frame = tmpRect;
    
    tmpRect.size.height = 16;
    tmpRect.origin.y = (self.frame.size.height - tmpRect.size.height) / 2.0;
    tmpRect.origin.x += tmpRect.size.width + paddV + 3;
    tmpRect.size.width = self.frame.size.width - tmpRect.origin.x - 40 - paddingL - paddV - 6;
    
    _titleLabel.frame = tmpRect;
    
    tmpRect.origin.y = paddingT + 5;
    
    _upTitleLabel.frame = tmpRect;
    
    tmpRect.origin.y = self.frame.size.height - paddingT - 18 - 5;
    
    _downTitleLabel.frame = tmpRect;
    
}

- (void)setTitle:(NSString *)title{
    
    if (_title != title) {
        
        _title = title;
        self.titleLabel.text = _title;
    }
}

- (void)setUpTitle:(NSString *)upTitle{
    
    if (_upTitle != upTitle) {
        
        _upTitle = upTitle;
        self.upTitleLabel.text = _upTitle;
    }
}

- (void)setDownTitle:(NSString *)downTitle{
    
    if (_downTitle != downTitle) {
        
        _downTitle = downTitle;
        self.downTitleLabel.text = _downTitle;
    }
}

- (void)setButtonTitle:(NSString *)buttonTitle{
    
    if (_buttonTitle != buttonTitle) {
        
        _buttonTitle = buttonTitle;
        
        [self.addBtn setTitle:_buttonTitle forState:UIControlStateNormal];
    }
}

- (void)setIsShowAdd:(BOOL)isShowAdd{
 
    
    _isShowAdd = isShowAdd;
    
    if (!_isShowAdd) {
        
        self.addBtn.hidden = YES;
    }else{
        
        self.addBtn.hidden = NO;
    }
}

- (void)setIsShowUpDownTitle:(BOOL)isShowUpDownTitle{
    
    _isShowUpDownTitle = isShowUpDownTitle;
    
    if (_isShowUpDownTitle) {
        
        self.upTitleLabel.hidden = NO;
        self.downTitleLabel.hidden = NO;
    }else{
        
        self.upTitleLabel.hidden = YES;
        self.downTitleLabel.hidden = YES;
    }
}

-(void)configureWithColleage:(AEColleage *)colleage{
    
//    if ([colleage.imgs count] > 0) {
//        NSDictionary *tmpDic = [colleage.imgs objectAtIndex:0];
//        
//        __weak AEImageTitleCell* weak_self = self;
//        
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[tmpDic objectForKey:@"url"]]
//                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                  timeoutInterval:60.0];
//        [self.iconImgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            //            [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
//            [weak_self.iconImgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        }];
//        
//    }else [self.iconImgView setImage:nil];

    if ([colleage.imgs count] > 0){
        NSDictionary *tmpDic = [colleage.imgs objectAtIndex:0];
        
        NSURL *imgUrl = [NSURL URLWithString:[[ROOTURL stringByAppendingString:IMGURL]stringByAppendingString:[tmpDic objectForKey:@"name"]]];
        
        [self.iconImgView setImageWithURL:imgUrl  placeholderImage:nil];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@",colleage.edulevel];
    self.upTitleLabel.text = colleage.name;
    self.downTitleLabel.text = [NSString stringWithFormat:@"人气值：%@",colleage.viewNum];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
