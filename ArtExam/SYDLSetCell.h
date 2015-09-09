//
//  SYDLSetCell.h
//  SYDLMYParents
//
//  Created by dahai on 14-3-7.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYDLSetCell : UITableViewCell

@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UILabel *promptLabel;
@property (nonatomic, retain)UIImageView *arrowImageView;
@property (nonatomic, retain)UISwitch *switchView;
@property (nonatomic)BOOL isShowPrompt;
@property (nonatomic)BOOL isShowSwitch;
@property (nonatomic)BOOL isShowArrow;
@property (nonatomic)NSInteger cellRow;
@property (nonatomic)NSInteger cellSection;

@end
