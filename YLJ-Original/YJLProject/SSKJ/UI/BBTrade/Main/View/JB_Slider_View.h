//
//  JB_Slider_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/27.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBi_BuySell_AlertView.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_Slider_View : UIView
@property (nonatomic, assign) BuySellType buySellType;
@property (nonatomic, copy) void (^changeProgressBlock)(double progress);

@property (nonatomic, strong) UILabel *startLabel;
@property (nonatomic, strong) UILabel *endLabel;
@property (nonatomic, assign) double progress;
@end

NS_ASSUME_NONNULL_END
