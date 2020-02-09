//
//  Shop_OrderListViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

typedef NS_ENUM(NSInteger, UserOrderType) {
    kwholeOrderType = 100,//全部订单
    knoPayOrderMoneyType = 101,//待付款
    knoSendOrderMoneyType = 102,//待发货
    knoReceivingOrderType = 103,//待收货
    khadFinishedOrderType  //已完成
};

NS_ASSUME_NONNULL_BEGIN

@interface Shop_OrderListViewController : SSKJ_BaseViewController

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *statusString;

-(void)refreshData;

@end

NS_ASSUME_NONNULL_END
