//
//  HeBi_TiBi_Record_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBi_TiBiRecord_Index_Model.h"

typedef NS_ENUM(NSUInteger, DealType) {
    DealTypeTibi,   // 提币
    DealTypeChongbi // 充币
};

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_TiBi_Record_Cell : UITableViewCell
@property (nonatomic, copy) void (^cancleBlock)(void);
-(void)setCellWithDealType:(DealType)dealType model:(HeBi_TiBiRecord_Index_Model *)model;
@end

NS_ASSUME_NONNULL_END
