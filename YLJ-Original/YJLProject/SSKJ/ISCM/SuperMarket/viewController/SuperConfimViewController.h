//
//  SuperConfimViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "AddressMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SuperConfimViewController : SSKJ_BaseViewController

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *store_id;
@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, strong) AddressMessageModel *addressModel;
@property (nonatomic, assign) BOOL isShop;

@end

NS_ASSUME_NONNULL_END
