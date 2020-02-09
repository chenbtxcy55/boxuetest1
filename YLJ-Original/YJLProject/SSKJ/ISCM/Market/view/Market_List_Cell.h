//
//  Market_List_Cell.h
//  SSKJ
//
//  Created by zpz on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Market_List_Cell : UITableViewCell

@property(nonatomic, strong)UIImageView *iconImageView;

@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UILabel *subTitleLabel;

@property(nonatomic, strong)UILabel *moneyLabel;

@property(nonatomic, strong)UILabel *subMoneyLabel;

@property(nonatomic, strong)UIButton *marketBtn;
@end

NS_ASSUME_NONNULL_END
