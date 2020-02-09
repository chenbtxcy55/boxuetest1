//
//  HeBi_ApplyShop_AlertView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/24.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_ApplyShop_AlertView : UIView
@property (nonatomic, copy) void (^confirmBlock)(void);

-(void)show;
-(void)hide;

@end

NS_ASSUME_NONNULL_END
