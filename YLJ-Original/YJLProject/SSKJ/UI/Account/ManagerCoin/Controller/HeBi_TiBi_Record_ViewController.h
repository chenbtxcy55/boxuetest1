//
//  HeBi_TiBi_Record_ViewController.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "HeBi_TiBi_Record_Cell.h"
#import "WLLAssetsInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HeBi_TiBi_Record_ViewController : SSKJ_BaseViewController
@property (nonatomic, strong) WLLAssetsInfoModel *coinModel;
@property (nonatomic, assign) DealType dealType;
@end

NS_ASSUME_NONNULL_END
