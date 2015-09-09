//
//  AETopicListTableView.m
//  ArtExam
//
//  Created by dkllc on 14-9-10.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AETopicListTableView.h"
#import "AETopicListCell.h"
#import "AETopicDetailsController.h"

@interface  AETopicListTableView()
<
UITableViewDataSource
,UITableViewDelegate
>
@end

static NSString* cellIdentifier = @"AETopicListCell";


@implementation AETopicListTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self registerNib:[UINib nibWithNibName:@"AETopicListCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        self.dataSource = self;
        self.delegate = self;
        
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];


    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self registerNib:[UINib nibWithNibName:@"AETopicListCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        self.dataSource = self;
        self.delegate = self;
        
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    }
    return self;
}

- (void)setTopicList:(AETopicList *)topicList{
    _topicList = topicList;
    [self reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.topicList.topicArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AETopicListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell configureWithTopic:[self.topicList.topicArr objectAtIndex:indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AETopic *topic = [self.topicList.topicArr objectAtIndex:indexPath.row];
    
    AETopicDetailsController *controller = [[AETopicDetailsController alloc]initWithPostId:topic.topicId];
    controller.hidesBottomBarWhenPushed = YES;
    [self.rootController.navigationController pushViewController:controller animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [AETopicListCell heightForTopicListCellWithTopic:[self.topicList.topicArr objectAtIndex:indexPath.row]];
}


@end
