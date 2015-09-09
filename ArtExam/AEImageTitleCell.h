//
//  EKWImageTitleCell.h
//  EKWStudent
//
//  Created by dahai on 14-7-28.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

/********************************************
            显示图片标题的cell
 *****************************************/

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "AEColleage.h"
#import "DBNImageView.h"
@class AEImageTitleCell;

@protocol EKWImageTitleCellDelegate <NSObject>

- (void)imageTitleCell:(AEImageTitleCell *)cell selectTypeId:(NSString *)typeId;

@end

@interface AEImageTitleCell : UITableViewCell

@property (nonatomic, strong) DBNImageView *iconImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *upTitleLabel;
@property (nonatomic, strong) UILabel *downTitleLabel;
@property (nonatomic, assign) CGSize iconSize;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *upTitle;
@property (nonatomic, strong) NSString *downTitle;
@property (nonatomic, strong) NSString *buttonTitle;

@property (nonatomic) BOOL isShowAdd;
@property (nonatomic) BOOL isShowUpDownTitle;

@property (nonatomic, assign) id<EKWImageTitleCellDelegate>delegate;

-(void)configureWithColleage:(AEColleage *)colleage;

@end
