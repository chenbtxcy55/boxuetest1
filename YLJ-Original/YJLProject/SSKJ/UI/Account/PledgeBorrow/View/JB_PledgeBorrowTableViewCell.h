//
//  JB_PledgeBorrowTableViewCell.h
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_PledgeBorrowModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_PledgeBorrowTableViewCell : UITableViewCell
- (void)configureCellWithModel:(JB_PledgeBorrowModel *)model;
@end

NS_ASSUME_NONNULL_END
