//
//  Shop_ApplyToBeShop.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/6.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Shop_ApplyToBeShop : UIView
@property (nonatomic, copy) void(^cancellBlock)(void);

@property (nonatomic, copy) void(^copBlock)(void);

@property (nonatomic, strong) UILabel *subLabel;

@property (nonatomic, strong) UILabel *title2label;

@property (nonatomic, strong) UILabel *sub2label;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
