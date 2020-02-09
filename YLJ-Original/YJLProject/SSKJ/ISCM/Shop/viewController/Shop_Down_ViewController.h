//
//  Shop_Down_ViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Shop_Down_ViewController : SSKJ_BaseViewController

@property (nonatomic, assign) CGFloat bottomLine;

@property (nonatomic, copy) void(^backBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
