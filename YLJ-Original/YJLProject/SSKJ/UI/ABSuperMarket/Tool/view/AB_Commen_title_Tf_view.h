//
//  AB_Commen_title_Tf_view.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/12.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AB_Commen_title_Tf_view : UIView

@property (nonatomic, strong) UITextField *textFild;

-(instancetype)initWithTop:(CGFloat)top title:(NSString *)title subTitle:(NSString *)subTitle;
@end

NS_ASSUME_NONNULL_END
