//
//  MoneyModel.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//"ttl_money": 4801.05112, 总USDT
//"ttl_cnymoney": 32171.84355512, 人民币
@interface MoneyModel : NSObject

@property (nonatomic, strong) NSString *ttl_money;

@property (nonatomic, strong) NSString *ttl_cnymoney;

@end

NS_ASSUME_NONNULL_END
