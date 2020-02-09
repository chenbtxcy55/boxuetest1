//
//  YLJ_InputView.h
//  SSKJ
//
//  Created by cy5566 on 2019/11/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLJ_InputView : UIView
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *valueString;
- (instancetype)initWithFrame:(CGRect)frame titleWidth:(CGFloat)titleWidth gap:(CGFloat)leftGap titleName:(NSString *)imageName placeHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType isSecured:(BOOL)isSecured;
@end

NS_ASSUME_NONNULL_END
