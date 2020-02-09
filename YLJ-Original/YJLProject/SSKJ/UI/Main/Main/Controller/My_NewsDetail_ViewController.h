//
//  My_NewsDetail_ViewController.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/2.
//  Copyright © 2019年 Wang. All rights reserved.
//
#import "SSKJ_BaseViewController.h"
#import "GoCoin_TradingGuide_Model.h"
#import "GoCoin_SystemConsult_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface My_NewsDetail_ViewController : SSKJ_BaseViewController

@property (nonatomic, copy) NSString *newsID;
    
@property (nonatomic,assign) NSInteger fromVC;

@property (nonatomic, strong)GoCoin_TradingGuide_Model *model;
    
@property (nonatomic, strong) GoCoin_SystemConsult_Model *systemModel;
@end

NS_ASSUME_NONNULL_END
