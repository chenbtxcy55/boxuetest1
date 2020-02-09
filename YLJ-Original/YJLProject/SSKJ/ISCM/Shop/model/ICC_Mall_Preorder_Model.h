//
//  ICC_Mall_Preorder_Model.h
//  ICC
//
//  Created by 刘小雨 on 2018/8/10.
//  Copyright © 2018年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICC_PreorderModel.h"
#import "ICC_PreOrder_ShopInfo_Model.h"
@interface ICC_Mall_Preorder_Model : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *ordername;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *pay_time;
@property (nonatomic, copy) NSString *fahuo_time;
@property (nonatomic, copy) NSString *shouhuo_time;
@property (nonatomic, copy) NSString *liuyan;
@property (nonatomic, copy) NSString *chongzhiname;
@property (nonatomic, copy) NSString *order_status;
@property (nonatomic, copy) NSString *total_money;
@property (nonatomic, copy) NSString *total_freight;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *sx_money;
@property (nonatomic, copy) NSString *goods_money;
@property (nonatomic, copy) NSString *wuliudan;
@property (nonatomic, copy) NSString *wuliuname;

@property (nonatomic, strong) ICC_PreorderModel *order_ext;
@property (nonatomic, strong) ICC_PreOrder_ShopInfo_Model *shop_info;





@end
