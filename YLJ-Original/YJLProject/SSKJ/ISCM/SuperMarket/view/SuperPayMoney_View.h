//
//  SuperPayMoney_View.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuperPayMoney_View : UIView
@property (nonatomic, copy) void(^commitBlock)(void);
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UITextField *conTextFild;
@end

NS_ASSUME_NONNULL_END
