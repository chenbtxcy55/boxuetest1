//
//  Mine_PayWays_InputView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/12.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_PayWays_InputView : UIView
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *securedButton;
@property (nonatomic, strong) NSString *valueString;
-(instancetype)initWithFrame:(CGRect)frame leftGap:(CGFloat)leftGap  placeHolder:(NSString *)placeHolder font:(UIFont *)font keyBoardType:(UIKeyboardType)keyBoardType titleText:(NSString *)titleText rightView:(UIView *)rightView;

@end


NS_ASSUME_NONNULL_END
