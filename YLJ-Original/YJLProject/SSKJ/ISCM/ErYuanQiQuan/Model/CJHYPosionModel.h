//
//  CJHYPosionModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*{
 "mark": "BTC/USDT",
 "actprice": "8520.00000000",//最新价格
 "id": "5",
 "userid": "171",
 "account": "52034171",
 "type": "1",
 "ptype": "USDT",//资产币种
 "unit_num": "0.10",//单位交易量
 "num": "100.00",//手数
 "total_num": "10.00",//总交易量
 "aim_point": "30.00",//目标点位
 "odds": "0.75",//赔率
 "pname": "BTC",//交易币种
 "income": "0.0000",//收益
 "addtime": "1561015222",//下单时间
 "selltime": "0",//平仓时间
 "state": "1",//1持仓中  2已平仓
 "pc_type": "0",//1赢  2亏
 "buyprice": "8520.00000000",//买入价
 "sellprice": "0.00000000",//平仓价
 "stoploss": "8519.99100000",//止损价
 "stopwin": "8520.00900000"//止盈价
 },*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJHYPosionModel : NSObject
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *actprice;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *ptype;
@property (nonatomic, strong) NSString *unit_num;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *total_num;
@property (nonatomic, strong) NSString *aim_point;
@property (nonatomic, strong) NSString *odds;
@property (nonatomic, strong) NSString *pname;
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *selltime;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *pc_type;
@property (nonatomic, strong) NSString *buyprice;
@property (nonatomic, strong) NSString *sellprice;
@property (nonatomic, strong) NSString *stoploss;
@property (nonatomic, strong) NSString *stopwin;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *times;

@property (nonatomic, strong) NSString *profit_ratio;
@property (nonatomic, strong) NSString *order_type;
@property (nonatomic,strong)  NSString *totalprice;
@property (nonatomic, strong) NSString *buynum;
@property (nonatomic, strong) NSString *free_rate;

//"hold_id": "31",
//"hold_no": "6915680980963161",
//"userid": "3696",
//"account": "246421214",
//"username": "",
//"pid": "1",
//"pname": "BTC\/USDT",
//"buyprice": "10258.5800",
//"buynum": "200",
//"totalprice": "202.0000",
//"leverage": "2696",
//"order_type": "2",
//"addtime": "1568098096",
//"sxfee": "2.0000",
//"deposit": "200.0000",
//"level": "13",
//"tpath": "0,1,7,10,11,14,22,23,52,70,152,286,414,3695",
//"free_rate": "0",
//"totalnum": "0",
//"type": "1",
//"profit_ratio": "0.2000",
//"order_cycle": "3",
//"end_time": "1568098260",
//"times": 162
@end

NS_ASSUME_NONNULL_END
