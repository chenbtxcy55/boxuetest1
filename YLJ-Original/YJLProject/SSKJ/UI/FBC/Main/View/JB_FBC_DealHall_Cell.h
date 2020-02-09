//
//  JB_FBC_DealHall_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_FBC_DealHall_OrderModel.h"
#import "HeBi_BuySell_AlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JB_FBC_DealHall_Cell : UITableViewCell
-(void)setCellWithModel:(JB_FBC_DealHall_OrderModel *)model buySellType:(BuySellType)buySellType;
@end

NS_ASSUME_NONNULL_END
