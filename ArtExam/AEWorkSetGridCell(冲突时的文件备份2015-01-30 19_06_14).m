//
//  AEWorkSetGridCell.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEWorkSetGridCell.h"
#import "DBNUtils.h"
#import "UIImageView+AFNetworking.h"

@implementation AEWorkSetGridCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init{
    self=[super init];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 130)];
        self.contentView = view;
        [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _imgView = [[DBNImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 100)];
        _imgView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0  blue:220/255.0  alpha:1.0];
        [self.contentView addSubview:_imgView];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 150, 30)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(150 - 53, 100-23, 53 + 20, 23)];
        numView.backgroundColor = [DBNUtils getColor:@"33363B"];
        numView.alpha = 0.6;
        self.contentView.clipsToBounds = YES;
        numView.layer.masksToBounds = YES;
        numView.layer.cornerRadius = 11.5f;
        [self.contentView addSubview:numView];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(numView.frame.origin.x+4, numView.frame.origin.y+2.5, 53, 18)];
        _numLabel.font = [UIFont systemFontOfSize:13.f];
        _numLabel.backgroundColor = [UIColor clearColor];
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_numLabel];
        
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 100, 145, 30)];
        _titleLbl.text = @"";
        _titleLbl.font = [UIFont systemFontOfSize:11];
        _titleLbl.textColor = [DBNUtils getColor:@"646464"];
        _titleLbl.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLbl];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return  self;
}

- (void)configureWithWorkSet:(AEWorkSet *)workSet{
    if (workSet.imgUrl != nil) {
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:workSet.imgUrl]
//                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                  timeoutInterval:60.0];
//        [self.imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            //            [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
//            [_weakSelf.imgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        }];
        
        [self.imgView setImageWithURL:[NSURL URLWithString:workSet.imgUrl] placeholderImage:nil];
        
    }else [self.imgView setImage:nil];
    
    self.titleLbl.text = workSet.mydescription;
    self.numLabel.text = [NSString stringWithFormat:@"共%d张",[workSet.picArr count]];
}

@end
