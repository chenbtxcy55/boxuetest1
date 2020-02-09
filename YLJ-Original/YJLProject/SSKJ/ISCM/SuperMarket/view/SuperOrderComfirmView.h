//
//  SuperOrderComfirmView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressMessageModel.h"
//#import "AB_TitleTextInputView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SuperOrderComfirmView : UIView

@property (nonatomic, copy) void(^commitBlock)(void);
@property (nonatomic, copy) void(^cancelBlock)(void);
@property (nonatomic, copy) void(^payBlock)(void);
@property (nonatomic, copy) void(^deleteBlock)(void);
@property (nonatomic, copy) void(^shopCancelBlock)(void);
@property (nonatomic, copy) void(^shopSureBlock)(void);
@property (nonatomic, copy) void(^userSureBlock)(void);

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSDictionary *dataDic2;

@property (nonatomic, copy) void(^gotoAddressBlock)(void);

@property (nonatomic, assign) BOOL hasAddress;
@property (nonatomic, strong) UITextField *momoView;

@property (nonatomic, strong) AddressMessageModel *model;

@property (nonatomic, strong) NSDictionary *adressDict;
@property (nonatomic, assign) BOOL isShop;

@end

NS_ASSUME_NONNULL_END
