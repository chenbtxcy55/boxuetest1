//
//  HeBi_Charge_HeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/12.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBi_Charge_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Charge_HeaderView : UIView
-(void)setViewWithModel:(HeBi_Charge_Model *)model;
-(void)setViewWithCoinName:(NSString *)coinName;
@end

NS_ASSUME_NONNULL_END
