//
//  AEStudioCollectionViewCell.m
//  ArtExam
//
//  Created by chen on 15/8/12.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "AEStudioCollectionViewCell.h"

@implementation AEStudioCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (UILabel *)InitLabel :(CGRect)frame :(NSString *)text :(double)fontSize :(BOOL)isGray
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    if (isGray) label.textColor = [UIColor grayColor];
    label.text = text;
    label.font = [UIFont fontWithName:@"Arial" size:fontSize];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    return label;
}
- (BOOL) setCellInfo :(NSDictionary *)dicInfo
{
    self.studioNameLabel = [self InitLabel:CGRectMake(5, 105+71, self.frame.size.width-10, 25) :[dicInfo objectForKey:@"name"] :16 :false];
    self.studioTypeLabel = [self InitLabel:CGRectMake(5, 130+71, self.frame.size.width-10, 20) :[dicInfo objectForKey:@"type"] :14 :true];
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0+71,self.frame.size.width, 100)];
    NSString *str_img_url = [NSString stringWithFormat:@"http://www.yiqihua.cn/artbox/sys/idownload.do?fileid=%@",[dicInfo objectForKey:@"cover"]];
    NSURL *imgUrl = [NSURL URLWithString:str_img_url];
    [self.imageview setImageWithURL:imgUrl  placeholderImage:nil];
    [self addSubview:self.imageview];
    return TRUE;
}

@end
