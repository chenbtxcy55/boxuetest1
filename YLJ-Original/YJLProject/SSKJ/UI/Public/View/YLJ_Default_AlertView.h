//
//  YLJ_Default_AlertView.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLJ_Default_AlertView : UIView
@property (nonatomic, strong) UITextField *messageTF;

+(void)showWithTitle:(NSString *)title message:(NSString *)message cancleTitle:(NSString *)cancleTitle confirmTitle:(NSString *)confirmTitle confirmBlock:(nonnull void (^)(NSString *str))confirmblock;
@end

NS_ASSUME_NONNULL_END
