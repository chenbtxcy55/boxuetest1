//
//  Shop_list_view.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Shop_list_view : UIView

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, copy) void(^selectBlock)(NSInteger index);

@property (nonatomic, strong) UIButton *detailBtn;

@property (nonatomic, strong) UIButton *scoreBtn;

@end

NS_ASSUME_NONNULL_END
