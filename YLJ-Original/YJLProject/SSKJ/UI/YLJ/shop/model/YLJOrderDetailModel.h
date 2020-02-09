//
//  YLJOrderDetailModel.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLJShopAddressInfoModel.h"
#import "YLJOrderInfoDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLJOrderDetailModel : NSObject

@property (nonatomic,strong) YLJShopAddressInfoModel *user_detail;
@property (nonatomic,strong) YLJOrderInfoDetailModel *order_detail;

@end

NS_ASSUME_NONNULL_END
