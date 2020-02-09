//
//  HeBi_FB_OrderDetail_BottomView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeBi_FB_OrderDetail_Model.h"

typedef NS_ENUM(NSUInteger, ActionType) {
//    ActionTypeNextStep,              // 买家选择支付方式后点击下一步
    ActionTypePay,              // 买家标记付款
    ActionTypeCancle,           // 买家取消订单
    ActionTypeFangbi,           // 卖家确认放币
    ActionTypeAppeal            // 卖家申诉
};

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_FB_OrderDetail_BottomView : UIView

@property (nonatomic, copy) void (^countDownBlock)(void);
@property (nonatomic, copy) void (^actionBlock)(ActionType actionType);
-(void)setViewWithModel:(HeBi_FB_OrderDetail_Model *)model;

@end

NS_ASSUME_NONNULL_END
