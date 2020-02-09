//
//  HeBi_BuySell_AlertView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/12.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_FBC_DealHall_OrderModel.h"

typedef NS_ENUM(NSUInteger, BuySellType) {
    BuySellTypeBuy = 0,
    BuySellTypeSell = 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_BuySell_AlertView : UIView

@property (nonatomic, copy) void (^confirmBlock)(NSDictionary *dic);

-(void)showWithModel:(JB_FBC_DealHall_OrderModel *)model buySellType:(BuySellType)type;

-(void)hide;


-(void)clearView;
@end

NS_ASSUME_NONNULL_END
