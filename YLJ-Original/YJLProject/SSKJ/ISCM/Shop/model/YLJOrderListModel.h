//
//  YLJOrderListModel.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLJOrderListModel : NSObject

@property (nonatomic,copy) NSString *can_sell_price;//购物券
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *note;
@property (nonatomic,copy) NSString *order_id;
@property (nonatomic,copy) NSString *order_sn;
@property (nonatomic,copy) NSString *payment_method;
@property (nonatomic,copy) NSString *pic_path;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *store_id;
@property (nonatomic,copy) NSString *total_price;//人民币
@property (nonatomic,copy) NSString *wait_sell_price;
@property (nonatomic,copy) NSString *num;




@end

NS_ASSUME_NONNULL_END
