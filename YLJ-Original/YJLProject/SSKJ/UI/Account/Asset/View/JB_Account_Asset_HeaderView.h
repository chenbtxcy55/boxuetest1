//
//  JB_Account_Asset_HeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JB_Account_Asset_CoinModel.h"
typedef NS_ENUM(NSUInteger, AssetType) {
    AssetTypeDeal,  // 交易账户
    AssetTypeLicai  // 理财账户
};

NS_ASSUME_NONNULL_BEGIN

@interface JB_Account_Asset_HeaderView : UIView

@property (nonatomic, copy) void (^exchangeBlock)(void);    // 划转
@property (nonatomic, copy) void (^chargeBlock)(void);    // 充币
@property (nonatomic, copy) void (^extractBlock)(void);    // 提币


- (instancetype)initWithFrame:(CGRect)frame assetType:(AssetType)assetType;

-(void)setViewWithModel:(JB_Account_Asset_CoinModel *)assetModel;

@end

NS_ASSUME_NONNULL_END
