//
//  ShopNoShop_View.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/6.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopNoShop_View : UIView
@property (nonatomic, copy) void(^tobeShopBlock)(void);
@property (nonatomic,strong) NSString *msg;
@property (nonatomic,assign) BOOL isShowBt;

@end

NS_ASSUME_NONNULL_END
