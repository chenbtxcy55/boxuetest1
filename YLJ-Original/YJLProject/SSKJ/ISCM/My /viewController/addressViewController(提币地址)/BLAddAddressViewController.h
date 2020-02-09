//
//  BLAddAddressViewController.h
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SSKJ_BaseViewController.h"
@interface BLAddAddressViewController : SSKJ_BaseViewController

@property (nonatomic, copy) void (^getAddressBlock)(NSString *addressStr);

@property (nonatomic,assign)NSInteger fromVC;

@end
