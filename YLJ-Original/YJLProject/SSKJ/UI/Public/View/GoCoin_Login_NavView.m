//
//  GoCoin_Login_NavView.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "GoCoin_Login_NavView.h"

@interface GoCoin_Login_NavView()



@end

@implementation GoCoin_Login_NavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self backBtn];
        
        [self rightBtn];
        
        [self titleLabel];
    }
    return self;
}

- (UIButton *)backBtn
{
    if (_backBtn == nil) {
        
        NSString *str;
        
        if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"en"]) {
            
            str = @"commentWhite";
            
        }
        else if ([[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"zh-Hant"] || [[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"zh-Hans"])
        {
            str = @"commentWhite";
            
        }
        
        _backBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"" titleColor:kMainWihteColor imageName:str backgroundImageName:nil target:self selector:@selector(backBtnAction) font:systemFont(15)];
        
        [self addSubview:_backBtn];
        
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.bottom.equalTo(@(-5));
            
            make.height.equalTo(@(30));
            
            make.width.equalTo(@(60));
            
        }];
    }
    return _backBtn;
}

- (UIButton *)rightBtn
{
    if (_rightBtn == nil) {
        
        _rightBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"" titleColor:[UIColor redColor] imageName:@"" backgroundImageName:nil target:self selector:@selector(rightBtnAction) font:systemFont(15)];
        
        [self addSubview:_rightBtn];
        
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(@0);
            
            make.bottom.equalTo(@(0));
            
            make.height.equalTo(@(40));
            
            make.width.equalTo(@(80));
            
        }];
    }
    return _rightBtn;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kMainWihteColor font:systemFont(18)];
        
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.bottom.equalTo(@(-10));
            
        }];
    }
    return _titleLabel;
}

- (void)backBtnAction
{
    if (self.BackBtnBlock) {
        self.BackBtnBlock();
    }
}

- (void)rightBtnAction
{
    if (self.RightBtnBlock) {
        self.RightBtnBlock();
    }
}



@end
