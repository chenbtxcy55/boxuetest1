//
//  JB_FBC_OrderDetail_PayIndexView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/18.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBi_PayMethod_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_FBC_OrderDetail_PayIndexView : UIView

@property (nonatomic, copy) void (^selectBlock)(BOOL selected);
@property (nonatomic, copy) void (^showQRcodeBlock)(HeBi_PayMethod_Index_Model *payModel);
@property (nonatomic, strong) HeBi_PayMethod_Index_Model *payModel;

-(instancetype)initWithFrame:(CGRect)frame canSelect:(BOOL)isCanSelect;

-(void)setSelected:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
