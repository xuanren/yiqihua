//
//  AELevelThatController.m
//  ArtExam
//
//  Created by dahai on 14-9-24.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AELevelThatController.h"
#import "SYDLProgressView.h"
#import "DBNUtils.h"

@interface AELevelThatController ()

@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@property (weak, nonatomic) IBOutlet UILabel *loginNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@property (weak, nonatomic) IBOutlet UILabel *replyTopicLabel;

@property (weak, nonatomic) IBOutlet SYDLProgressView *progressView;

@property (nonatomic, strong) NSDictionary *levelInfo;
@end

@implementation AELevelThatController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithLevelInfo:(NSDictionary *)levelInfo{
    
    self = [super init];
    if (self) {
        
        self.levelInfo = levelInfo;
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.progressView.trackTintColor = [DBNUtils getColor:@"999FA8"];
    self.progressView.progressTintColor = [DBNUtils getColor:@"64C893"];
    
    self.progressView.layer.cornerRadius = 8.0f;
    self.progressView.layer.masksToBounds = YES;
    self.progressView.ratioLabel.textColor = [UIColor whiteColor];
    
    if (_levelInfo != nil) {
        
        [self showData];
        
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)showData{
    
    self.levelLabel.text = [NSString stringWithFormat:@"我的等级：%@ %@",[_levelInfo objectForKey:@"level"],[_levelInfo objectForKey:@"name"]];;
    
    float progress = [[_levelInfo objectForKey:@"min"] floatValue] / [[_levelInfo objectForKey:@"max"] floatValue] * 100;
    
    [self.progressView setProgress:progress andRatio:[NSString stringWithFormat:@"%@/%@",[_levelInfo objectForKey:@"min"],[_levelInfo objectForKey:@"max"]] animated:YES];
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
    
    self.title = @"等级说明";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
