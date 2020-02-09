//
//  HeBi_PayMethod_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_PayMethod_Index_Model : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;   // 账户
@property (nonatomic, copy) NSString *type;     // 支付类型  alipay，backcard
@property (nonatomic, copy) NSString *status;   // 开关状态
@property (nonatomic, copy) NSString *tip;
@property (nonatomic, copy) NSString *bank; // 开户行
@property (nonatomic, copy) NSString *branch; // 开户只行
@property (nonatomic, copy) NSString *img; // 二维码图片地址
@property (nonatomic, copy) NSString *realName;

/*
"id" : "2",
"name" : "李海兵",
"number" : "wx13523925725",
"type" : "wx",
"status" : "0",
"tip" : "微信"
 */
@end

NS_ASSUME_NONNULL_END
