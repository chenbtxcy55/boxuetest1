//
//  My_Community_heardView.h
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface My_Community_heardView : UIView
@property (nonatomic,strong)UILabel *tOneLab;//社区人数
@property (nonatomic,strong)UILabel *tTwoLab;//锁仓
@property (nonatomic,strong)UILabel *tThreeLab;//释放
@property (nonatomic,strong)UILabel *tFoutLab;//加权

@property (nonatomic,strong)UILabel *bOneLab;//大区
@property (nonatomic,strong)UILabel *bTwoLab;//当月业绩
@property (nonatomic,strong)UILabel *bThreeLab;//累计业绩
@property (nonatomic,strong)UILabel *bFoutLab;//服务费奖励


@end

NS_ASSUME_NONNULL_END
