//
//  AESegalView.m
//  ArtExam
//
//  Created by 360 on 14-12-19.
//  Copyright (c) 2014年 360. All rights reserved.
//

#import "AESegalView.h"

@interface AESegalView ()

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray * menuButtonArray;
@property (nonatomic, strong) IBOutlet UIView * tagView;
@property (nonatomic, strong) void (^ menuBlock) (int selectedIndex);
@property (nonatomic, strong) IBOutlet NSLayoutConstraint * tagViewLayout;

@end

@implementation AESegalView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    self.tagView.layer.masksToBounds = YES;
    self.tagView.layer.cornerRadius = 2;
}

+ (instancetype)segalViewWith:(void (^)(int))menuBlock
{
    AESegalView * view = [[[NSBundle mainBundle] loadNibNamed:@"AESegalView" owner:nil options:nil] lastObject];

    view.menuBlock = menuBlock;
    return view;
}

/**
*  菜单按钮点击事件
*
*  @param button 点击的菜单按钮
*/
- (IBAction)menuButtonPressed:(UIButton *)button
{
    if (button.selected)
    {
        return;
    }

    for (UIButton * button in self.menuButtonArray)
    {
    button.selected = NO;
    }
    button.selected = YES;
    int index = (int)button.tag;

    self.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = self.tagView.center;
        center.x = button.center.x;
        self.tagViewLayout.constant = center.x;
        [self.tagView setNeedsLayout];
        [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
    }];
        
    
    if (self.menuBlock)
    {
        self.menuBlock(index);
    }
}


@end
