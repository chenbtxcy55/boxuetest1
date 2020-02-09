//
//  BBTrade_PriceView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, PriceType) {
    PriceTypeMarket = 1,    // 市价
    PriceTypeLimite = 2,    // 限价
};
NS_ASSUME_NONNULL_BEGIN

@interface BBTrade_PriceView : UIView
@property (nonatomic, copy) void (^priceChangeBlock)(NSString *price);
@property (nonatomic, assign) PriceType priceType;
@property (nonatomic, assign) NSInteger dotNumber;  // 小数位
@property (nonatomic, copy) NSString *price;
@end

NS_ASSUME_NONNULL_END
