//
//  AEExamNewsList.h
//  ArtExam
//
//  Created by Zheng'en on 15-5-12.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "DBNDataEntries.h"
#import "AEExamNews.h"

@interface AEExamNewsList : DBNDataEntries

@property (nonatomic, strong) NSMutableArray *examNewsList;
@property (nonatomic, strong) AEExamNews *examNewsDetail;
@property (nonatomic, strong) NSString *examNewsId;



//liubo 添加
//@property (nonatomic, copy) void (^ resultBlock)(id JSON);

- (void)getMostRecentExamNewsWithSuccess:(void (^)(id))result;
- (void)getMostRecentExamNews;
- (void)getPrevExamNews;
@end
