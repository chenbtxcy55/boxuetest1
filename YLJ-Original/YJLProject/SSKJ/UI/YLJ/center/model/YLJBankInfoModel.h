//
//  YLJBankInfoModel.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLJBankInfoModel : NSObject
//用户名
@property (nonatomic,copy) NSString *bank_name;
//用于显示在兑换界面的尾号
@property (nonatomic,copy) NSString *bank_number;

//银行卡用户名
@property (nonatomic,copy) NSString *bank_user_name;
//银行卡号码
@property (nonatomic,copy) NSString *bank_user_number;
//开户行名称
@property (nonatomic,copy) NSString *bank_open;


@property (nonatomic,copy) NSString *money_min;
//其实是最大限制
@property (nonatomic,copy) NSString *num_min;
@property (nonatomic,copy) NSString *tb_fee;
@end

NS_ASSUME_NONNULL_END
