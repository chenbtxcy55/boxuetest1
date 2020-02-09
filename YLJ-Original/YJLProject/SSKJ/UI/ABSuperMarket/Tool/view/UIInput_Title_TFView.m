//
//  UIInput_Title_TFView.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "UIInput_Title_TFView.h"
@interface UIInput_Title_TFView()
{
    CGFloat _top;
    NSString *_title;
    NSString *_subTitle;
    
}
@property (nonatomic, strong) UILabel *titleLable;


@property (nonatomic, strong) UIView *lineView;




@end

@implementation UIInput_Title_TFView

-(instancetype)initWithTop:(CGFloat)top title:(NSString *)title subTitle:(NSString *)subTitle
{
    if (self = [super init])
    {
        _top = top;
        _title = title;
        _subTitle = subTitle;
        self.frame = CGRectMake(0, _top, ScreenWidth, ScaleW(50));
        [self addSubview:self.titleLable];
        [self addSubview:self.textFild];
        
        
//        self.backgroundColor = kBgColor353750;
        
        
        
    }
    return self;
};

-(UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [WLTools allocLabel:_title font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), 0, ScaleW(80), ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLable;
}
-(UITextField *)textFild
{
    if (!_textFild) {
        _textFild = [[UITextField alloc]initWithFrame:CGRectMake(_titleLable.right, 0,ScreenWidth - ScaleW(95), ScaleW(50))];
        [_textFild textField:_textFild textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:_subTitle textColor:kMainTextColor placeHolderTextColor:kGrayTitleColor];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(49),ScreenWidth- ScaleW(30), ScaleW(1))];
        lineView.backgroundColor = kLineGrayColor;
        [self addSubview:lineView];
    }
    return _textFild;
}



@end
