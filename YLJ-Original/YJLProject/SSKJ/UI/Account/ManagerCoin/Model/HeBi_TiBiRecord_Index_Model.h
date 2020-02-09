//
//  HeBi_TiBiRecord_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/18.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_TiBiRecord_Index_Model : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *cash_id;      //记录id
@property (nonatomic, copy) NSString *userid;       //用户id
@property (nonatomic, copy) NSString *account;      //会员账号
@property (nonatomic, copy) NSString *txnum;        //提现编号
@property (nonatomic, copy) NSString *price;        //充值金额
@property (nonatomic, copy) NSString *state;        //提现状态 1待审核，2已审核，3已拒绝
@property (nonatomic, copy) NSString *qianbao_url;  //钱包地址
@property (nonatomic, copy) NSString *username;     //用户姓名
@property (nonatomic, copy) NSString *addtime;      //充值时间
@property (nonatomic, copy) NSString *check_time;   //审核时间
@property (nonatomic, copy) NSString *memo;         //备注
@property (nonatomic, copy) NSString *txfee;        //提现手续费
@property (nonatomic, copy) NSString *actual;        //实际到账
@property (nonatomic, copy) NSString *pname;

@end

NS_ASSUME_NONNULL_END
