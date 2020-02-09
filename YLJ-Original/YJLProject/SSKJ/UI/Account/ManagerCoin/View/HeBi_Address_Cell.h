//
//  HeBi_Address_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBi_WalletAddress_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Address_Cell : UITableViewCell
@property (nonatomic, copy) void (^deleteBlock)(void);

-(void)setCellWithModel:(HeBi_WalletAddress_Model *)model;
@end

NS_ASSUME_NONNULL_END
