//
//  DBNConsts.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Dabanniu_Hair_DBNConsts_h

//******

#define CDDFIX

#define POSTPAGESIZE @"pageSize"    // @"num"
#define POSTPAGENUM  @"pageNumber"  // @"cursor"

#define TestURL @"http://192.168.1.106/artbox/"
//#define ROOTURL @"http://192.168.1.103/artbox"
#define ROOTURL @"http://www.yiqihua.cn/artbox/"
#define IMGURL @"phone/idownload.do?fileid="
#define IMGDOWNLOADURL @"phone/adownload.do?fileid="
//首页详情
#define HOMEINFO @"phone/infoContent.do?beanid="

//院校 --- 广告详情
#define COLLEGEADINFO @"phone/adwareContent.do?beanid="
//院校 --- 题库详情
#define EXAMINFO @"exam/examDetail.do?examId="
//院校 --- 热门专业详情
#define HOTMAJOR @"major/majorDetail.do?majorId="
//院校 --- 学校简介
#define COLLEAGEBRIEFINTRODUCE @"school/detailText.action?type=1&collegeId="
//院校 --- 学校专业介绍
#define COLLEAGEMAJORINTRODUCE @"school/detailText.action?type=3&collegeId="
//院校 --- 学校考题

//院校 --- 艺考资讯
#define EXAMNEWSINFO @"/phone/newsDetail.do?beanid="
//院校 --- 录取规则
#define MATRICINFO @"/phone/offerDetail.do?beanid="
//院校 --- 招生简章
#define ADMISSIONSINFO @"/intro/introDetail.do?beanid="

//图库

typedef enum {
    AETopicJinghua = 1,
    AETopicRecommand = 2,
    AETopicALL = 3,
} TopicType;

#define IMGALUM @"phone/albums.do"



//******

#define Dabanniu_Hair_DBNConsts_h

#define DEBUG 1

#define DBN_LOGIN_STATUS_CHANGE          @"dbn_login_status_change"
#define DBN_LOGIN_FAIL                   @"dbn_login_fail"
#define DBN_LOGOUT                       @"dbn_logout"

#define DBN_UPDATE_CUSTOMER_INFO                       @"dbn_update_cus_info"


#define kWBSDKAppKey2       @"504445686"
#define kWBSDKAppSecret2    @"ccd980d03c385cc22d13a74d0e2d9cae"


#define kWBSDKAppKey       @"1021895376"
#define kWBSDKAppSecret    @"dec4763aa683ee604c8943dfb4daf251"
#define kAppRedirectURI     @"http://www.yiqihua.cn"

#define MAX_PHOTO_SIZE      1024
#define MAX_SHARE_PHOTO_SIZE      512

// user default constants
#define kAppVersion         @"appVersion"
#define kStartCount         @"startCount"
//#define kShowModelPhoto     @"showModelPhoto"
#define kUserPhotoUploaded  @"showPhoto"
#define kEditorHelpShown    @"editorHelpShown"
#define kAdjustHairHelpShown @"adjustHairHelpShown"
#define kDownloadHairPackTipShown   @"downloadHairPackTipShown"
#define kDefaultHairPackDownloaded  @"defaultHairPackDownloaded"
#define kAPNTokenSent       @"APNTokenSent"
#define kRateAppAlertShown  @"rateAppAlertShown"
#define kFollowDBNDone      @"followDBNDone"
#define kAdjustContourExampleShown @"adjustContourExampleShown"
#define kPrevTriedPhoto     @"prevTriedPhoto"

#define kSinaWeiboAuthData  @"SinaWeiboAuthData"
#define kQQAuthData @"QQAuthData"
#define kUserDefaultKeyListAlbumId @"kUserDefaultKeyListAlbumId"

#define kUmengChannelId     @"App Store"
//#define kUmengChannelId     @"91store"

#define kWeixinAppID        @"wxa5d7051828efdc40"
#define kQQAppID            @"1103185935"

#define kBaiduMapKey        @"1ABD62585FDC5F522930D2B5C7B768F0C45C91AA"

#define kWebUrl              @"http://ae.bdqrc.cn/"

#endif
