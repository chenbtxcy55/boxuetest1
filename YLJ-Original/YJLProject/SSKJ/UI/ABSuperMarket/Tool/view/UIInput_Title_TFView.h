//
//  UIInput_Title_TFView.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIInput_Title_TFView : UIView

@property (nonatomic, strong) UITextField *textFild;

-(instancetype)initWithTop:(CGFloat)top title:(NSString *)title subTitle:(NSString *)subTitle;

@end

NS_ASSUME_NONNULL_END
