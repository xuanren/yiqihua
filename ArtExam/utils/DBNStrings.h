//
//  DBNStrings.h
//  Dabanniu_Hair
//
//  Created by Cao Jianglong on 7/31/13.
//
//

#import <Foundation/Foundation.h>

@interface DBNStrings : NSObject

#define DBN_REQUEST_API_FAIL @"妞，网络有点慢，再刷新试试！"
#define DBN_INVALID_DOWNLOAD_URL    @"无效的下载地址"
#define DBN_POST_IN_PROGRESS    @"正在上传中..."

// 支付
#define DBN_ALIPAY_SERVER_LINK_ERROR    @"支付发生异常，请重新预约!"
#define DBN_ALIPAY_PAYMENT_FAIL         @"交易失败，请重试！"
#define DBN_ALIPAY_PAYMENT_SUCCEED      @"交易成功！"

// 圈子
#define DBN_GROUP_POST_IN_PROGRESS      @"发布中..."
#define DBN_GROUP_POST_SUCCEED          @"发布成功"
#define DBN_GROUP_COMMENT_IN_PROGRESS   @"评论中..."
#define DBN_GROUP_COMMENT_SUCCEED       @"评论成功"

@end
