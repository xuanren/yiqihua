//
//  AEExamNews.m
//  ArtExam
//
//  Created by Zheng'en on 15-5-12.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "AEExamNews.h"

@implementation AEExamNews

- (instancetype)initWithAttributes:(NSDictionary *)att{    
    self = [super init];
    if (self) {
        self.newsId = [att objectForKey:@"id"];
        self.newsTitle = [att objectForKey:@"title"];
        self.newsCover = [att objectForKey:@"cover"];
        self.newsContont = [att objectForKey:@"content"];
        self.isHidden = [[att objectForKey:@"isHidden"] integerValue];
        self.newsCreateDate = [att objectForKey:@"cdate"];
        self.dateString = [att objectForKey:@"cdateStrinng"];
        self.createUserId = [att objectForKey:@"cuserid"];
        self.createUserName = [att objectForKey:@"cusername"];
        self.newsViews = [att objectForKey:@"views"];
        self.newsType = [att objectForKey:@"type"];
        self.typeName = [att objectForKey:@"typename"];
        self.newsImgs = [att objectForKey:@"images"];
        
        //self.newsMorder = [[att objectForKey:@"morder"] integerValue];
        //self.isFavorite = [[att objectForKey:@"isFavorite"] intValue];
    }
    
    return self;
}

@end
