//
//  ICC_PreorderModel.h
//  ICC
//
//  Created by 刘小雨 on 2018/8/10.
//  Copyright © 2018年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICC_PreOrder_GoodsInfo_Model.h"
@interface ICC_PreorderModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *gid;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *total_money;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *freight;
@property (nonatomic, strong) ICC_PreOrder_GoodsInfo_Model *goods_history;
@property (nonatomic, copy) NSString *sx_money;
@property (nonatomic, copy) NSString *goods_money;


@end
