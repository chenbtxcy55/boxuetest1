//
//  YLJAddBankViewController.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "YLJBankInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLJAddBankViewController : SSKJ_BaseViewController

//添加0 编辑1
@property (nonatomic, assign) NSInteger aType;
@property (nonatomic,strong) YLJBankInfoModel *bModel;
@end

NS_ASSUME_NONNULL_END
