//
//  MoneyPswIndexViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoneyPswIndexViewController : SSKJ_BaseViewController

@property (nonatomic, strong) NSString *idString;


@property (nonatomic, copy) void(^sucessBlock)(void);

@end

NS_ASSUME_NONNULL_END
