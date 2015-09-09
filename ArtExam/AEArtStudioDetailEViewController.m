//
//  AArtStudioDetailEViewController.m
//  ArtExam
//
//  Created by chen on 15/8/13.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "AEArtStudioDetailEViewController.h"

@interface AEArtStudioDetailEViewController ()

@end

@implementation AEArtStudioDetailEViewController
- (id)initWithStudioInfoDictionary : (NSDictionary *)studio_info
{
    self = [super init];
    if (self) {
        m_dic_studio_info = [[NSDictionary alloc]initWithDictionary:studio_info];
    }
    return self;
}
- (UIImageView *)downloadImage
{
    NSString *imgId = [[[m_dic_studio_info objectForKey:@"excellentWorks"]objectAtIndex:0]objectForKey:@"id"];
    NSString *url = [NSString stringWithFormat:@"http://www.yiqihua.cn/artbox/phone/idownload.do?fileid=%@",imgId];
    __block DBNImageView *tmpImg = [[DBNImageView alloc]initWithFrame:CGRectMake(10, 17, 100, 66)];
    [tmpImg setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    return tmpImg;
}
- (UILabel *)create_center_label :(CGRect)frame :(NSString *)describ :(NSString *)key
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = [NSString stringWithFormat:@"%@：%@",describ,[m_dic_studio_info objectForKey:key]];
    label.font = [UIFont fontWithName:@"Arial" size:14];
    label.textColor = [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    return label;
}
- (void)look_up_image_button_pressed
{
    AEShowColleagePicsController *showPics = [[AEShowColleagePicsController alloc] initWithWorkSet:[m_dic_studio_info objectForKey:@"excellentWorks"]];
    showPics.title = [NSString stringWithFormat:@"画室"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:showPics animated:YES];
}
- (void)jump_to_studio_profile
{
    NSString *str_url = [NSString stringWithFormat:@"http://www.yiqihua.cn/artbox/studio/detailText.action?type=1&studioId=%@",[m_dic_studio_info objectForKey:@"id"]];
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:str_url];
    controller.webTitle = @"详情";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)jump_to_studio_environment
{
    AEShowColleagePicsController *showPics = [[AEShowColleagePicsController alloc] initWithWorkSet:[m_dic_studio_info objectForKey:@"images"]];
    showPics.title = [NSString stringWithFormat:@"画室"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:showPics animated:YES];
}
- (void)jump_to_studio_information
{
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:nil];
    controller.webTitle = @"详情";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)jump_to_studio_admission
{
    NSLog(@"招生简章");
    NSString *str_url = [NSString stringWithFormat:@"http://www.yiqihua.cn/artbox/intro/introDetail.do?introId=%@",[m_dic_studio_info objectForKey:@"id"]];
    DBNWebViewController *controller = [[DBNWebViewController alloc]initWithWebUrl:str_url];
    controller.webTitle = @"详情";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (UIButton *)create_up_view
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 101)];
    UIImageView *imageView = [self downloadImage];
    
    [button addSubview:imageView];
    UILabel *studio_best_label = [[UILabel alloc]initWithFrame:CGRectMake(125, 23, 113, 21)];
    studio_best_label.text = @"画室优秀作品";
    studio_best_label.textColor = [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    studio_best_label.font = [UIFont fontWithName:@"Arial" size:18];
    [button addSubview:studio_best_label];
    
    UILabel *page_label = [[UILabel alloc]initWithFrame:CGRectMake(145, 59, 90, 21)];
    page_label.text = @"张图片";
    page_label.textColor = [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    page_label.font = [UIFont fontWithName:@"Arial" size:14];
    [button addSubview:page_label];
    
    UILabel *number_label = [[UILabel alloc]initWithFrame:CGRectMake(125, 59, 20, 21)];
    number_label.text = [NSString stringWithFormat:@"%d",[[m_dic_studio_info objectForKey:@"excellentWorks"]count]];
    number_label.textColor = [UIColor orangeColor];
    number_label.font = [UIFont fontWithName:@"Arial" size:14];
    number_label.textAlignment = NSTextAlignmentRight;
    [button addSubview:number_label];
    
    UIImageView *next_img_view = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 24, 42, 10, 16)];
    next_img_view.image = [UIImage imageNamed:@"common_right.png"];
    [button addSubview:next_img_view];
    [button addTarget:self action:@selector(look_up_image_button_pressed) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (UIView *)create_center_view
{
    UIView *center_view = [[UIButton alloc]initWithFrame:CGRectMake(-1, 101, self.view.frame.size.width+2, 171)];
    center_view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    center_view.layer.borderWidth = 1.0;
    
    [center_view addSubview:[self create_center_label:CGRectMake(14, 6, self.view.frame.size.width-28, 33) :@"所在地区" :@"city"]];
    
    [center_view addSubview:[self create_center_label:CGRectMake(14, 39, self.view.frame.size.width-28, 33) :@"创办时间" :@"year"]];
    
    [center_view addSubview:[self create_center_label:CGRectMake(14, 72, self.view.frame.size.width-28, 33) :@"画室规模" :@"stunum"]];
    
    [center_view addSubview:[self create_center_label:CGRectMake(10, 105, self.view.frame.size.width-14, 33) :@"画室地址" :@"address"]];
    
    [center_view addSubview:[self create_center_label:CGRectMake(14, 138, self.view.frame.size.width-28, 33) :@"联系电话" :@"phone"]];
    return center_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [m_dic_studio_info objectForKey:@"name"];
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100)];
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-90);
    scrollview.scrollEnabled = YES;
    [self.view addSubview:scrollview];
    
    //创建并添加上面的view
    [scrollview addSubview:[self create_up_view]];
    //创建中间显示简介的view
    [scrollview addSubview:[self create_center_view]];
    
    //创建画室简介
    [scrollview addSubview:[self create_profile_view:CGRectMake(0, 272, self.view.frame.size.width, 45) :@"画室简介" :@selector(jump_to_studio_profile) :false]];
    [scrollview addSubview:[self create_profile_view:CGRectMake(-1, 317, self.view.frame.size.width+2, 45) :@"画室环境" :@selector(jump_to_studio_environment) :true]];
    [scrollview addSubview:[self create_profile_view:CGRectMake(0, 362, self.view.frame.size.width, 45) :@"画室资讯" :@selector(jump_to_studio_information) :false]];
    [scrollview addSubview:[self create_profile_view:CGRectMake(-1, 407, self.view.frame.size.width+2, 45) :@"招生简章" :@selector(jump_to_studio_admission) :true]];
    
}
- (UIView *)create_student_view :(CGRect)frame :(NSString *)title
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UILabel *left = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 213, 21)];
    left.text = title;
    left.textColor = [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    left.font = [UIFont fontWithName:@"Arial" size:14];
    [view addSubview:left];
    UIImageView *pre_img_view = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 24, 14, 10, 14)];
    pre_img_view.image = [UIImage imageNamed:@"common_right.png"];
    [view addSubview:pre_img_view];
    return view;
}
- (UILabel *)create_number_label
{
    UILabel *number_label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 14, 50, 16)];
    number_label.text = [NSString stringWithFormat:@"%d 张",[[m_dic_studio_info objectForKey:@"images"] count]];
    number_label.textColor = [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    return number_label;
}
- (UIButton *)create_profile_view :(CGRect)frame :(NSString *)title :(SEL)btn_pressed :(BOOL)isBorder
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    UILabel *left = [[UILabel alloc]initWithFrame:CGRectMake(14, 12, 213, 21)];
    left.text = title;
    left.textColor = [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    left.font = [UIFont fontWithName:@"Arial" size:14];
    [button addSubview:left];
    UIImageView *next_img_view = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 24, 14, 10, 16)];
    next_img_view.image = [UIImage imageNamed:@"common_right.png"];
    [button addSubview:next_img_view];
    if ([title isEqualToString:@"画室环境"])
    {
        [button addSubview:[self create_number_label]];
    }
    if (isBorder)
    {
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    [button addTarget:self action:btn_pressed forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
