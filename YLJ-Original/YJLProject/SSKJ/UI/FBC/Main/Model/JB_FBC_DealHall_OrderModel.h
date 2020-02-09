//
//  JB_FBC_DealHall_OrderModel.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_FBC_DealHall_OrderModel : NSObject
@property (nonatomic, copy) NSString *trans_num;    // 交易数量
@property (nonatomic, copy) NSString *deals_num;    // 成交数量
@property (nonatomic, copy) NSString *price;    // 单价
@property (nonatomic, copy) NSString *quota;    // 限额
@property (nonatomic, copy) NSString *cd_num;    // 成单数
@property (nonatomic, copy) NSString *rate;    // 完成率
@property (nonatomic, copy) NSString *order_no;    // 订单编号
@property (nonatomic, copy) NSString *min_price;    // 最低限价
@property (nonatomic, copy) NSString *max_price;    // 最高限价
@property (nonatomic, copy) NSString *account;    // 发布者account
@property (nonatomic, copy) NSString *realname;    // 真实姓名
@property (nonatomic, copy) NSString *pay_wx;    // 是否支持微信
@property (nonatomic, copy) NSString *pay_alipay;    // 是否支持支付宝
@property (nonatomic, copy) NSString *pay_backcard;    // 是否支持银行卡
@property (nonatomic, copy) NSString *amount;    // 剩余量


@end

NS_ASSUME_NONNULL_END
