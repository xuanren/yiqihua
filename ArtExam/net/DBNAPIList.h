//
//  DBNAPIList.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 6/13/13.
//
//

#import <Foundation/Foundation.h>

@interface DBNAPIList : NSObject{
}

//首页
+ (NSString *)getHomeListAPI;
+ (NSString *)getWorkSetAPI;


//登录注册
+ (NSString*)getLoginAPI;
+ (NSString*)getRegisAPI;

//问答模块
+ (NSString*)getQuestionList;
+ (NSString*)getQuestionDetailsAPI;
+ (NSString*)addNewQuestion;
+ (NSString*)getTeacherList;
+ (NSString*)getTeacherDetail;
+ (NSString*)getVerfifyAPI;  //申请认证老师
+ (NSString*)getCommentAPI;

//圈子
+ (NSString*)getCircleListAPI;
+ (NSString*)getPostListAPI;
+ (NSString*)getPostDetailsAPI;
+ (NSString*)newTopicAPI;
+ (NSString*)phrasePostAPI;
+ (NSString*)commentPostAPI;

//画室
+ (NSString *)getStudioListAPI;
+ (NSString *)getStudioDetailsAPI;
+ (NSString *)getStudioIntroAPI;      //获取画室简介

//院校
+ (NSString*)getSchoolListAPI;
+ (NSString*)getSchoolDetailAPI;
+ (NSString*)getQuestionBankAPI;
+ (NSString*)getQuestionBankContentAPI;
+ (NSString*)getHotMajorListAPI;
+ (NSString*)getHotMajorContentAPI;
+ (NSString*)getColleageIntroListAPI;
+ (NSString*)getColleageIntroContentAPI;
+ (NSString*)getEadressListAPI;
+ (NSString*)getEadressListContentAPI;
+ (NSString*)getSchoolDetailIntroAPI;
+ (NSString*)getAreaListAPI;
+ (NSString*)getSchoolSearchAPI;
+ (NSString*)getMatriculateAPI;
+ (NSString*)getMatriculateDetailAPI;
+ (NSString*)getExamNewsListAPI;
+ (NSString*)getExamNewsListDetailAPI;

//个人中心
+ (NSString*)getUserDetailAPI;
+ (NSString*)getUserModifyAPI;        //修改个人信息
+ (NSString*)getUserFollowAPI;        //关注/取消关注
+ (NSString*)getUserFollowerAPI;      //获得粉丝列表
+ (NSString*)getUserFollowedAPI;      //获的关注列表
+ (NSString*)getMyQuestionsAPI;
+ (NSString*)getMyTopicsAPI;
+ (NSString*)getCollectListAPI;
+ (NSString*)getCollectAPI;           //收藏

//其他
+ (NSString*)getAdListAPI;            //获取广告列表
+ (NSString*)getGradeListAPI;         //获取年级列表
+ (NSString*)getUserFeedbackAPI;      //意见反馈

@end
