//
//  Super_Myaddress_ViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "AddressMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Super_Myaddress_ViewController : SSKJ_BaseViewController
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) void(^callBackBlcok)(AddressMessageModel *model);

@end

NS_ASSUME_NONNULL_END
