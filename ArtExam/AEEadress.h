//
//  AEEadress.h
//  ArtExam
//
//  Created by 冬 on 15/2/4.
//  Copyright (c) 2015年 冬. All rights reserved.
//

#import "DBNDataEntries.h"

                                    /************  校考内容  *************/

@interface AEEadress : NSObject

@property (nonatomic, strong) NSString *eadressID;
@property (nonatomic, strong) NSString *eadressTitle;

- (instancetype)initWithAttributes:(NSDictionary *)att;

@end
