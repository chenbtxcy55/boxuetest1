//
//  AB_Img_Text_view.h
//  SSKJ
//
//  Created by 张本超 on 2019/6/5.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AB_Img_Text_view : UIView
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *securedButton;
@property (nonatomic, strong) NSString *valueString;
-(instancetype)initWithFrame:(CGRect)frame leftGap:(CGFloat)leftGap  placeHolder:(NSString *)placeHolder font:(UIFont *)font keyBoardType:(UIKeyboardType)keyBoardType headImg:(NSString *)headImgStr isShowSecured:(BOOL)secured;
@end

NS_ASSUME_NONNULL_END
