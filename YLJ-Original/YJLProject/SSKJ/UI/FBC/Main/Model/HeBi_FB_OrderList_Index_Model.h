//
//  HeBi_FB_OrderList_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_FB_OrderList_Index_Model : NSObject
@property (nonatomic, copy) NSString *chu_account;
@property (nonatomic, copy) NSString *gou_account;
@property (nonatomic, copy) NSString *order_num;        //订单号
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *price;            // 价格
@property (nonatomic, copy) NSString *total_num;        //  数量
@property (nonatomic, copy) NSString *total_price;      //  成交额
@property (nonatomic, copy) NSString *sxfee;            //  手续费
@property (nonatomic, copy) NSString *status;           //  状态  1待付款 2已付款 3已确认完成 4 申诉中 5已取消
@property (nonatomic, copy) NSString *jyd;
@property (nonatomic, copy) NSString *jy_type;
@property (nonatomic, copy) NSString *name;             // 姓名
@property (nonatomic, copy) NSString *min_price;        // 最小限额
@property (nonatomic, copy) NSString *max_price;         // 最大限额
@property (nonatomic, copy) NSString *ss_sta;         // 申诉状态




@end

NS_ASSUME_NONNULL_END
