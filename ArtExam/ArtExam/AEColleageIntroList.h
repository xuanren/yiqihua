//
//  AEColleageIntroList.h
//  ArtExam
//
//  Created by 冬 on 15/2/2.
//  Copyright (c) 2015年 冬. All rights reserved.
//

            /*********       简章列表       **********/

#import "DBNDataEntries.h"

@interface AEColleageIntroList : DBNDataEntries

@property (strong, nonatomic) NSMutableArray *colleageIntroListArr;


- (void)getMostRecentIntroListWihtSid:(NSString *)sid;
- (void)getPrevIntroList;

@end
