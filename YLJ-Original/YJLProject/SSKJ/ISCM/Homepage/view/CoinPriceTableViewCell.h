//
//  CoinPriceTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoneyListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinPriceTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *coinImg;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *usLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) MoneyListModel *model;

@end

NS_ASSUME_NONNULL_END
