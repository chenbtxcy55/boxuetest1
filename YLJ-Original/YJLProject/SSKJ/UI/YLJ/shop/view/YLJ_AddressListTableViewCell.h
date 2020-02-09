//
//  YLJ_AddressListTableViewCell.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLJ_AddressListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;

@property (nonatomic, copy) void(^defultBlock)(void);

@property (nonatomic, copy) void(^selectBlock)(void);

@property (nonatomic, copy) void(^edtingBlock)(void);
@property (nonatomic,strong) AddressMessageModel *model;

@end

NS_ASSUME_NONNULL_END
