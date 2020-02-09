//
//  JB_Lend_AddActionSheet_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_Account_Asset_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_Lend_AddActionSheet_View : UIScrollView
+(void)showWithModel:(JB_Account_Asset_Index_Model *)model confirmBlock:(void(^)(NSString *number,NSString *pwd))confirmblock;

//只展示安全密码
+(void)showPayPwdWithConfirmBlock:(void(^)(NSString *pwd))confirmPwdblock;
@end

NS_ASSUME_NONNULL_END
