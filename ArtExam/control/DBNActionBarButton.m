//
//  DBNActionBarButton.m
//  Dabanniu_Hair
//
//  Created by Cao Jianglong on 4/19/13.
//
//

#import "DBNActionBarButton.h"

@implementation DBNActionBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *btnImg = [UIImage imageNamed:@"nav-action-btn"];
        UIImage *stretchBtnImg = [btnImg stretchableImageWithLeftCapWidth:btnImg.size.width/2
                                                             topCapHeight:btnImg.size.height/2];
        [self setBackgroundImage:stretchBtnImg forState:UIControlStateNormal];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        UIImage *btnImg = [UIImage imageNamed:@"nav-action-btn"];
        UIImage *stretchBtnImg = [btnImg stretchableImageWithLeftCapWidth:btnImg.size.width/2
                                                             topCapHeight:btnImg.size.height/2];
        [self setBackgroundImage:stretchBtnImg forState:UIControlStateNormal];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
