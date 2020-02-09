//
//  JB_FBC_Publish_TitleView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeBi_BuySell_AlertView.h"

NS_ASSUME_NONNULL_BEGIN



@interface JB_FBC_Publish_TitleView : UIView
@property (nonatomic, copy) void (^changeTypeBlock)(BuySellType buySellType);

-(instancetype)initWithFrame:(CGRect)frame buyTitle:(NSString *)buyTitle sellTitle:(NSString *)sellTitle;

-(void)setSelectIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
