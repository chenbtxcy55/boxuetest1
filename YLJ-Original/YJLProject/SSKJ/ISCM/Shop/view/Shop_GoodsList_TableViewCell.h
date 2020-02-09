//
//  Shop_GoodsList_TableViewCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICC_PreOrder_GoodsInfo_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Shop_GoodsList_TableViewCell : UITableViewCell

@property (nonatomic, copy) void (^editBlock)(ICC_PreOrder_GoodsInfo_Model *model);
@property (nonatomic, copy) void (^deleteBlock)(ICC_PreOrder_GoodsInfo_Model *model);
@property (nonatomic, copy) void (^upGoodsBlock)(ICC_PreOrder_GoodsInfo_Model *model);
@property (nonatomic, copy) void (^downGoodsBlock)(ICC_PreOrder_GoodsInfo_Model *model);
-(void)setCellWithModel:(ICC_PreOrder_GoodsInfo_Model *)model goodsType:(NSInteger)goosType;
@end

NS_ASSUME_NONNULL_END
