//
//  MarketCoinCell.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_Market_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface MarketCoinCell : UITableViewCell
@property (nonatomic, strong)UIImageView *bgView;
-(void)setCellWithModel:(SSKJ_Market_Index_Model *)model;
@end

NS_ASSUME_NONNULL_END
