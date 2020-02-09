//
//  Shop_OrderList_TableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ICC_Mall_UserOrderType) {
    kcancelOrderEvent = 100,//取消订单
    kgoPayOrderEvent = 101,//去支付
    ksureOrderEvent = 102, //确认订单
    kdeleteOrderEvent = 103,//删除订单
    kcontactShopEvent //联系商家
};
@protocol ICC_Mall_UserOrderList_ViewCellDelegate<NSObject>
-(void)selectedOrderAtIndexPath:(NSIndexPath*)indexPath userHandleType:(ICC_Mall_UserOrderType)handleType;
@end

@interface Shop_OrderList_TableViewCell : UITableViewCell
@property(nonatomic, unsafe_unretained)id<ICC_Mall_UserOrderList_ViewCellDelegate>delegate;
@property(nonatomic, strong)NSIndexPath *indexPath;
- (void)updateViewWithOrderDatas:(NSDictionary*)orderDatas;
- (CGFloat)cellFactHight;
@property (nonatomic, strong) NSDictionary *dataDic;
@end

NS_ASSUME_NONNULL_END
