//
//  AEPicGridViewCell.m
//  ArtExam
//
//  Created by dkllc on 14-9-15.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEPicGridViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation AEPicGridViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.contentView = view;
        [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        DBNImageView *tmp = [[DBNImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imgView = tmp;
        self.imgView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0  blue:220/255.0  alpha:1.0];
        [self.contentView addSubview:_imgView];
        
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//-(void)baseInit{
//    if (self) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 145, 115)];
//        self.contentView = view;
//        [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        self.contentView.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor clearColor];
//        
//        DBNImageView *tmp = [[DBNImageView alloc]initWithFrame:CGRectMake(0, 0, 145, 82)];
//        self.imgView = tmp;
//        self.imgView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0  blue:220/255.0  alpha:1.0];
//        [self.contentView addSubview:_imgView];
//        
//        
//        self.contentView.backgroundColor = [UIColor whiteColor];
//        
//    }
//    return  self;
//}

- (void)loadImgWithUrl:(NSString *)url{
    if (url != nil) {
        
        [self.imgView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];

        
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]
//                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                  timeoutInterval:60.0];
//        [self.imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            //            [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
//            [self.imgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        }];
        
    }else [self.imgView setImage:nil];

}

@end
