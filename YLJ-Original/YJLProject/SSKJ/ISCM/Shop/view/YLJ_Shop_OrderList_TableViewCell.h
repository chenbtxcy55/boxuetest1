//
//  YLJ_Shop_OrderList_TableViewCell.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLJOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLJ_Shop_OrderList_TableViewCell : UITableViewCell

-(void)configCellWithModel:(YLJOrderListModel *)model;
@end

NS_ASSUME_NONNULL_END
