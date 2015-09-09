//
//  SYDLSetCell.m
//  SYDLMYParents
//
//  Created by dahai on 14-3-7.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "SYDLSetCell.h"
#import "DBNUtils.h"

@interface SYDLSetCell ()


@end

@implementation SYDLSetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self initialization];
    }
    return self;
}

- (void)dealloc
{
    [_titleLabel release];
    [_promptLabel release];
    [_arrowImageView release];
    [_switchView release];
    
    [super dealloc];
}

- (void)setIsShowPrompt:(BOOL)isShowPrompt
{
    if (!isShowPrompt) {
        
        self.promptLabel.hidden = YES;
    }
}

- (void)setIsShowSwitch:(BOOL)isShowSwitch
{
    if (!isShowSwitch) {
        
        self.switchView.hidden = YES;
    }
}

- (void)setIsShowArrow:(BOOL)isShowArrow
{
    if (!isShowArrow) {
        
        self.arrowImageView.hidden = YES;
    }else{
        self.arrowImageView.hidden = NO;
    }
}

- (void)initialization
{
    float arrowX = 295;
    float switchX = 45;
    float switchY = 5;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        arrowX = 285;
        switchX = 65;
        switchY = 8;
    }
    self.arrowImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(arrowX, 12, 10, 16)] autorelease];
    self.arrowImageView.image = [UIImage imageNamed:@"common_right.png"];
    [self.contentView addSubview:_arrowImageView];
    
    self.switchView = [[[UISwitch alloc] initWithFrame:CGRectMake(arrowX - switchX, switchY, 47, 31)] autorelease];
    [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_switchView];
    
    self.titleLabel = [self labelFram:CGRectMake(18, 10, 150, 20) title:@" " superView:self.contentView];
    self.promptLabel = [self labelFram:CGRectMake(140, 10, arrowX - 155, 20) title:@" " superView:self.contentView];
    _promptLabel.textAlignment = NSTextAlignmentRight;
    [_promptLabel setNumberOfLines:0];
    
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
    line.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    [self.contentView addSubview:line];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    
}

- (void)switchChange:(UISwitch *)switchs
{
    NSLog(@"%d",switchs.on);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (_cellSection == 0) {
        
        if (_cellRow == 0) {
            
            if (switchs.on) {
                
                [defaults setValue:@"1" forKey:@"sound"];
            }else{
                
                [defaults setValue:@"0" forKey:@"sound"];
            }
        }else if(_cellRow == 1){
            
            if (switchs.on) {
                
                [defaults setValue:@"1" forKey:@"shake"];
            }else{
                
                [defaults setValue:@"0" forKey:@"shake"];
            }
        }
        
    }else if (_cellSection == 1){
        
        if (switchs.on) {
            
            [defaults setValue:@"1" forKey:@"netWork"];
        }else{
            
            [defaults setValue:@"0" forKey:@"netWork"];
        }
        
    }
    
    [defaults synchronize];
    
}

- (UILabel *)labelFram:(CGRect)frame title:(NSString *)title  superView:(UIView *)sView
{
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.font = [UIFont systemFontOfSize:14.f];
    label.text = title;
    label.textColor = [DBNUtils getColor:@"69707A"];
    [sView addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
