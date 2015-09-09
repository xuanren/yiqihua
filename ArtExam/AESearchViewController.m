//
//  AESearchViewController.m
//  ArtExam
//
//  Created by dkllc on 14-9-25.
//  Copyright (c) 2014年 dkllc. All rights reserved.
//

#import "AESearchViewController.h"
#import "AEColleageList.h"
#import "AEImageTitleCell.h"
#import "AEColleageDetailController.h"
#import "DBNStatusView.h"

@interface AESearchViewController ()<UISearchBarDelegate,DBNDataEntriesDelegate>

@property (nonatomic, strong) UISearchBar *searBar;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *collegeNameTF;

@property (nonatomic, strong) AEColleageList *colleageList;
@property (weak, nonatomic) IBOutlet UITableView *collegeListTableVIew;


@end

@implementation AESearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    
    [self.colleageList clearDelegateAndCancelRequests];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.searchView.layer.cornerRadius = 1.f;
    self.searchView.layer.masksToBounds = YES;
    self.navigationItem.titleView = _searchView;
    
    [self addNavigationRightItem];
}

- (void)initNavItem{
    [super initNavItem];
    [super setCustomBackButton];
    
    self.navigationItem.title =@"搜索";
}

- (void)addNavigationRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 20);
    [rightBtn addTarget:self action:@selector(onClickSure:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
 
    [_searBar resignFirstResponder];
    
}

- (IBAction)onClickSure:(id)sender{
    
    if (![_collegeNameTF.text isEqualToString:@""] && _collegeNameTF.text != nil) {
        
        [self requestSearch];
        
        [self.collegeNameTF resignFirstResponder];
    }else{
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"学校名字不能为空！" dismissAfter:3.f];
    }
    
}

#pragma mark -- 网络请求
- (void)requestSearch{
    
    if (![_collegeNameTF.text isEqualToString:@""] && _collegeNameTF.text != nil) {
        
        self.colleageList = [[AEColleageList alloc] initWithAPIName:[DBNAPIList getSchoolListAPI]];
        self.colleageList.delegate = self;
        [self.colleageList getSearchCollectListsForKey:_collegeNameTF.text];
        [[DBNStatusView sharedDBNStatusView] showBusyStatus:@"搜索中"];
    }else{
        
        [[DBNStatusView sharedDBNStatusView] showStatus:@"学校名字不能为空！" dismissAfter:3.f];
    }
    
    
}

-(NSString*)EncodeUTF8Str:(NSString*)encodeStr{
    
    CFStringRef nonAlphaNumValidChars = CFSTR("![DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
                                  
    NSString *preprocessedString = (NSString*)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)encodeStr, CFSTR(""),kCFStringEncodingUTF8));
                                  
    NSString *newStr = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingUTF8));
    
    return newStr;
                                  
}

#pragma mark -- UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self requestSearch];
    
    [searchBar resignFirstResponder];
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_colleageList.schoolList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer = @"cell";
    AEImageTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        
        cell = [[AEImageTitleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    cell.isShowAdd = NO;
    
    [cell configureWithColleage:[_colleageList.schoolList objectAtIndex:indexPath.row]];
    
    return cell;
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [MobClick event:@"yqh026"];
    AEImageTitleCell *selCell = (AEImageTitleCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    AEColleage *college = [_colleageList.schoolList objectAtIndex:indexPath.row];
    
    AEColleageDetailController *controller = [[AEColleageDetailController alloc]initWithColleage:college withThumImg:selCell.iconImgView.image];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self requestSearch];
    return YES;
}

#pragma mark - DBNDataEntriesDelegate
- (void)dataEntriesLoaded:(DBNDataEntries*)dataEntries{
    
    [self.collegeListTableVIew reloadData];
    [[DBNStatusView sharedDBNStatusView]dismiss];
}
- (void)dataEntries:(DBNDataEntries*)dataEntries LoadError:(NSString*)error{
    
}

@end
