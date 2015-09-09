//
//  AEHomePageCell.m
//  ArtExam
//
//  Created by dkllc on 14-9-13.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEHomePageCell.h"
#import "DBNImageView.h"
#import "UIImageView+AFNetworking.h"

@interface AEHomePageCell ()
@property (nonatomic, weak) IBOutlet DBNImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLbl;
/**   温度label */
@property (nonatomic, strong) IBOutlet UILabel * temperaLabel;

@end

@implementation AEHomePageCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureWithFeed:(AEHomeFeed*)feed{
    UIImage *placeholderImg = [UIImage imageNamed:@"a_home_loading"];
    if (feed.picUrl != nil) {
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:feed.picUrl]
//                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                  timeoutInterval:60.0];
//        [self.imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            //            [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
//            [self.imgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        }];
        
        [self.imgView setImageWithURL:[NSURL URLWithString:feed.picUrl] placeholderImage:placeholderImg];
    }else [self.imgView setImage:placeholderImg];
    
    self.descriptionLbl.text = [NSString stringWithFormat:@" %@",feed.mydescription];
    self.temperaLabel.text = [NSString stringWithFormat:@"%@℃",feed.viewNum];
}

@end
