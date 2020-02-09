//
//  JB_PledgeRecordModel.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_PledgeRecordModel : NSObject
@property (nonatomic, copy) NSString *tran_id;//记录id
@property (nonatomic, copy) NSString *type;//1押币 2押钱
@property (nonatomic, copy) NSString *out_pname;//抵押币
@property (nonatomic, copy) NSString *in_pname;//借入币
@property (nonatomic, copy) NSString *out_num;//抵押数量
@property (nonatomic, copy) NSString *in_num;//借入数量
@property (nonatomic, copy) NSString *day_rate;//日息
@property (nonatomic, copy) NSString *rate;//周期利息
@property (nonatomic, copy) NSString *addtime;//抵押时间
@property (nonatomic, copy) NSString *endtime;//到期时间
@property (nonatomic, copy) NSString *selltime;//赎回时间
@property (nonatomic, copy) NSString *status;//1计息中 2已赎回
@property (nonatomic, copy) NSString *days;//周期
@property (nonatomic, copy) NSString *fee;//已产生利息
@property (nonatomic, copy) NSString *dayth;///第几天
@property (nonatomic, copy) NSString *risk;///1高风险  0无风险
@property (nonatomic, copy) NSString *risk_rate;//风险率（%）

@end

NS_ASSUME_NONNULL_END
