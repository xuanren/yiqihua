//
//  AEAreaController.h
//  ArtExam
//
//  Created by dahai on 14-9-26.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNViewController.h"

@interface AEAreaController : DBNViewController
@property (nonatomic, strong)NSArray *areaList;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic)BOOL isShowBgView;

- (id)initWithAreaViewDelegate:(id)delegate;

@end
