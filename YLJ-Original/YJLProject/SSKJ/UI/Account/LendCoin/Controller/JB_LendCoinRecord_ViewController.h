//
//  JB_LendCoinRecord_ViewController.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
typedef enum : NSUInteger {
    JB_LendCoin_VCType_RendMoney,//借款
    JB_LendCoin_VCType_RendCoin,//借币
} JB_LendCoin_VCType;

NS_ASSUME_NONNULL_BEGIN

@interface JB_LendCoinRecord_ViewController : SSKJ_BaseViewController
- (instancetype)initWithType:(JB_LendCoin_VCType)type;
@end

NS_ASSUME_NONNULL_END
