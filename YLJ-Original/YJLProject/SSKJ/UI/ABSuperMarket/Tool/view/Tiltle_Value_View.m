//
//  Tiltle_Value_View.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Tiltle_Value_View.h"
@interface Tiltle_Value_View()
{
    NSString *_title;
    NSString *_valueString;
}

@end


@implementation Tiltle_Value_View

-(instancetype)initWithTile:(NSString *)title valueString:(NSString *)valueString topMargin:(CGFloat)topMargin
{
    if (self = [super init]) {
        _title = title;
        _valueString = valueString;
        self.frame = CGRectMake(0, topMargin, ScreenWidth, ScaleW(42));
        [self addSubview:self.titleLabel];
        [self addSubview:self.valueLabel];
    }
    return self;
   
    
};

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:_title font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(16), 0, ScaleW(74), ScaleW(42)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}

-(UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [WLTools allocLabel:@"xx AB" font:systemFont(ScaleW(14)) textColor:kSubTxtColor frame:CGRectMake(_titleLabel.right, 0, ScreenWidth - ScaleW(30) - ScaleW(74), ScaleW(42)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _valueLabel;
}


@end
