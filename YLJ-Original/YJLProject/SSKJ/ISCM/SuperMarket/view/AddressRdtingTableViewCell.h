//
//  AddressRdtingTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddressRdtingTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^defultBlock)(void);

@property (nonatomic, copy) void(^deleteBlock)(void);

@property (nonatomic, copy) void(^edtingBlock)(void);

@property (nonatomic, strong) AddressMessageModel *model;



@end

NS_ASSUME_NONNULL_END
