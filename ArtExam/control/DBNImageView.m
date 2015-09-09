//
//  DBNImageView.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 9/14/13.
//
//

#import "DBNImageView.h"

@implementation DBNImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
}

@end
