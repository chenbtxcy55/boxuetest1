//
//  HeBi_AddressManager_ViewController.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

// model
#import "HeBi_WalletAddress_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface HeBi_AddressManager_ViewController : SSKJ_BaseViewController
@property (nonatomic, copy) void (^addressSelectBlock)(HeBi_WalletAddress_Model *addressModel);
@end

NS_ASSUME_NONNULL_END
