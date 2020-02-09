//
//  HeBi_Charge_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Charge_Model : NSObject
@property (nonatomic, copy) NSString *qrc;  // 二维码
@property (nonatomic, copy) NSString *url;  // 链接
@property (nonatomic, copy) NSString *cz_fee_min;  // 最小充币数量

@property (nonatomic, strong) NSDictionary *mining_trbgcs;  // 小额活动
@property (nonatomic, strong) NSDictionary *mining_rcmax;  // 大额活动

@end

NS_ASSUME_NONNULL_END
