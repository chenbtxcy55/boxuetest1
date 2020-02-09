//
//  MyIncomeBaseHeardView.h
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyIncomeBaseHeardView : UIView
@property (nonatomic,strong)UILabel *oneLab;//UID
@property (nonatomic,strong)UILabel *twoLab;//级别
@property (nonatomic,strong)UILabel *threeLab;//层级
@property (nonatomic,strong)UILabel *fourLab;//注册时间
- (void)layoutChildViews;//分享奖励  4个lable
- (void)layoutSuoCang;//锁仓
- (void)layoutFenHong;//级差奖励  团队奖励  三个
- (void)layoutFuWuFei;//服务费
- (void)layoutYuE;//商城余额

@end

NS_ASSUME_NONNULL_END
