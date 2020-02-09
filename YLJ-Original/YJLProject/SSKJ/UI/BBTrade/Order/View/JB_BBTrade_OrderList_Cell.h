//
//  JB_BBTrade_OrderList_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/14.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_BBTrade_Order_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_OrderList_Cell : UITableViewCell
@property (nonatomic, copy) void (^cancleBlock)(JB_BBTrade_Order_Index_Model *model);
-(void)setCellWithModel:(JB_BBTrade_Order_Index_Model *)model;
@end

NS_ASSUME_NONNULL_END
