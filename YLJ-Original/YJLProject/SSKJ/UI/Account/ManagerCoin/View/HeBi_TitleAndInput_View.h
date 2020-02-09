//
//  HeBi_TitleAndInput_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_TitleAndInput_View : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *secureButton;
@property (nonatomic, copy) NSString *valueString;
-(instancetype)initWithFrame:(CGRect )frame leftGap:(CGFloat)leftGap title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType isSecured:(BOOL)isSecured;
@end

NS_ASSUME_NONNULL_END
