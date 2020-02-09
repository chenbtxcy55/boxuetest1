//
//  MoneyListModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
/* "pid": 0,
 "pname": "USDT",
 "mark": "usdt_usdt",
 "usable": "618.2578",
 "frost": "0.0000",
 "uptime": 1554186876,
 "cny": 4142.9455178  人民币*/
NS_ASSUME_NONNULL_BEGIN

@interface MoneyListModel : NSObject

@property (nonatomic, strong) NSString *pid;

@property (nonatomic, strong) NSString *pname;

@property (nonatomic, strong) NSString *mark;

@property (nonatomic, strong) NSString *usable;

@property (nonatomic, strong) NSString *frost;

@property (nonatomic, strong) NSString *uptime;

@property (nonatomic, strong) NSString *cny;

@end

NS_ASSUME_NONNULL_END
