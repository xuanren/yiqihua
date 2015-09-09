//
//  AETeacherDetailController.m
//  ArtExam
//
//  Created by dahai on 14-9-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AETeacherIntroController.h"
#import "UIImageView+AFNetworking.h"

@interface AETeacherIntroController ()


@end

@implementation AETeacherIntroController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSubViewsProperty];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSubViewsProperty{
    
    self.infoView.layer.cornerRadius = 6.0;
    self.infoView.layer.masksToBounds = YES;
    
    self.logoImgView.layer.cornerRadius = _logoImgView.frame.size.width / 2.0;
    self.logoImgView.layer.masksToBounds = YES;
    
    self.logoBgImgView.layer.cornerRadius = _logoBgImgView.frame.size.width / 2.0;
    self.logoBgImgView.layer.masksToBounds = YES;
}

- (IBAction)touchTapGestureRecognizer:(UITapGestureRecognizer *)sender {
    
    [self.view setAlpha:0];
  
}

-(void)configureWithTchInfo:(AETopicUser *)tchUser{
    
    self.logoImgView.image = [UIImage imageNamed:@"common_defaultAvatar.png"];
    if (![[tchUser avatarUrl] isEqualToString:@""] ) {
        
        __weak AETeacherIntroController* weak_self = self;
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:tchUser.avatarUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.f];
        
        [self.logoImgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            [weak_self.logoImgView performSelector:@selector(setImage:) withObject:image afterDelay:0.001];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
        
    }else [self.logoImgView setImage:nil];
    
    self.nameLabel.text = tchUser.userName;
    self.describeTextView.text = tchUser.teacherDesc;
    
}

@end
