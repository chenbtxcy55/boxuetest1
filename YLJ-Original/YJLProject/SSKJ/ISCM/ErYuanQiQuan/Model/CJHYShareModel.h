//
//  CJHYShareModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/* {
 "id": "2",
 "pname": "ETH/USDT",//目标合约
 "type": "1",
 "ptype": "USDT",//盈利币种
 "income": "7.5000",//盈利金额
 "buyprice": "270.00000000",//开仓价
 "sellprice": "289.00000000",//平仓价
 "state": "2",
 "pc_type": "1",
 "url": "http:47.75.88.37/wap/register.html?tjuser=AKG52034171",
 "qrc": "http:47.75.88.37/Poster/52034171.png",//注册二维码
 "tgno": "AKG52034171"
 }*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJHYShareModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *pname;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *ptype;
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *buyprice;
@property (nonatomic, strong) NSString *sellprice;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *pc_type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *qrc;
@property (nonatomic, strong) NSString *tgno;
@property (nonatomic, strong) NSString *aim_point;

@end

NS_ASSUME_NONNULL_END
