//
//  AETopicListCell.m
//  test
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AETopicListCell.h"
#import "DBNUtils.h"

@interface  AETopicListCell()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *picConstraintH;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *nameConstranitW;

@end

@implementation AETopicListCell

- (void)awakeFromNib
{
    // Initialization code
    self.titleLbl.textColor = [UIColor blackColor];
    self.contentLbl.numberOfLines = 0;
    self.contentLbl.textColor = [DBNUtils getColor:@"69707a"];
    self.contentLbl.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.picView setElementWidth:90];
    self.nameLbl.textColor = [DBNUtils getColor:@"aab0ba"];
    self.timeLbl.textColor = [DBNUtils getColor:@"aab0ba"];
    
    self.picView.backgroundColor = [UIColor clearColor];
    self.picView.gridView.scrollEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

+(float)heightForTopicListCellWithTopic:(AETopic *)topic{
    
    float h =147 ;
//    float screenW = [UIApplication sharedApplication].keyWindow.frame.size.width;
    UILabel *contentLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,320 - 38, 0)];
    contentLbl.numberOfLines = 0;
    contentLbl.font = [UIFont systemFontOfSize:13.0];
    contentLbl.text = topic.content;
//    contentLbl.text =  @"中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高";
    [contentLbl sizeToFit];
    h += contentLbl.frame.size.height;
    
    if ([topic.picArr count] <= 0) {
        h -= 70;
    }
    
    return h;
}
-(void)configureWithTopic:(AETopic *)topic{
    self.titleLbl.text = topic.title;
    self.contentLbl.frame = CGRectMake(self.contentLbl.frame.origin.x, self.contentLbl.frame.origin.y, 320 - 38, 60);
    self.contentLbl.text = topic.content;
//    self.contentLbl.text = @"中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高中国人中阿哥高";
    [self.contentLbl sizeToFit];
    
    UILabel *tmpLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    tmpLbl.font = [UIFont systemFontOfSize:12.0];
    tmpLbl.text = topic.user.userName;
    [tmpLbl sizeToFit];
    
    self.nameLbl.text = topic.user.userName;
    self.nameConstranitW.constant = tmpLbl.frame.size.width;
//    [self.nameLbl sizeToFit];
    
    self.timeLbl.text = [DBNUtils time:[[NSDate date] timeIntervalSince1970] since:topic.subtime];
    
    if ([topic.picArr count] > 0) {
        self.picView.picArr = topic.picArr;
        self.picConstraintH.constant = 70;
        self.picView.hidden = NO;
    }else{
        self.picConstraintH.constant = 0;
        self.picView.hidden = YES;
    }
    
    NSString *imgName = [NSString stringWithFormat:@"post-type-%d",topic.postType];
    
    switch (topic.postType) {
        case 0:
            [self.tagIconImg setImage:nil];
            break;
        case 1:
            [self.tagIconImg setImage:[UIImage imageNamed:imgName]];
            break;
        case 2:
            [self.tagIconImg setImage:[UIImage imageNamed:imgName]];
            break;
        case 3:
            [self.tagIconImg setImage:[UIImage imageNamed:imgName]];
            break;
        case 4:
            [self.tagIconImg setImage:[UIImage imageNamed:imgName]];
            break;
            
        default:
            [self.tagIconImg setImage:nil];
            break;
    }
    
    [self updateConstraints];
}

@end
