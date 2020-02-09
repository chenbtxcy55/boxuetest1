//
//  JB_Shaixun_ItemView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Shaixun_ItemView.h"

@interface JB_Shaixun_ItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *selectButton;
@end

@implementation JB_Shaixun_ItemView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        self.titleLabel.text = title;
        [self addSubview:self.backView];
        [self.backView addSubview:self.label];
        [self.backView addSubview:self.selectButton];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor: kMainTextColor frame:CGRectMake(0, 0, self.width, ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(10), self.width, ScaleW(40))];
        _backView.layer.borderColor =  kMainTextColor.CGColor;
        _backView.layer.borderWidth  = 0.5;
    }
    return _backView;
}

-(UILabel *)label
{
    if (nil == _label) {
        _label = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(ScaleW(10), 0, self.backView.width - ScaleW(20), self.backView.height) textAlignment:NSTextAlignmentLeft];
    }
    return _label;
}

-(UIButton *)selectButton
{
    if (nil == _selectButton) {
        _selectButton = [[UIButton alloc]initWithFrame:CGRectMake(self.backView.width - ScaleW(28), 0, ScaleW(28), self.backView.height)];
        
        [_selectButton setImage:[UIImage imageNamed:@"bc_bb_down"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"bc_bb_up"] forState:UIControlStateSelected];
        _selectButton.selected = NO;
//        _selectButton.userInteractionEnabled = NO;

    }
    return _selectButton;
}

-(void)tapEvent
{
    if (self.selectedBlock) {
        self.selectedBlock();
    }
}

-(void)setSelected:(BOOL)selected
{
    self.selectButton.selected = selected;
}

-(void)setValueString:(NSString *)valueString
{
    self.label.text = valueString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
