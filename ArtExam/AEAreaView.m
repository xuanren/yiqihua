//
//  AEAreaView.m
//  TestAutoLayout
//
//  Created by dahai on 14-9-26.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "AEAreaView.h"
#import "DBNUtils.h"

@implementation AEAreaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _paddingL = 20;
        _paddingT = 20;
        _paddingV = 10;
        _paddingH = 15;
        _titleViewHeight = 25;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        _paddingL = 20;
        _paddingT = 20;
        _paddingV = 10;
        _paddingH = 15;
        _titleViewHeight = 25;
    }
    
    return self;
}

- (void)upDataAreaList:(NSArray *)array showColumn:(int)colum{
    
    if ([array count] == 0) {
        
        return;
    }
    
    if (colum == 0) {
        
        return;
    }
    
    if (colum > 3) {
        
        colum = 3;
    }
    
    self.areaList = [NSArray arrayWithArray:array];
    
    int verticalSpace = 0;
    
    if (colum > 1) {
        
        verticalSpace = colum - 1;
    }
    
    float titleViewWith = (self.frame.size.width - 2*_paddingL - verticalSpace*_paddingV) / colum;
    
    CGRect rect = CGRectMake(_paddingL, _paddingT, titleViewWith, _titleViewHeight);
    int count = 0;
    for (int i = 0; i < [array count]; i ++) {
        
        count ++;
        
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = rect;
        titleBtn.tag = 100 + i;
        [titleBtn setTitle:[[array objectAtIndex:i] objectForKey:@"name"] forState:UIControlStateNormal];
        titleBtn.backgroundColor = [UIColor whiteColor];
        [titleBtn addTarget:self action:@selector(onClickArea:) forControlEvents:UIControlEventTouchUpInside];
        [titleBtn setTitleColor:[DBNUtils getColor:@"69707A"] forState:UIControlStateNormal];
        [self addSubview:titleBtn];
        [titleBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        
        rect.origin.x += rect.size.width + _paddingV;
        if (count == colum) {
            
            rect.origin.y += rect.size.height + _paddingH;
            rect.origin.x = _paddingL;
            count = 0;
        }
    }
    
    
    
    float contenHeight = rect.origin.y + rect.size.height + _paddingT;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, contenHeight);
    if (contenHeight > self.frame.size.height) {
        
        self.contentSize = CGSizeMake(self.frame.size.width, contenHeight);
    }
}

- (IBAction)onClickArea:(UIButton *)sender{
    
    int index = sender.tag % 100;
    if (_delegatee) {
        
       [_delegatee areaView:self selectIndex:index];
    }
}

@end
