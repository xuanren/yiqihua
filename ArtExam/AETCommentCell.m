//
//  AETCommentCell.m
//  ArtExam
//
//  Created by dahai on 14-9-10.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AETCommentCell.h"
#import "DBNUtils.h"
#import "AEScoreView.h"

@interface AETCommentCell ()

@property (nonatomic, strong) UIImageView *certificationImgView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) AEScoreView *scoreView;

@end

static const float paddingL = 10;
static const float paddingT = 10;

@implementation AETCommentCell

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
    
    CGRect tmpRect = CGRectMake(paddingL, paddingT, 100, 20);
    float paddingH = 10;
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 310, 182)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:tmpRect];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textColor = [DBNUtils getColor:@"33363B"];
    _nameLabel.font = [UIFont systemFontOfSize:15.f];
    [_bgView addSubview:_nameLabel];
    
    tmpRect.origin.x += tmpRect.size.width;
    tmpRect.size.width = 16;
    tmpRect.size.height = 16;
    
    self.certificationImgView = [[UIImageView alloc] initWithFrame:tmpRect];
    _certificationImgView.image = [UIImage imageNamed:@"questionAnswer_teach_viplogo.png"];
    [_bgView addSubview:_certificationImgView];
    
    tmpRect.origin.x = self.frame.size.width - 120;
    tmpRect.size.width = 80;
    
    UILabel *sLabel = [[UILabel alloc] initWithFrame:tmpRect];
    sLabel.backgroundColor = [UIColor clearColor];
    sLabel.font = [UIFont systemFontOfSize:13.f];
    sLabel.text = @"老师评分:";
    sLabel.textColor = [DBNUtils getColor:@"69707A"];
    [_bgView addSubview:sLabel];
    
    tmpRect.origin.x += 50;
    tmpRect.origin.y -= 2;
    tmpRect.size.width = 60;
    
    self.scorceLabel = [[UILabel alloc] initWithFrame:tmpRect];
    _scorceLabel.backgroundColor = [UIColor clearColor];
    _scorceLabel.font = [UIFont systemFontOfSize:14.f];
    _scorceLabel.textColor = [UIColor blackColor];
    //[_bgView addSubview:_scorceLabel];
    
    self.scoreView = [[AEScoreView alloc] initWithFrame:tmpRect];
    [_bgView addSubview:_scoreView];
    _scoreView.backgroundColor = [UIColor clearColor];
    
    tmpRect.origin.x = 0;
    tmpRect.origin.y = paddingT * 2 + tmpRect.size.height + 4;
    tmpRect.size.width = _bgView.frame.size.width;
    tmpRect.size.height = 1;
    
    UIView *lineImg = [[UIView alloc] initWithFrame:tmpRect];
    lineImg.backgroundColor = [DBNUtils getColor:@"E6E6E6"];
    [_bgView addSubview:lineImg];
    
    tmpRect.origin.x = paddingL;
    tmpRect.origin.y += tmpRect.size.height + paddingH;
    tmpRect.size.width = tmpRect.size.width - paddingL*2;
    tmpRect.size.height = 0;
    
    self.describeLabel = [[UILabel alloc] initWithFrame:tmpRect];
    _describeLabel.backgroundColor = [UIColor clearColor];
    _describeLabel.font = [UIFont systemFontOfSize:14.f];
    _describeLabel.textColor = [DBNUtils getColor:@"69707A"];
    _describeLabel.numberOfLines = 0;
    [_bgView addSubview:_describeLabel];
    
    self.contentView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    self.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.describeLabel sizeToFit];
    
    CGRect tmpRect = _bgView.frame;
    tmpRect.size.height = self.describeLabel.frame.origin.y + self.describeLabel.frame.size.height + paddingT;
    _bgView.frame = tmpRect;
    
    CGSize linesSz = [_nameLabel.text sizeWithFont:_nameLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, _nameLabel.frame.size.height) lineBreakMode: NSLineBreakByWordWrapping];
    tmpRect = _nameLabel.frame;
    tmpRect.size.width = linesSz.width;
    _nameLabel.frame = tmpRect;
    
    tmpRect = _certificationImgView.frame;
    tmpRect.origin.x = _nameLabel.frame.origin.x + _nameLabel.frame.size.width + 5;
    _certificationImgView.frame = tmpRect;
    
}

+(float)heightForCommentCellWithAnswer:(AEAnswer *)answer{
    
    float h = 51;

    UILabel *contentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,320 - 30, 0)];
    contentLbl.numberOfLines = 0;
    contentLbl.font = [UIFont systemFontOfSize:13.0];
    contentLbl.text = answer.content;
    [contentLbl sizeToFit];
    
    h += contentLbl.frame.size.height;
    
    if (h < 45) {
        
        return 45;
    }
    
    return h;
}

- (void)updataQuestion:(AEAnswer *)answer{
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",answer.user.userName];
    self.scorceLabel.text = [NSString stringWithFormat:@"%d",answer.score];
    
    if (answer.score > 0) {
        
        _scoreView.hidden = NO;
        [self.scoreView currentScore:[NSString stringWithFormat:@"%d",answer.score]];
        
    }else{
        
        _scoreView.hidden = YES;
    }
    
    self.describeLabel.text = answer.content;
}

@end
