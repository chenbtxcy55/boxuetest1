//
//  BLMangeAddressViewController.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/3/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_BaseViewController.h"

typedef void(^AddAddressBlock)(NSString *name,NSString *address);
typedef void(^RefreshListBlock)();


@interface BLMangeAddressViewController : SSKJ_BaseViewController

/** 添加地址的回调 */
@property (nonatomic, copy) AddAddressBlock addAddressBlock;

// 刷新列表
@property (nonatomic, copy) RefreshListBlock refreshListBlock;
//区分以太坊 和比特币
@property (nonatomic, strong) NSString *currentType;
@end
