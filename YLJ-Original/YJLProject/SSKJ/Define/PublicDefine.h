//
//  PublicDefine.h
//  SSKJ
//
//  Created by James on 2018/6/14.
//  Copyright © 2018年 James. All rights reserved.
//

static NSString * const AppLanguage = @"appLanguage";

// 语言国际化
#define SSKJLocalized(key, comment) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]


//[[NSUserDefaults standardUserDefaults]objectForKey:@"kPhoneNumber"]
#define kPhoneNumber [[NSUserDefaults standardUserDefaults]objectForKey:@"kPhoneNumber"]
#define kISCMPhoneNumber   [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"]
#define kLogin [SSKJUserDefaultsGET(@"kLogin") boolValue]
#define kPWD SSKJUserDefaultsGET(@"kPWD")
#define KName SSKJUserDefaultsGET(@"KName")

#define kauth_emailIndex [[NSUserDefaults standardUserDefaults]objectForKey:@"kauth_emailIndex"]


#define showAlert(mesg)  [MBProgressHUD showError:mesg];

#define SUCCEED   @"200"
typedef NS_ENUM(NSInteger, ICC_Mall_OrderDetail_HandleItemType) {
    kuserCancelOrderEvent = 100,//取消订单
    kuserGoPayOrderEvent = 101,//去支付
    kuserSureOrderEvent = 102, //确认订单
    kuserDeleteOrderEvent = 103,//删除订单
    kuserContactShopEvent = 104, //联系商家
    kbusnessSendGoodsOrederEvent = 105, //商家发货
    kbusnessDeleteOrderEvent = 106 //商家删除订单
};
