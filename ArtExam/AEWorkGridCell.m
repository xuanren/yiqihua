//
//  AEWorkGridCell.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEWorkGridCell.h"
#import "UIImageView+AFNetworking.h"

@implementation AEWorkGridCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *view = [[UIView alloc] initWithFrame:frame];
        self.contentView = view;
        [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _imgView = [[DBNImageView alloc]initWithFrame:frame];
        _imgView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0  blue:220/255.0  alpha:1.0];
        [self.contentView addSubview:_imgView];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(id)init{
    self=[super init];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.contentView = view;
        [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _imgView = [[DBNImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _imgView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0  blue:220/255.0  alpha:1.0];
        [self.contentView addSubview:_imgView];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return  self;
}

- (void)configureWithWorkSet:(NSDictionary *)workDic{
    UIImage *placeImag = [UIImage imageNamed:@"c_cell_placeImg"];
    if ([workDic objectForKey:@"id"] != nil) {
        NSString *tempId = [workDic objectForKey:@"id"];
        NSString *imgUrl = [[ROOTURL stringByAppendingString:IMGURL] stringByAppendingString:tempId];
        [self.imgView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:placeImag];
        
    }else [self.imgView setImage:placeImag];
}

- (void)setImgUrl:(NSString *)url{
    __weak typeof(self) _weakSelf = self;
    if (url != nil) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]
                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                  timeoutInterval:60.0];
        [self.imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            //            [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
            [_weakSelf.imgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        }];
        
    }else [self.imgView setImage:nil];

}
- (void)setImgName:(NSString *)imgName{
    
    if (imgName != nil) {
        
        [self.imgView setImage:[UIImage imageNamed:imgName]];
    }
}

@end
