//
//  AEArtStudioDetailEViewController.h
//  ArtExam
//
//  Created by chen on 15/8/13.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "DBNViewController.h"
#import "ParseJson.h"
#import "DBNImageView.h"
#import "UIImageView+AFNetworking.h"
#import "AEShowColleagePicsController.h"
#import "DBNWebViewController.h"


@interface AEArtStudioDetailEViewController : DBNViewController
{
    NSDictionary *m_dic_studio_info;
    UIImageView *m_bottomBarBg;
}
- (id)initWithStudioInfoDictionary : (NSDictionary *)studio_info;
- (IBAction)backAction:(id)sender;
@end
