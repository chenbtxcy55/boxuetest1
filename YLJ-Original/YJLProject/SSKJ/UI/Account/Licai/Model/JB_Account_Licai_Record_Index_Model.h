//
//  JB_Account_Licai_Record_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_Licai_Record_Index_Model : NSObject
@property (nonatomic, copy) NSString *tran_id;//订单id

@property (nonatomic, copy) NSString *pname;//理财币种
@property (nonatomic, copy) NSString *num;////理财数量
@property (nonatomic, copy) NSString *interest_rate;//利率（%）
@property (nonatomic, copy) NSString *addtime;//挂单时间
@property (nonatomic, copy) NSString *endtime;//到期时间
@property (nonatomic, copy) NSString *selltime;//赎回时间
@property (nonatomic, copy) NSString *status;//1理财中 2已赎回
@property (nonatomic, copy) NSString *is_auto;//1自动放贷  0手动
@property (nonatomic, copy) NSString *days;//周期
@property (nonatomic, copy) NSString *interest;//利息
@property (nonatomic, copy) NSString *commision;//平台分成
@property (nonatomic, copy) NSString *fine;//违约金
@property (nonatomic, copy) NSString *dayth;//第几天
@property (nonatomic, copy) NSString *income;//预期收益

@end

NS_ASSUME_NONNULL_END

