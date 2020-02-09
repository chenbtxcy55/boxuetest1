//
//  JB_BBTrade_SocketDealOrder_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_SocketDealOrder_Model : UIView
@property (nonatomic, copy) NSString *income;       // 获利数量
@property (nonatomic, copy) NSString *type;           // 买卖
@property (nonatomic, copy) NSString *selltime;           // 平仓时间
@property (nonatomic, copy) NSString *sellprice;        // 平仓价

@property (nonatomic, strong) NSString *ptype;


@property (nonatomic, copy) NSString *amount;       // 成交量
@property (nonatomic, copy) NSString *dc;           // 买卖
@property (nonatomic, copy) NSString *dt;           // 时间
@property (nonatomic, copy) NSString *price;        // 价格
//"tran_id": "1469",
//"tran_no": "186",
//"buynum": "200", //交易金额
//"order_type": "2", //1：买涨 2买跌
//"sellprice": "0.0000",//平仓价
//"profit": "0.2000",
//"deposit": "240.0000",//盈利
//"cycle_time": "3",
//"selltime": "1567560060",//平仓时间
//"addtime": "1567560060",
//"pid": "2"
@property (nonatomic, copy) NSString *tran_id;
@property (nonatomic, copy) NSString *tran_no;
@property (nonatomic, copy) NSString *buynum;
@property (nonatomic, copy) NSString *order_type;

@property (nonatomic, strong) NSString *profit;


@property (nonatomic, copy) NSString *deposit;       
//@property (nonatomic, copy) NSString *selltime;           // 买卖
@property (nonatomic, copy) NSString *addtime;           // 时间
@property (nonatomic, copy) NSString *pid;
@end

NS_ASSUME_NONNULL_END
