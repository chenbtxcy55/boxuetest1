//
//  LA_Main_BlockVew.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LA_Main_BlockVew : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, copy) void (^clickBlock)(void);
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
