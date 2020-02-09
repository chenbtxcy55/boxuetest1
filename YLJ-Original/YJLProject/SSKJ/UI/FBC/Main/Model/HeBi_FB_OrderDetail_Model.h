//
//  HeBi_FB_OrderDetail_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeBi_PayMethod_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface HeBi_FB_OrderDetail_Model : NSObject
@property (nonatomic, copy) NSString *oop_account;      //  对方编号
@property (nonatomic, copy) NSString *oop_name;      //  对方姓名
@property (nonatomic, copy) NSString *oop_mobile;      //  对方手机号
@property (nonatomic, copy) NSString *oop_mail;      //  对方邮箱地址

@property (nonatomic, copy) NSString *type;      //  1出售者 2购买者
@property (nonatomic, copy) NSString *order_num;      //  订单编号
@property (nonatomic, copy) NSString *total_num;      //  总数量
@property (nonatomic, copy) NSString *price;      //  单价
@property (nonatomic, copy) NSString *total_price;      //  总价格
@property (nonatomic, copy) NSString *refer;      //  付款参考号
@property (nonatomic, copy) NSString *command;      //  申诉口令
@property (nonatomic, copy) NSString *add_time;      //  下单时间
@property (nonatomic, copy) NSString *status;      //  1未确认待付款 2已付款 3已确认完成 4 申诉中 5取消
@property (nonatomic, copy) NSString *down_time;      //  自动取消剩余时间
@property (nonatomic, copy) NSString *qr_time;      //  自动确认剩余时间
@property (nonatomic, copy) NSString *ss_reason;      //  申诉原因
@property (nonatomic, copy) NSString *ss_sta;      //  申诉状态 1进行中 2成功 3拒绝

@property (nonatomic, strong) NSString *notes;

@property (nonatomic, strong) NSArray<HeBi_PayMethod_Index_Model *> *pay_list;      //  收款方式
@property (nonatomic, strong) HeBi_PayMethod_Index_Model *pay_type;      //  选择的收款方式

@end

/*
"oop_account": "384115",        对方编号
"oop_name": "李*白",        对方姓名
"oop_mobile"：18538083521        对方手机号
"type": 2,        1出售者 2购买者
"ss_reason": null，
"order_num": "8653487381566",        订单编号
"total_num": "8.3333",        总数量
"price": "1.20",        单价
"total_price": "10.00",        总价格
"refer": "9306",        付款参考号
"command": null,    申诉口令
"add_time": "1530686534",        时间
"status": "1",     1未确认待付款 2已付款 3已确认完成 4 申诉中 5取消
"down_time": 0,    自动取消剩余时间
"qr_time": 0,        自动确认剩余时间
"notes": '',        卖家备注
 */

NS_ASSUME_NONNULL_END
