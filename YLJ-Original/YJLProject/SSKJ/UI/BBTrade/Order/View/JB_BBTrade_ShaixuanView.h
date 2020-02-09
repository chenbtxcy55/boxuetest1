//
//  JB_BBTrade_ShaixuanView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_BBTrade_CoinModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_ShaixuanView : UIView
@property (nonatomic, strong) NSArray *coinArray;

@property (nonatomic, copy) void (^confirmBlock)(NSString *coinCode,NSString *buySellType,NSString *status);

-(void)showWithCoinCode:(NSString *)coinCode status:(NSString *)status buySellType:(NSString *)buySellType;
-(void)hide;

@end

NS_ASSUME_NONNULL_END
