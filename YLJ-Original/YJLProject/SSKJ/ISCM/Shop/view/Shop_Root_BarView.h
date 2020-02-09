//
//  Shop_Root_BarView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/6.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Shop_Root_BarView : UIView

@property (nonatomic, copy) void(^pulishBlock)(void);

@property (nonatomic, copy) void(^orderMangedBlock)(void);

@end

NS_ASSUME_NONNULL_END
