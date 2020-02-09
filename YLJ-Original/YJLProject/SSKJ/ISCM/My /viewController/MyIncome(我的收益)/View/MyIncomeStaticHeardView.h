//
//  MyIncomeStaticHeardView.h
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyIncomeStaticHeardView : UIView
@property (nonatomic,strong)UILabel *aOneLab;//待释放
@property (nonatomic,strong)UILabel *aTwoLab;//已释放
@property (nonatomic,strong)UILabel *aThreeLab;//已释放
//@property (nonatomic,strong)UILabel *aFourLab;//释放速率

@property (nonatomic,strong)UILabel *bOneLab;//大区
@property (nonatomic,strong)UILabel *bTwoLab;//当月业绩
@property (nonatomic,strong)UILabel *bThreeLab;//累计业绩
//@property (nonatomic,strong)UILabel *bFourLab;//释放速率

@end

NS_ASSUME_NONNULL_END
