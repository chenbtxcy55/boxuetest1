//
//  JB_CoinTradeListViewController.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    JB_CoinTradeListVCType_JiaoYi,//交易
    JB_CoinTradeListVCType_LiCai,//理财
} JB_CoinTradeListVCType;

@interface JB_CoinTradeListViewController : SSKJ_BaseViewController
@property (nonatomic, copy) NSString *coinString;
@property (nonatomic, copy) NSString *coinKeyString;
@property (nonatomic, assign) JB_CoinTradeListVCType vcType;
@end

NS_ASSUME_NONNULL_END
