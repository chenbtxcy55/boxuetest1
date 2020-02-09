//
//  JB_PledgeRecordTableViewCell.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_PledgeRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol JB_PledgeRecordTableViewCellDelegate <NSObject>

// 赎回
- (void)buyBackDidSelectedWithModel:(JB_PledgeRecordModel *)model;

// 补仓
- (void)addDidSelectedWithModel:(JB_PledgeRecordModel *)model;

@end

@interface JB_PledgeRecordTableViewCell : UITableViewCell
@property (nonatomic, weak) id <JB_PledgeRecordTableViewCellDelegate> delegate;
@property (nonatomic, strong) JB_PledgeRecordModel *recordModel;
@end

NS_ASSUME_NONNULL_END
