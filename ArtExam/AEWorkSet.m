//
//  AEWorkSet.m
//  ArtExam
//
//  Created by dkllc on 14-9-20.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AEWorkSet.h"

@implementation AEWorkSet
- (id)initWithAttributes:(NSDictionary *)att{
    self = [super init];
    if (self) {
        self.workSetId = [[att objectForKey:@"albumid"] intValue];
        self.mydescription = [att objectForKey:@"name"];
        
        if (!self.picArr) {
            self.picArr = [[NSMutableArray alloc]initWithCapacity:3];
        }
        
        NSArray *picList = [att objectForKey:@"images"];
        for (NSDictionary *dic in picList) {
            NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [_picArr addObject:mDic];
        }
        
        self.imgUrl = [[ROOTURL stringByAppendingString:IMGURL] stringByAppendingString:[att objectForKey:@"cover"]];
        
    }
    return self;
}
@end
