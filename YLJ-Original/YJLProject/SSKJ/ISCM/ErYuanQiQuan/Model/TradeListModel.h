//
//  TradeListModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
/*周期合约
 {
 "pid": "1",
 "pname": "USDT",
 "name": "泰达币",
 "min_num": "20",//最小投资额
 "max_num": "100",//最大投资额
 "yue": 159106.2218//当前余额
 },*/

NS_ASSUME_NONNULL_BEGIN

@interface TradeListModel : NSObject

@property (nonatomic, strong) NSString *pid;

@property (nonatomic, strong) NSString *pname;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray *aim_point;
//余额
@property (nonatomic, strong) NSString *yue;
//最小投资额（周期合约）
@property (nonatomic, strong) NSString *min_num;
//最大投资额（周期合约）
@property (nonatomic, strong) NSString *max_num;

@end

NS_ASSUME_NONNULL_END
