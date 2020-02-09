//
//  HeBi_InputView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_InputView : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *secureButotn;

@property (nonatomic, copy) NSString *valueString;
- (instancetype)initWithFrame:(CGRect)frame titleWidth:(CGFloat)titleWidth gap:(CGFloat)leftGap titleName:(NSString *)imageName placeHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType isSecured:(BOOL)isSecured;
@end

NS_ASSUME_NONNULL_END
