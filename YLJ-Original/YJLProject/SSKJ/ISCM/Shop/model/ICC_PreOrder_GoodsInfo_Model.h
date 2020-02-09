//
//  ICC_PreOrder_GoodsInfo_Model.h
//  ICC
//
//  Created by 刘小雨 on 2018/8/10.
//  Copyright © 2018年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICC_PreOrder_GoodsInfo_Model : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *cate_id;
@property (nonatomic, copy) NSString *tag_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumbnail_pic;
//@property (nonatomic, copy) NSString *pic_urls;
@property (nonatomic,copy) NSString *category_id;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *lunbotu_list;
@property (nonatomic, strong) NSArray *jianjie_list;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *cost;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *freight;
@property (nonatomic, copy) NSString *down_status;
@property (nonatomic, copy) NSString *delete_status;
@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *store;
@property (nonatomic, copy) NSString *sell_num;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *buy_num;
@property (nonatomic, copy) NSString *total_money;
@property (nonatomic, copy) NSString *goods_money;
@property (nonatomic, copy) NSString *sx_money;
@property (nonatomic, copy) NSString *rmb_price;


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *on_time;

@property (nonatomic, copy) NSString *off_time;

@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *sale_num;

@property (nonatomic, copy) NSString *wait_sell_price;

@property (nonatomic, copy) NSString *can_sell_price;
@property (nonatomic, copy) NSString *skus;

@property (nonatomic, copy) NSString *details;

@property (nonatomic, copy) NSString *detail_pics;

@property (nonatomic, copy) NSString *sku_pics;

@property (nonatomic, copy) NSArray *pic_urls;
@property (nonatomic, copy) NSArray *detail_pic_urls;



@end
