//
//  Shop_OrderDetail_ViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
//typedef NS_ENUM(NSInteger, ICC_Mall_OrderDetail_HandleItemType) {
//    kuserCancelOrderEvent = 100,//取消订单
//    kuserGoPayOrderEvent = 101,//去支付
//    kuserSureOrderEvent = 102, //确认订单
//    kuserDeleteOrderEvent = 103,//删除订单
//    kuserContactShopEvent = 104, //联系商家
//    kbusnessSendGoodsOrederEvent = 105, //商家发货
//    kbusnessDeleteOrderEvent = 106 //商家删除订单
//};
@interface Shop_OrderDetail_ViewController : SSKJ_BaseViewController
@property (nonatomic, strong) NSString *order_id;

@property (nonatomic, assign) BOOL isShop;




@end

NS_ASSUME_NONNULL_END
