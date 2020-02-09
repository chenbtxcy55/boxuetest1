//
//  HeBi_Address_SectionHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Address_SectionHeaderView.h"

@interface HeBi_Address_SectionHeaderView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation HeBi_Address_SectionHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kSubBackgroundColor;
        self.contentView.backgroundColor = kSubBackgroundColor;
        [self addSubview:self.lineView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.addButton];
    }
    return self;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
        _lineView.backgroundColor = kMainBackgroundColor;
    }
    return _lineView;
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        _nameLabel = [WLTools allocLabel:@"BTC" font:systemBoldFont(ScaleW(13)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.lineView.bottom + ScaleW(18), ScaleW(100), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

-(UIButton *)addButton
{
    if (nil == _addButton) {
        _addButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(ScaleW(17)), 0, ScaleW(17), ScaleW(17))];
        [_addButton setImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];;
        _addButton.centerY = self.nameLabel.centerY;
        [_addButton addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}


-(void)setCoinName:(NSString *)coinName
{
    _coinName = coinName;
    self.nameLabel.text = coinName;
}

-(void)addEvent
{
    if (self.addBlock) {
        self.addBlock(self.nameLabel.text);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
