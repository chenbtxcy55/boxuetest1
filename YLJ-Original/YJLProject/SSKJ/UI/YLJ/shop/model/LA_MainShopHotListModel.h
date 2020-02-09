//
//  LA_MainShopHotListModel.h
//  SSKJ
//
//  Created by mac on 2019/7/30.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LA_MainShopHotListModel : NSObject
@property (nonatomic, copy) NSString *goods_id;//商品id
@property (nonatomic, copy) NSString *goods_name;//商品名称
@property (nonatomic, copy) NSString *can_sell_price;//所售积分
@property (nonatomic, copy) NSString *rmb_price;//商品人民币价格
@property (nonatomic, copy) NSString *sale_num;//售卖数量
@property (nonatomic, copy) NSString *skus;//库存量
@property (nonatomic, copy) NSString *thumbnail_pic;//商品图片
@property (nonatomic, copy) NSString *details;//详情
@property (nonatomic,copy) NSArray *detail_pic_urls;


//"goods_id": "3",
//"goods_name": "商品1",
//"can_sell_price": "0.00",
//"rmb_price": "15.00",
//"sale_num": "0",
//"store_id": "0",
//"thumbnail_pic": "/Uploads/app/banner/2019/11-18/5dd1f85d785c850864.jpg",
//"skus": "100"
@end

NS_ASSUME_NONNULL_END
