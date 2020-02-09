//
//  JB_BBTrade_MarketDetail_ViewController.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "SSKJ_Market_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_MarketDetail_ViewController : SSKJ_BaseViewController
@property (nonatomic, assign) BOOL isFromBBTrade;

@property (nonatomic, strong) SSKJ_Market_Index_Model *coinModel;

@property (nonatomic, strong) NSMutableArray *coinArr;


@end

NS_ASSUME_NONNULL_END
