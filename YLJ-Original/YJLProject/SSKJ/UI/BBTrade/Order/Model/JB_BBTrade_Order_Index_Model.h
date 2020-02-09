//
//  JB_BBTrade_Order_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_Order_Index_Model : NSObject

@property (nonatomic, copy) NSString *orders_id;    // 币种名称
@property (nonatomic, copy) NSString *pname;    // 币种名称
@property (nonatomic, copy) NSString *wtprice;    // 委托价格
@property (nonatomic, copy) NSString *cjprice;    // 成交价格
@property (nonatomic, copy) NSString *wtnum;    // 委托数量
@property (nonatomic, copy) NSString *cjnum;    // 成交数量
@property (nonatomic, copy) NSString *totalprice;    // 成交总金额
@property (nonatomic, copy) NSString *fee;    // 交易手续费
@property (nonatomic, copy) NSString *type;    // 1买入 2卖出
@property (nonatomic, copy) NSString *add_time;    // 委托时间
@property (nonatomic, copy) NSString *trade_time;    // 成交时间
@property (nonatomic, copy) NSString *status;    // （0 委托 1交易中 2成交 -1已撤销
@property (nonatomic, copy) NSString *otype;    // 1限价 2市价

@end


NS_ASSUME_NONNULL_END
