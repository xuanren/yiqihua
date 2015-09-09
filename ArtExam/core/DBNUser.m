//
//  DBNUser.m
//  Dabanniu_Hair
//
//  Created by Hui Qiao on 12/31/12.
//
//

#import "DBNUser.h"
//#import "CWLSynthesizeSingleton.h"
#import "DBNProperties.h"
#import "SBJson.h"
#import "DBNAPIClient.h"
#import "DBNAPIList.h"
#import "DBNStatusView.h"
#import "OpenUDID.h"
//#import "DBNAppDelegate.h"
#import "DBNConsts.h"
#import "AEAppDelegate.h"

@interface DBNUser (PrivateMethods)

- (void)LoginDBNWithParameters:(NSMutableDictionary*)params;

@end

@implementation DBNUser

//CWL_SYNTHESIZE_SINGLETON_FOR_CLASS(DBNUser);

+(DBNUser *)sharedDBNUser {
    static dispatch_once_t pred;
    static DBNUser *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[DBNUser alloc] init];
    });
    return shared;
}

- (id)init {
    self = [super init];
    if(self) {
       [self baseInitUserInfo:[self loadUserLoginInfo]];
    }
    return self;
}

- (void)baseInitUserInfo:(NSDictionary*)info{    
    //self.sessionKey = [info objectForKey:@"session"];
    
   // NSDictionary *att = [info objectForKey:@"user"];
    self.userId = [[info objectForKey:@"id"] intValue];
    self.userName = [info objectForKey:@"username"];
    self.collectSchools = [info objectForKey:@"schools"];
    self.collectStudios = [info objectForKey:@"studio"];
    self.collectTopics = [info objectForKey:@"topics"];
    self.avatarUrl = [info objectForKey:@"headimg"];
    /*
    self.academyName = [info objectForKey:@"academyname"];
    self.avatarUrl = [info objectForKey:@"avatarurl"];
    self.myDescription = [info objectForKey:@"desc"];
    self.studioName = [info objectForKey:@"studioname"];
    self.position = [info objectForKey:@"position"];
    
    if ([[info objectForKey:@"verfify"] intValue] == 1) {
        self.isVerified = YES;
    }else self.isVerified = NO;
    
    switch ([[info objectForKey:@"roleid"] intValue]) {
        case 1:
            self.userRole = AEStudent;
            break;
        case 2:
            self.userRole = AETeacher;
            break;
        default:
            self.userRole = AEStudent;
            break;
    }
    
    if([info objectForKey:@"exprietime"]) {
        long long timeSince = [[info objectForKey:@"exprietime"] longLongValue];
        if (timeSince == 0)
        {
            self.expirationDate = [NSDate distantFuture];
        }
        else
        {
            self.expirationDate = [NSDate dateWithTimeIntervalSince1970:timeSince];
        }
    }
    */
    
}

- (BOOL)isLoggedIn {
    
    return _sessionKey;
    
    NSDate *now = [NSDate date];
    return _sessionKey && _expirationDate && [now compare:_expirationDate] == NSOrderedAscending;
}

- (void)loginWithUserName:(NSString*)uName andPassword:(NSString*)passwd {
//    DBNAppDelegate *appDelegate = (DBNAppDelegate*)[UIApplication sharedApplication].delegate;
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
//    [params setObject:uName forKey:@"nick"];
//    [params setObject:passwd forKey:@"pwd"];
//    if(appDelegate.deviceToken) {
//        [params setObject:appDelegate.deviceToken forKey:@"APNToken"];
//    }
//    [self LoginDBNWithParameters:params];
}

- (void)initUser:(NSDictionary *)info withSessionId:(NSString*)sessionId{
    self.sessionKey = sessionId;
    [self initUser:info];
}

- (void)initUser:(NSDictionary*)info {
    [self baseInitUserInfo:info];
    [self saveUserInfo:info];
    [[NSNotificationCenter defaultCenter] postNotificationName:DBN_LOGIN_STATUS_CHANGE object:self];
}

