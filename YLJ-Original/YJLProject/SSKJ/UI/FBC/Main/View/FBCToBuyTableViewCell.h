//
//  FBCToBuyTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_FBC_DealHall_OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FBCToBuyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountlabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *gotoBuyBtn;

@property (nonatomic, copy) void(^gotoBuyBlock)(void);

@property (nonatomic, strong) NSArray *payWaysArray;

-(void)setCellWithModel:(JB_FBC_DealHall_OrderModel *)model;

@end

NS_ASSUME_NONNULL_END
