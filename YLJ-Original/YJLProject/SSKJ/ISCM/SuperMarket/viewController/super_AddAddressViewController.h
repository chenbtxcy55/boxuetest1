//
//  super_AddAddressViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "AddressMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface super_AddAddressViewController : SSKJ_BaseViewController
//1 添加 2 编辑
@property (nonatomic, assign) NSInteger edtingType;

@property (nonatomic, strong) AddressMessageModel *model;

@property (nonatomic, assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END
