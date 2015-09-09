//
//  AEMatriculateList.h
//  ArtExam
//
//  Created by Zhengen on 15-6-10.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "DBNDataEntries.h"

@interface AEMatriculateList : DBNDataEntries

@property(nonatomic, strong) NSMutableArray *matriculateAry;

-(void)getMostRecentMatriculateListWihtSid:(NSString *)sid;
-(void)getPrevMatriculateList;

@end
