//
//  HeBi_FB_OrderDetail_PayView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBi_FB_OrderDetail_Model.h"
#import "JB_FBC_OrderDetail_PayIndexView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_FB_OrderDetail_PayView : UIView
@property (nonatomic, copy) void (^showQRCodeBlock)(NSString *imageURL);
@property (nonatomic, strong) HeBi_PayMethod_Index_Model *selectPayModel;
-(void)setViewWithModel:(HeBi_FB_OrderDetail_Model *)model;

@end

NS_ASSUME_NONNULL_END
