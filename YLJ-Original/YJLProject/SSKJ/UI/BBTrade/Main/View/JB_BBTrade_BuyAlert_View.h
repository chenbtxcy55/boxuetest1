//
//  JB_BBTrade_BuyAlert_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/21.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBTrade_PriceView.h"
#import "HeBi_BuySell_AlertView.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_BuyAlert_View : UIView
+(void)showWithAmount:(NSString *)amount priceType:(PriceType)priceType buySellType:(BuySellType)buySellType price:(NSString *)price confirmBlock:(void(^)(void))confirmblock;

@end

NS_ASSUME_NONNULL_END
