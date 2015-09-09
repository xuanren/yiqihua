//
//  DBNUser.h
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 12/31/12.
//
//

#import <Foundation/Foundation.h>
//#import <TencentOpenAPI/TencentOAuth.h>
#import "SinaWeibo.h"
#import "TencentOAuth.h"

typedef enum {
    AEStudent= 1,
    AETeacher=2
} UserRole;


@interface DBNUser : NSObject

@property (nonatomic, strong) NSString *collectSchools; //收藏的学校
@property (nonatomic, strong) NSString *collectStudios; //收藏的画室
@property (nonatomic, strong) NSString *collectTopics;  //收藏的图片
@property (nonatomic, strong) NSString *avatarUrl;      //头像地址


@property (nonatomic, strong) NSString *academyName;
@property (nonatomic, strong) NSString *teacherDesc;
@property (nonatomic, strong) NSString *myDescription;
@property (nonatomic) int userId;

@property (nonatomic, strong) NSString *teacherPosition;
@property (nonatomic) UserRole userRole;
@property (nonatomic, strong) NSString *studioName;
@property (nonatomic) BOOL isVerified;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSDictionary *position;

@property (nonatomic, strong) NSString *sessionKey;
@property (nonatomic, strong) NSDate *expirationDate;

@property (nonatomic, readonly, getter = isLoggedIn) BOOL loggedIn;


+ (DBNUser*)sharedDBNUser;

- (void)loginWithUserName:(NSString*)uName andPassword:(NSString*)passwd;
- (void)loginDBNFromWeibo:(SinaWeibo *)sinaWeibo;
- (void)loginDBNFromQQ:(TencentOAuth*)tencent;
- (void)initUser:(NSDictionary*)info;
- (void)initUser:(NSDictionary *)info withSessionId:(NSString*)sessionId;
- (void)logout;
- (void)saveUserInfo:(NSDictionary*)userInfo;
- (NSDictionary*)loadUserLoginInfo;
- (void)removeUserLoginInfo;

- (void)updateUserInfo:(NSDictionary*)info;

@end
