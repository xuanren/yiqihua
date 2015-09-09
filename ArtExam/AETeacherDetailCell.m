//
//  AEUserDetailCell.m
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AETeacherDetailCell.h"
#import "UIImageView+AFNetworking.h"

@implementation AETeacherDetailCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.logoImgView.layer.cornerRadius = _logoImgView.frame.size.width / 2.0;
    self.logoImgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureWithTchInfo:(AETeacherInfo *)teacherInfo{
    
    if (![[teacherInfo.user avatarUrl] isEqualToString:@""] ) {
        
        __weak AETeacherDetailCell* weak_self = self;
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:teacherInfo.user.avatarUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.f];
        
        [self.logoImgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            [weak_self.logoImgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
        
    }else [self.logoImgView setImage:nil];
    
    self.nameLabel.text = teacherInfo.user.userName;
    self.unitLable.text = teacherInfo.user.teacherPosition;
    self.workDescribeLabel.text = teacherInfo.user.teacherDesc;
}

@end
