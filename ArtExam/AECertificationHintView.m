//
//  AECertificationHintView.m
//  ArtExam
//
//  Created by dahai on 14-9-21.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AECertificationHintView.h"
#import "DBNUtils.h"

@implementation AECertificationHintView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
     
    }
    
    return self;
}

- (void)layoutSubviews{
    
    self.hintView.layer.masksToBounds = YES;
    self.hintView.layer.cornerRadius = 6.0f;
    
    self.shareCertificationBtn.layer.masksToBounds = YES;
    self.shareCertificationBtn.layer.cornerRadius = 20.f;
}

- (void)setType:(ChoiceType)type{
    
    _type = type;
    if (_type == Certification_Type) {
        
        self.hintTextView.text = @"为了小伙伴的问题能得到及时高效的回答，回答问题都要经过我们严格的认证哦";
        [self.shareCertificationBtn setTitle:@"我要认证" forState:UIControlStateNormal];
        [self.shareCertificationBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.shareCertificationBtn.backgroundColor = [DBNUtils getColor:@"64c893"];
        [self layoutSubviews];
    }else{
        
        self.hintTextView.text = @"时间用完了呀，分享给朋友获得时间马上又可以提问了哦！好东西记得要分享给小伙伴哦";
        
    }
}

- (IBAction)onClickShareCertification:(id)sender {
    
    if (_delegate != nil) {
        
        [_delegate selectType:_type];
    }
    
    [self removeFromSuperview];
}
@end
