//
//  YLJOrderInfoDetailModel.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLJOrderInfoDetailModel : NSObject
@property (nonatomic,copy) NSString *can_sell_price;
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *note;
@property (nonatomic,copy) NSString *num;
@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,copy) NSString *order_sn;
@property (nonatomic,copy) NSString *payment_method;
@property (nonatomic,copy) NSString *pic_path;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *shipping_comp_name;
@property (nonatomic,copy) NSString *shipping_sn;
//state -1 取消 0未付款 1已付款未发货 2已发货
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *create_time;



@end

NS_ASSUME_NONNULL_END
