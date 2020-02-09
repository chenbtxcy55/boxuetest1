//
//  JB_Account_Asset_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_Asset_Index_Model : NSObject



// 理财账户使用
@property (nonatomic, copy) NSString *mark; // 币种名称

// 交易账户使用
@property (nonatomic, copy) NSString *pname;

// 公用
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *usable;// 可用
@property (nonatomic, copy) NSString *frost;   // 冻结

@property (nonatomic, copy) NSString *uptime;//时间
@property (nonatomic, copy) NSString *tb_fee_rate;//提币手续
@property (nonatomic, copy) NSString *tb_min;//提币最小
@property (nonatomic, copy) NSString *tb_max;//提币最大
@property (nonatomic, copy) NSString *exchange;//改变
@property (nonatomic, copy) NSString *is_act;//1可充提币 0不可充提币

@end


NS_ASSUME_NONNULL_END
