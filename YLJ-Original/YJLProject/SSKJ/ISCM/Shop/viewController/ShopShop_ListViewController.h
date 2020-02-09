//
//  ShopShop_ListViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopShop_ListViewController : SSKJ_BaseViewController
@property (nonatomic, assign) NSInteger selectedIndex;

-(void)refreshData;

@end

NS_ASSUME_NONNULL_END
