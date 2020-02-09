//
//  GoCoin_Login_NavView.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoCoin_Login_NavView : UIView

@property (nonatomic,strong) UIButton *backBtn;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIButton *rightBtn;

//返回

@property (nonatomic, copy) void (^BackBtnBlock)(void);

//右边按钮

@property (nonatomic, copy) void (^RightBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
