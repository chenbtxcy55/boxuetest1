//
//  MyIncomeDynamicHeardView.h
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyIncomeDynamicHeardView : UIView
@property (nonatomic,strong)UILabel *tOneLab;//社区人数
@property (nonatomic,strong)UILabel *tTwoLab;//分享奖励
@property (nonatomic,strong)UILabel *tThreeLab;//管理奖励
@property (nonatomic,strong)UILabel *tFoutLab;//累计业绩

@property (nonatomic,strong)UILabel *bOneLab;//级差奖励
@property (nonatomic,strong)UILabel *bTwoLab;//团队奖励
@property (nonatomic,strong)UILabel *bThreeLab;//福利奖励
@property (nonatomic,strong)UILabel *bFoutLab;//大区业绩

@end

NS_ASSUME_NONNULL_END
