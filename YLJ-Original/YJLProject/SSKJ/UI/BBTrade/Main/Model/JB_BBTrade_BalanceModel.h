//
//  JB_BBTrade_BalanceModel.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_BalanceModel : NSObject

@property (nonatomic, copy) NSString *left_code;
@property (nonatomic, copy) NSString *right_code;
@property (nonatomic, copy) NSString *trans_fee;

@end

NS_ASSUME_NONNULL_END
