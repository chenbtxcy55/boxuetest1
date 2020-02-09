//
//  ETF_WalletHeaderView.h
//  SSKJ
//
//  Created by James on 2019/5/7.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCustomButton.h"
#import "JB_PledgeBorrowModel.h"
#import "JB_Account_Asset_CoinModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_WalletHeaderView : UIView
@property (nonatomic, strong) UIImageView *bgIM;
@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) HomeCustomButton *rechargeButton;
@property (nonatomic, strong) HomeCustomButton *carryButton;
@property (nonatomic, strong) HomeCustomButton *turnButton;

-(void)setViewWithModel:(JB_Account_Asset_CoinModel *)model;
@end

NS_ASSUME_NONNULL_END
