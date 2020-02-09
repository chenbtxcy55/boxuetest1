//
//  My_PromoteDetail_Model.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/11/29.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "My_Promote_Index_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface My_PromoteDetail_Model : NSObject

@property (nonatomic, copy) NSString *ttl;  // 累计开户

@property (nonatomic, copy) NSString *force;  // 推广获得的原力

@property (nonatomic, copy) NSString *today;//

@property (nonatomic, copy) NSString *count;// 总客户

@property (nonatomic, copy) NSString *total_sum;// 累计收益

@property (nonatomic, copy) NSString *today_sum;// 今日收益



@property (nonatomic, strong) NSArray<My_Promote_Index_Model *> *list;// 明细列表
@end

NS_ASSUME_NONNULL_END
