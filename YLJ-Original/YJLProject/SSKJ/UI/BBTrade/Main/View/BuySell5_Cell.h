//
//  BuySell5_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETF_Contract_Depth_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface BuySell5_Cell : UITableViewCell
@property (nonatomic, copy,readonly) NSString *price;
-(void)setCellWithIndexPath:(NSIndexPath *)indexPath price:(NSString *)price number:(NSString *)number dotNumber:(NSInteger)dotNumber totalDotNumber:(NSInteger)totalDotNumber maxVolume:(NSString *)maxVolume coinAmountDotNumber:(NSInteger)coinNameDotNumber model:(ETF_Contract_Depth_Index_Model *)model;
@end

NS_ASSUME_NONNULL_END
