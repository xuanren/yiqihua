//
//  AEAdmissionsList.h
//  ArtExam
//
//  Created by Zhengen on 15-6-18.
//  Copyright (c) 2015年 DDS. All rights reserved.
//

#import "DBNDataEntries.h"

@interface AEAdmissionsList : DBNDataEntries

@property(nonatomic, strong) NSMutableArray *admissionsAry;

-(void)getMostRecentAdmissionsListWihtSid:(NSString *)sid;
-(void)getPrevAdmissionsList;

@end
