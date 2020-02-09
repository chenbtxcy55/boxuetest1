//
//  HeBi_FB_OrderDetail_HeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBi_FB_OrderDetail_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_FB_OrderDetail_HeaderView : UIView
-(void)setViewWithModel:(HeBi_FB_OrderDetail_Model *)model;

@property(nonatomic, strong)UILabel *detailLabel;

@end

NS_ASSUME_NONNULL_END
