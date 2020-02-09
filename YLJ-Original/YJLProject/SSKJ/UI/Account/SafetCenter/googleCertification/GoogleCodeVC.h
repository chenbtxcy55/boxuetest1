//
//  GoogleCodeVC.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2018/8/30.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
@class WLLAssetsInfoModel;
@interface GoogleCodeVC : SSKJ_BaseViewController
@property (nonatomic,copy) NSString *fromVC;
@property (nonatomic, strong) WLLAssetsInfoModel *model;
@end
