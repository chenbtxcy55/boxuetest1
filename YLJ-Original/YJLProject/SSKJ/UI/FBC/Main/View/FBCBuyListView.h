//
//  FBCBuyListView.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_FBC_DealHall_OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FBCBuyListView : UIView
-(void)headerRefresh;

@property (nonatomic, copy) void(^gotoBuyBlock)(JB_FBC_DealHall_OrderModel * objc);
@end

NS_ASSUME_NONNULL_END
