//
//  FBCRecodTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBCRecodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contenView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountlabel;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLable;

@property (weak, nonatomic) IBOutlet UILabel *goBuyType;

@end

NS_ASSUME_NONNULL_END
