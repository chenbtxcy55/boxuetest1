//
//  ActivateViewModel.h
//  SSKJ
//
//  Created by zhao on 2019/10/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivateViewModel : NSObject
@property(nonatomic,copy)NSString *ID;//套餐id
@property(nonatomic,copy)NSString *num;////套餐总usdt
@property(nonatomic,copy)NSString *title;//套餐名称
@property(nonatomic,copy)NSString *usdt_num;//套餐支付 usdt数量
@property(nonatomic,copy)NSString *usdt_yec_num;//套餐支付等值usdt的YEC数量
@property(nonatomic,copy)NSString *a_usdt_num;//赠送价值a 的等值yec数量
@property(nonatomic,copy)NSString *b_usdt_num;//赠送价值a 的等值yec释放数量
@property(nonatomic,copy)NSString *shop_blance;//商城余额
@property(nonatomic,copy)NSString *user_level;//购买不同套餐（1 初级、2中级、3高级、4超级、5特级经纪人），后台指定是社区
@property(nonatomic,copy)NSString *add_time;//添加时间

//详情用
@property(nonatomic,copy)NSString *rname;//套餐名称

@property(nonatomic,copy)NSString *content;//内容

@end

NS_ASSUME_NONNULL_END
