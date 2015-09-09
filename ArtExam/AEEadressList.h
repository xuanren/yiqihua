//
//  AEEadressList.h
//  ArtExam
//
//  Created by 冬 on 15/2/4.
//  Copyright (c) 2015年 冬. All rights reserved.
//

#import "DBNDataEntries.h"
#import "AEEadress.h"
                            /************  校考列表  *************/

@interface AEEadressList : DBNDataEntries

@property (nonatomic, strong) NSMutableArray *eadressListArr;
@property (nonatomic, strong) AEEadress *eadressDetail;

- (void)getMostRecentEadressList;
- (void)getPrevEadressList;

@end
