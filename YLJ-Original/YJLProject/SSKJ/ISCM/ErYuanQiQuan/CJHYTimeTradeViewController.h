//
//  CJHYTimeTradeViewController.h
//  SSKJ
//
//  Created by 张本超 on 2019/8/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//


#import "SSKJ_BaseViewController.h"
#import "JB_Market_Index_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJHYTimeTradeViewController : SSKJ_BaseViewController
//1买涨 2买跌
@property (nonatomic, assign) NSInteger tradeDerection;

@property (nonatomic, strong) JB_Market_Index_Model *currentModel;


@property (nonatomic, copy) void(^buySucessBlock)(void);

@property (nonatomic,assign) NSInteger num;

@property (nonatomic,assign) NSInteger maxnum;

@end

NS_ASSUME_NONNULL_END
