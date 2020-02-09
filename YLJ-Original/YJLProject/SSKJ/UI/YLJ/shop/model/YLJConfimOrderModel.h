//
//  YLJConfimOrderModel.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLJShopAddressInfoModel.h"
#import "LA_MainShopHotListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLJConfimOrderModel : NSObject
@property (nonatomic,strong) YLJShopAddressInfoModel *address_info;
@property (nonatomic,strong) LA_MainShopHotListModel *data;
@end



NS_ASSUME_NONNULL_END
