//
//  AEAdList.h
//  ArtExam
//
//  Created by dahai on 14-10-8.
//  Copyright (c) 2014年 dahai. All rights reserved.
//

#import "DBNCachedDataEntries.h"
#import "AEAdvertisement.h"

@interface AEAdList : DBNCachedDataEntries

@property (nonatomic, strong) NSMutableArray *adAry;

- (id)initWithAPIName:(NSString*)apiName andFrom:(int)type;

- (void)getadList;

@end
