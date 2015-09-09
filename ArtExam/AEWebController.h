//
//  AEWebController.h
//  ArtExam
//
//  Created by dahai on 14-10-11.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"

@interface AEWebController : DBNViewController

@property (retain, nonatomic) IBOutlet UIWebView *appointWebView;

- (id)initWithWebInfo:(NSDictionary *)webInfo;
@end
