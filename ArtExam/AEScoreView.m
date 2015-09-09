//
//  AEScoreView.m
//  ArtExam
//
//  Created by dahai on 14-10-9.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEScoreView.h"

@interface AEScoreView ()

@property (nonatomic, strong) UIImageView *bitsImgView;
@property (nonatomic, strong) UIImageView *tenImgView;
@property (nonatomic, strong) UIImageView *hundredImgView;

@end

@implementation AEScoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
     
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    self.bitsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(36, 0, 18, 21)];
    self.tenImgView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 18, 21)];
    self.hundredImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 21)];
    
    UIImage *lineImg = [UIImage imageNamed:@"score_scoremarker.png"];
    UIImageView *markImgView = [[UIImageView alloc] initWithFrame:CGRectMake((60 - lineImg.size.width) / 2.0, 21, lineImg.size.width, lineImg.size.height)];
    markImgView.image = lineImg;
    [self addSubview:markImgView];
    
    [self addSubview:_bitsImgView];
    [self addSubview:_tenImgView];
    [self addSubview:_hundredImgView];
}

- (void)currentScore:(NSString *)score{
    
    if (score.length == 1) {
        
        self.tenImgView.image = [UIImage imageNamed:score];
//        CGRect tmpRect = _tenImgView.frame;
//        tmpRect.size.width = _tenImgView.image.size.width;
//        tmpRect.size.height = _tenImgView.image.size.height;
//        self.tenImgView.frame = tmpRect;
        
    }else if (score.length == 2){
        
        NSRange rang = {0,1};
        NSString *ten = [score substringWithRange:rang];
        
        NSRange rang1 = {1,1};
        NSString *bit = [score substringWithRange:rang1];
        
        
        self.tenImgView.image = [UIImage imageNamed:ten];
        
//        float imgViewX = 0;
//        CGRect tmpRect = _tenImgView.frame;
//        tmpRect.size.width = _tenImgView.image.size.width;
//        tmpRect.size.height = _tenImgView.image.size.height;
//        tmpRect.origin.x -= 3;
//        self.tenImgView.frame = tmpRect;
//        imgViewX = tmpRect.origin.x + tmpRect.size.width;
//        
        self.bitsImgView.image = [UIImage imageNamed:bit];
//        tmpRect = _bitsImgView.frame;
//        tmpRect.size.width = _bitsImgView.image.size.width;
//        tmpRect.size.height = _bitsImgView.image.size.height;
//        tmpRect.origin.x = imgViewX;
//        self.bitsImgView.frame = tmpRect;
        
    }else{
        
        NSRange range2 = {0,1};
        NSString *hundred = [score substringWithRange:range2];
        
        NSRange rang = {1,1};
        NSString *ten = [score substringWithRange:rang];
        
        NSRange rang1 = {2,1};
        NSString *bit = [score substringWithRange:rang1];
        
        self.hundredImgView.image = [UIImage imageNamed:hundred];
        
//        float imgViewX = 0;
//        CGRect tmpRect = _hundredImgView.frame;
//        tmpRect.size.width = _hundredImgView.image.size.width;
//        tmpRect.size.height = _hundredImgView.image.size.height;
//        tmpRect.origin.x = 10;
//        self.hundredImgView.frame = tmpRect;
//        imgViewX = tmpRect.origin.x + tmpRect.size.width;
//        
//        self.tenImgView.image = [UIImage imageNamed:ten];
//        
//        tmpRect = _tenImgView.frame;
//        tmpRect.size.width = _tenImgView.image.size.width;
//        tmpRect.size.height = _tenImgView.image.size.height;
//        tmpRect.origin.x = imgViewX;
//        self.tenImgView.frame = tmpRect;
//        imgViewX = tmpRect.origin.x + tmpRect.size.width;
//        
//        self.bitsImgView.image = [UIImage imageNamed:bit];
//        tmpRect = _bitsImgView.frame;
//        tmpRect.size.width = _bitsImgView.image.size.width;
//        tmpRect.size.height = _bitsImgView.image.size.height;
//        tmpRect.origin.x = imgViewX;
//        self.bitsImgView.frame = tmpRect;
    }
}

@end
