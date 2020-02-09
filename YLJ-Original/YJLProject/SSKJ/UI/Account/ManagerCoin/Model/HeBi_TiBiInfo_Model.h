//
//  HeBi_TiBiInfo_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/18.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_TiBiInfo_Model : NSObject
@property (nonatomic, copy) NSString *tb_fee;   // 手续费
@property (nonatomic, copy) NSString *tb_max;   // 最大提币
@property (nonatomic, copy) NSString *tb_min;   // 最小提币
@property (nonatomic, copy) NSString *balance;   // 余额

@end

NS_ASSUME_NONNULL_END
