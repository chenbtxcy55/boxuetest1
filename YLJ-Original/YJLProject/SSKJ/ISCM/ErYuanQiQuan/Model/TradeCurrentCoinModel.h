//
//  TradeCurrentCoinModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 {
 "pid": "2",
 "pname": "BTC",
 "mark": "BTC/USDT",
 "price": "8520.00000000",
 "min_price": "0.00010",//最小变动价
 "aim_point": [//目标点位
 "30",
 "60",
 "120"
 ],
 "odds": [//赔率
 "0.75",
 "0.75",
 "0.75"
 ]
 },*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TradeCurrentCoinModel : NSObject

@property (nonatomic, strong) NSString *pid;

@property (nonatomic, strong) NSString *pname;

@property (nonatomic, strong) NSString *mark;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *min_price;

@property (nonatomic, strong) NSArray *aim_point;

@property (nonatomic, strong) NSArray *odds;


@end

NS_ASSUME_NONNULL_END
