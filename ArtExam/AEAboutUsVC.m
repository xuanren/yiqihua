//
//  AEAboutUsVC.m
//  ArtExam
//
//  Created by dahai on 14-10-10.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEAboutUsVC.h"

@interface AEAboutUsVC ()

@end

@implementation AEAboutUsVC

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
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    self.title = @"关于我们";
    [self setCustomBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
