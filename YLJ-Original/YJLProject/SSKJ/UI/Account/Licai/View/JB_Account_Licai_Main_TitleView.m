//
//  JB_Account_Licai_Main_TitleView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_Licai_Main_TitleView.h"

@interface JB_Account_Licai_Main_TitleView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectImageView;
@end

@implementation JB_Account_Licai_Main_TitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.selectImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(17)) textColor:kTextLightBlueColor frame:CGRectMake(0, 0, 0, self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIImageView *)selectImageView
{
    if (nil == _selectImageView) {
        _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(9), ScaleW(6))];
        _selectImageView.image = [UIImage imageNamed:@"licai_down"];
        _selectImageView.centerY = self.titleLabel.centerY;
    }
    return _selectImageView;
}

-(void)setTitle:(NSString *)title
{
    CGFloat width = [WLTools getWidthWithText:title font:self.titleLabel.font];
    self.titleLabel.text = title;
    self.titleLabel.width = width;
    self.selectImageView.x = self.titleLabel.right + ScaleW(5);
    self.width = self.selectImageView.right;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (selected) {
        self.selectImageView.image = [UIImage imageNamed:@"licai_up"];
    }else{
        self.selectImageView.image = [UIImage imageNamed:@"licai_down"];
    }
}

-(void)tapEvent
{
    if (self.tapBlock) {
        self.tapBlock();
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