- (void)updateUserInfo:(NSDictionary*)info{
//    if(info == nil || [info objectForKey:@"uID"] == nil || [[info objectForKey:@"uID"] intValue] < 0) return;
//    _hID = [[info objectForKey:@"uID"] intValue];
//    self.userName = [info objectForKey:@"userName"];
//    self.avatarURL = [info objectForKey:@"avatarURL"];
//    
//    NSMutableDictionary *tmp = [[NSMutableDictionary alloc]initWithDictionary:info];
//    [tmp setObject:self.sessionKey forKey:@"sessionKey"];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[self.expirationDate timeIntervalSince1970]];
//    [tmp setObject:timeSp forKey:@"expirationDate"];
//    [self saveUserInfo:tmp];
    
    [self baseInitUserInfo:info];

    //[self saveUserInfo:info];
}

- (void)logout {
    self.sessionKey = nil;
    self.expirationDate = nil;
    self.userName = nil;
    self.avatarUrl = nil;
    self.position = nil;
    self.userRole = 0;
    [self removeUserLoginInfo];
    [[DBNStatusView sharedDBNStatusView]dismiss];
    [[NSNotificationCenter defaultCenter] postNotificationName:DBN_LOGOUT object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:DBN_LOGIN_STATUS_CHANGE object:self];
}

-(void)loginDBNFromWeibo:(SinaWeibo *)sinaWeibo{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    [params setObject:sinaWeibo.userID forKey:@"sid"];
    [params setObject:sinaWeibo.accessToken forKey:@"accessToken"];
    AEAppDelegate *appDelegate = (AEAppDelegate*)[UIApplication sharedApplication].delegate;
    if(appDelegate.deviceToken) {
        [params setObject:appDelegate.deviceToken forKey:@"APNToken"];
    }
    [self LoginDBNWithParameters:params];
}

- (void)loginDBNFromQQ:(TencentOAuth*)tencent {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    [params setObject:tencent.openId forKey:@"openid"];
    [params setObject:tencent.accessToken forKey:@"accessToken"];
//    AEAppDelegate *appDelegate = (AEAppDelegate*)[UIApplication sharedApplication].delegate;
//    if(appDelegate.deviceToken) {
//        [params setObject:appDelegate.deviceToken forKey:@"APNToken"];
//    }
    [self LoginDBNWithParameters:params];
}

-(void)saveUserInfo:(NSDictionary*)userInfo{
    NSString *jsonPath = [[DBNProperties sharedDBNProperties].cachePath stringByAppendingPathComponent:@"user/userLogin.json"];
    NSString *userPath= [[DBNProperties sharedDBNProperties].cachePath stringByAppendingPathComponent:@"user"];
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    if (![fileManager fileExistsAtPath:userPath]) {
         [fileManager createDirectoryAtPath:userPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
    NSString *profileStr = [writer stringWithObject:userInfo];
    if ([profileStr writeToFile:jsonPath atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
        NSLog(@"write succeed");
    }else{
        NSLog(@"write faild");
    }
   // [profileStr writeToFile:jsonPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(NSDictionary*)loadUserLoginInfo{
    NSString *jsonPath = [[DBNProperties sharedDBNProperties].cachePath stringByAppendingPathComponent:@"user/userLogin.json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    if(!jsonStr) return nil;
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    return [parser objectWithString:jsonStr];
}

-(void)removeUserLoginInfo{
    NSString *jsonPath = [[DBNProperties sharedDBNProperties].cachePath stringByAppendingPathComponent:@"user/userLogin.json"];
    NSFileManager *fileManager =[[NSFileManager alloc] init];
    [fileManager removeItemAtPath:jsonPath error:nil];
}


#pragma mark- private methords
- (void)LoginDBNWithParameters:(NSMutableDictionary*)params {
    [[DBNAPIClient sharedClient] postPath:[DBNAPIList getLoginAPI]
                               parameters:params
                               needIdInfo:NO
                                  success:^(AFHTTPRequestOperation *operation, id JSON) {
                                     // NSLog(@"%@", JSON);
                                      if([[JSON objectForKey:@"code"] intValue] != 0) {
                                          
                                          NSDictionary *errorObj = [NSDictionary dictionaryWithObject:[JSON objectForKey:@"error"]
                                                                                               forKey:@"errorString"];
                                          [[NSNotificationCenter defaultCenter] postNotificationName:DBN_LOGIN_FAIL object:self userInfo:errorObj];
                                          return;
                                      }
                                      [[DBNUser sharedDBNUser] initUser:[JSON objectForKey:@"data"]];
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSDictionary *errorObj = [NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"];
                                      [[NSNotificationCenter defaultCenter] postNotificationName:DBN_LOGIN_FAIL object:self userInfo:errorObj];
                                  }];
}

@end
