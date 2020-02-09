//
//  JB_BBTrade_MainHeader_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuySellSelectView.h"
#import "BBTrade_PriceView.h"
#import "JB_Market_Index_Model.h"
#import "JB_BBTrade_BalanceModel.h"
#import "ETF_Contract_Depth_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_MainHeader_View : UIView
@property (nonatomic, strong) JB_Market_Index_Model *coinModel;


@property (nonatomic, copy) void (^confirmBuyBlock)(NSString *number,BuySellType buySellType,PriceType priceType,NSString *price);

@property (nonatomic, copy) void (^loginBlock)(void);

@property (nonatomic, assign) PriceType priceType;

@property (nonatomic, assign) BuySellType buysellType;


-(void)setViewWithBalanceModel:(JB_BBTrade_BalanceModel *)balanceModel;

-(void)setDeepData:(NSDictionary *)deepData;

-(void)setPankouData:(ETF_Contract_Depth_Model *)Model;

-(void)setMarketData:(JB_Market_Index_Model *)Model;

-(void)viewWilAppear;

@end

NS_ASSUME_NONNULL_END
