//
//  JB_BBTrade_SliderMarket_ViewController.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "JB_Market_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_SliderMarket_ViewController : SSKJ_BaseViewController
@property (nonatomic, copy) void (^selectCoinBlock)(JB_Market_Index_Model *coinModel);
@property (nonatomic, assign) CGFloat sliderWidth;
@end

NS_ASSUME_NONNULL_END
