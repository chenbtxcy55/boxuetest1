//
//  My_TB_ChooseCoin_AlertView.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/10.
//  Copyright © 2019 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WLLAssetsInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChooseCoinBlock)(WLLAssetsInfoModel *model);


@interface My_TB_ChooseCoin_AlertView : UIView

@property (nonatomic,strong) NSArray * dataSource;

@property (nonatomic,copy) ChooseCoinBlock coinBlock;


@end

NS_ASSUME_NONNULL_END
