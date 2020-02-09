//
//  Shop_OrderDetail_HeaderView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressMessageModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface Shop_OrderDetail_HeaderView : UIView

@property (nonatomic, copy) void(^commitBlock)(void);

@property (nonatomic, strong) NSString *order_id;

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, copy) void(^gotoAddressBlock)(void);
//商家 个人
@property (nonatomic, assign) BOOL isShop;

@property (nonatomic, strong) AddressMessageModel *model;

@property (nonatomic, copy) void(^bottomClickedFist)(ICC_Mall_OrderDetail_HandleItemType clickedType);

@property (nonatomic, copy) void(^bottomClickedSecend)(ICC_Mall_OrderDetail_HandleItemType clickedType);
-(void)loadOrderDetailDatas;

@property (nonatomic, assign) BOOL hasAddress;


@property (nonatomic, assign) BOOL canCoopy;

@end

NS_ASSUME_NONNULL_END
