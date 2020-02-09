//
//  ZSJ_BindPhone_ViewController.h
//  SSKJ
//
//  Created by zhao on 2019/10/7.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZSJ_BindPhone_ViewController : SSKJ_BaseViewController

@property (nonatomic, copy) void (^successBlock)(NSString *account);
@end

NS_ASSUME_NONNULL_END
