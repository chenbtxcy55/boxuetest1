//
//  JB_Account_Licai_CoinModel.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JB_Account_LicaiCycle_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_Licai_CoinModel : NSObject

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *pname;
@property (nonatomic, copy) NSString *price;    //相对AB的汇率
@property (nonatomic, copy) NSString *tenday_rate;//10天的利息（%）
@property (nonatomic, copy) NSString *tweentyday_rate;//20天的利息（%）
@property (nonatomic, copy) NSString *thirtyday_rate;//30天的利息（%）
@property (nonatomic, copy) NSString *commision_rate;//平台对收益的分成（%）
@property (nonatomic, copy) NSString *fine_rate;//违约金率（%）

@property (nonatomic, strong) NSArray<JB_Account_LicaiCycle_Model *> *day_rate;    // 理财周期


@end


NS_ASSUME_NONNULL_END
