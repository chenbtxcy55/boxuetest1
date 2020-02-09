//
//  HeBi_FB_PublishRecord_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_FB_PublishRecord_Index_Model : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *order_no; // 订单号
@property (nonatomic, copy) NSString *trans_num;// 发布数量
@property (nonatomic, copy) NSString *deals_num;// 成交数量
@property (nonatomic, copy) NSString *totalprice;// 总价
@property (nonatomic, copy) NSString *price;        // 单价
@property (nonatomic, copy) NSString *status;   //1 进行中 2完成 3撤单
@property (nonatomic, copy) NSString *add_time; // 发布时间
@property (nonatomic, copy) NSString *min_price; // 最低限价
@property (nonatomic, copy) NSString *max_price; // 最高限价
@property (nonatomic, copy) NSString *pay_backcard; // 1 银行卡
@property (nonatomic, copy) NSString *pay_alipay; // 1 支付宝
@property (nonatomic, copy) NSString *pay_wx; // 1 支付宝
@property (nonatomic, copy) NSString *deals_sxfee; // 手续费

/*
"id": "6",
"order_no": "15306159738586809165",
"trans_num": "11.0000",
"deals_num": "0.0000",
"totalprice": "220.00",
"price": "20.00",
"status": "1",            1 进行中 2完成 3撤单
"add_time": "1530615973"
"min_price": "6.77",
"max_price": "6.77"
"pay_backcard": 1 银行卡
"pay_alipay": 1 支付宝
"pay_wx": 1 微信
 */

@end

NS_ASSUME_NONNULL_END
