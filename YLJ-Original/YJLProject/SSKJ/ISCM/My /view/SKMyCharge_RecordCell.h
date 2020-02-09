//
//  SKMyCharge_RecordCell.h
//  SSKJ
//
//  Created by 孙 on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKMyCharge_RecordCell : UITableViewCell
@property (nonatomic, strong) UIView *lineView;


@property (nonatomic, strong) UILabel *getMoneyAddress;

@property (nonatomic, strong) UILabel *getMoneyAddressContent;

@property (nonatomic, strong) UILabel *getMoneyAmount;

@property (nonatomic, strong) UILabel *getMoneyAmountContent;
@end

NS_ASSUME_NONNULL_END
