//
//  xiadanViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface xiadanViewController : SSKJ_BaseViewController
@property (nonatomic, copy) void(^commitBlock)(void);
@property (nonatomic, copy) void(^cancelBlock)(void);

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UITextField *conTextFild;
@property (nonatomic, strong) NSDictionary *dict;
@end

NS_ASSUME_NONNULL_END
