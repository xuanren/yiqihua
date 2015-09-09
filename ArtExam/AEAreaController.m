//
//  AEAreaController.m
//  ArtExam
//
//  Created by dahai on 14-9-26.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEAreaController.h"
#import "AEAreaView.h"
#import "AEStudioViewController.h"

@interface AEAreaController ()

@property (nonatomic, strong)IBOutlet AEAreaView *areaView;

@property (nonatomic, weak)id delegate;

@end

@implementation AEAreaController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _isShowBgView = YES;
    }
    return self;
}

- (id)initWithAreaViewDelegate:(id)delegate{
    
    self = [super init];
    if (self) {
        
        self.delegate = delegate;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _areaView.delegatee = _delegate;
    _areaView.paddingL = 7;
    _areaView.paddingT = 7;
    _areaView.paddingH = 7;
    _areaView.paddingV = 6;
    _areaView.titleViewHeight = 40;
    
    [self requestAreaList];
    
    if (!_isShowBgView) {
        
        self.bgView.userInteractionEnabled = YES;
        self.bgView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initNavItem{
    
    [super initNavItem];
    
    [super setCustomBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.view.hidden = YES;
}

#pragma mark -- 网络请求
- (void)requestAreaList{
    
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getAreaListAPI] parameters:nil needIdInfo:NO success:^(AFHTTPRequestOperation *operation, id json) {
        
        if ([[json objectForKey:@"code"] intValue] == 0) {
            
            self.areaList = [[json objectForKey:@"data"] objectForKey:@"locationList"];
            
            [_areaView upDataAreaList:_areaList showColumn:3];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        

    }];
}

@end
