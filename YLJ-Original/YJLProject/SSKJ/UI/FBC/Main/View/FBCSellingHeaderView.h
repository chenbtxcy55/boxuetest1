//
//  FBCSellingHeaderView.h
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBCSellingHeaderView : UIView
//1出售 2购买
@property (nonatomic, assign) NSInteger sellingType;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UILabel *amountNameLabel;
@property (nonatomic, strong) UITextField *amountTF;
@property (nonatomic, strong) UILabel *limitAmountName;
@property (nonatomic, strong) UITextField *lowLimitTf;
@property (nonatomic, strong) UITextField *hightLimitTf;
@property (nonatomic, strong) UILabel *signlePriceName;
@property (nonatomic, strong) UITextField *signlePriceTf;
@property (nonatomic, strong) UILabel *momoNameLabel;
@property (nonatomic, strong) UITextField *momoTf;
@property (nonatomic, strong) UILabel *payWaysName;
@property (nonatomic, strong) UIView *boomLine;
@end

NS_ASSUME_NONNULL_END
