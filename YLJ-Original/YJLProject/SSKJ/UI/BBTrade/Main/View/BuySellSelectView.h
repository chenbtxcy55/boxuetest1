//
//  BuySellSelectView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "HeBi_BuySell_AlertView.h"
NS_ASSUME_NONNULL_BEGIN

//typedef NS_ENUM(NSUInteger, BuySellType) {
//    BuySellTypeBuy,
//    BuySellTypeSell,
//};

@interface BuySellSelectView : UIView
@property (nonatomic, assign) BuySellType buySellType;
@property (nonatomic, copy) void (^buySellBlock)(BuySellType buySellType);

@end

NS_ASSUME_NONNULL_END
