//
//  ShopShop_OrderListTableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ICC_Mall_BusinessOrderList_ViewCellDelegate<NSObject>
-(void)selectedOrderAtIndexPath:(NSIndexPath*)indexPath userHandleType:(ICC_Mall_BusinessOrderType)handleType;
@end
@interface ShopShop_OrderListTableViewCell : UITableViewCell
@property(nonatomic, unsafe_unretained)id<ICC_Mall_BusinessOrderList_ViewCellDelegate>delegate;
@property(nonatomic, strong)NSIndexPath *indexPath;
- (void)updateViewWithOrderDatas:(NSDictionary*)orderDatas;
- (CGFloat)cellFactHight;
@property (nonatomic,strong) NSDictionary *dataDict;

@end

NS_ASSUME_NONNULL_END
