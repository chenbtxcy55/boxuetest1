//
//  TradePosionTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJHYPosionModel.h"
#import "JB_Market_Index_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface TradePosionTableViewCell : UITableViewCell

@property (nonatomic, strong) CJHYPosionModel *model;

@property (nonatomic, strong) CJHYPosionModel *timeModel;


@property (nonatomic, copy) void(^shareBlock)(void);

@end

NS_ASSUME_NONNULL_END
