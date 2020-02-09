//
//  JB_Account_LicaiView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_Account_Licai_CoinModel.h"
#import "JB_Account_LicaiDetail_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_LicaiView : UIView

@property (nonatomic, copy) void (^confirmBlock)(NSString *amount,NSInteger day,BOOL isAuto,NSString *rate);

-(void)setViewWithCoinModel:(JB_Account_Licai_CoinModel *)coinModel detailModel:(JB_Account_LicaiDetail_Model *)detailModel;

-(void)clearView;

@end

NS_ASSUME_NONNULL_END
