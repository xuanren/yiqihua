//
//  DBNAPIList.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 6/13/13.
//
//

#import "DBNAPIList.h"
#import "DBNProperties.h"

@implementation DBNAPIList

//首页
+ (NSString *)getHomeListAPI{
    return @"phone/infos.do";
    return @"home/index";
}
+ (NSString *)getWorkSetAPI{
    return @"phone/albums.do";
    return @"home/getAlbums";
}

//登陆注册
+ (NSString*)getLoginAPI{
    return @"phone/phoneLogin.do";
    return @"user/login";
}

+ (NSString*)getRegisAPI{
    return @"phone/addUser.do";
    return @"user/regis";
}

//问答模块
+ (NSString*)getQuestionList{
    return @"ques/qlist";
}

+ (NSString*)getQuestionDetailsAPI{
    return @"ques/detail";
}

+ (NSString*)addNewQuestion{
    return @"ques/add";
}

+ (NSString*)getTeacherList{
    
    return @"ques/teacherList";
}

+ (NSString*)getTeacherDetail{
    
    return @"ques/teacherDetail";
}

+ (NSString*)getVerfifyAPI{
    
    return @"user/verfify";
}

+ (NSString*)getCommentAPI{
    
    return @"ques/grade";
}

//圈子
+ (NSString*)getCircleListAPI{
    return @"circle/circleList";
}
+ (NSString*)getPostListAPI{
    //图库
    return @"phone/albums.do";
    return @"circle/postList";
}
+ (NSString*)getPostDetailsAPI{
    return @"circle/postDetail";
}
+ (NSString*)newTopicAPI{
    return @"circle/post";
}
+ (NSString*)phrasePostAPI{
    return @"circle/praise";
}
+ (NSString*)commentPostAPI{
    return @"circle/comment";
}

//画室
+ (NSString *)getStudioListAPI{
    return @"studio/qlist";
}

+ (NSString *)getStudioDetailsAPI{
    return @"studio/detail";
}
+ (NSString *)getStudioIntroAPI{
    
    return @"studio/intro/studio/id";
}

//院校
+ (NSString*)getSchoolListAPI{
    return @"school/qlist.do";
    return @"college/qlist";
}
+ (NSString*)getSchoolDetailAPI{
    return @"school/detail.do";
    return @"college/detail";
}
+ (NSString*)getQuestionBankAPI{
    //考题哭
    return @"exam/examList.do";
    return @"college/examList";
}
+ (NSString*)getQuestionBankContentAPI{
    //考题库详情
    
    return @"college/examDetail/id";
}
+ (NSString*)getHotMajorListAPI{
    //热门专业
    return @"major/majorList.do";
    return @"college/specList";
}
+ (NSString*)getHotMajorContentAPI{
    //热门专业详情
    return @"college/specDetail/id";
}

+ (NSString*)getColleageIntroListAPI{
    //招生简章
    return @"intro/introList.do";
}
+ (NSString*)getColleageIntroContentAPI{
    //招生简章详情
    return @"intro/introDetail.do";
}
+ (NSString*)getMatriculateAPI{
    //录取规则
    return @"/phone/offerList.do";
}
+ (NSString*)getMatriculateDetailAPI{
    //录取规则详情
    return @"/phone/offerDetail.do";
}
+ (NSString*)getExamNewsListAPI{
    //艺考资讯
    return @"/phone/newsList.do";
}
+ (NSString*)getExamNewsListDetailAPI{
    //艺考资讯详情
    return @"/phone/newsDetail.do";
}
+ (NSString*)getEadressListAPI{
    //校考
    return @"phone/eadress.do";
}
+ (NSString*)getEadressListContentAPI{
    //校考详情
    return @"phone/eadressContent.do?id=";
}

+ (NSString*)getSchoolDetailIntroAPI{
    
    return @"college/getpage/id";
}
+ (NSString*)getAreaListAPI{
    
    return @"location/qlist";
}
+ (NSString*)getSchoolSearchAPI{
    return @"school/qlist.do";
    return @"college/search";
}

//个人中心
+ (NSString*)getUserDetailAPI{
    
    return @"user/detail";
}
+ (NSString*)getUserModifyAPI{
    return @"phone/editUser.do";
    return @"user/modify";
}
+ (NSString*)getUserFollowAPI{
    
    return @"user/follow";
}
+ (NSString*)getUserFollowerAPI{
    
    return @"user/follower";
}
+ (NSString*)getUserFollowedAPI{
    
    return @"user/followed";
}
+ (NSString*)getMyQuestionsAPI{
    
    return @"ques/my";
}
+ (NSString*)getMyTopicsAPI{
    
    return @"circle/my";
}
+ (NSString*)getCollectListAPI{
    
    return @"user/favoriteList";
}
+ (NSString*)getCollectAPI{
    
    return @"user/favorite";
}
//其他
+ (NSString*)getAdListAPI{
    return @"phone/adwares.do";
//    return @"ad/ad";
}
+ (NSString*)getGradeListAPI{
    
    return @"user/positionList";
}
+ (NSString*)getUserFeedbackAPI{
    
    return @"user/feedback";
}
@end
