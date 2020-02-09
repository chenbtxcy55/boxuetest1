//
//  HeBi_PayMethodView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_PayMethodView.h"

@interface HeBi_PayMethodView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *boxButton;

@end

@implementation HeBi_PayMethodView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.boxButton];
    }
    return self;
}

-(UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(26), ScaleW(26))];
        _imageView.centerY = self.height / 2;
    }
    return _imageView;
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        _nameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor: kMainTextColor frame:CGRectMake(self.imageView.right + ScaleW(10), 0, ScaleW(200), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _nameLabel.centerY = self.imageView.centerY;
    }
    return _nameLabel;
}

-(UIButton *)boxButton
{
    if (nil == _boxButton) {
        _boxButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(43), 0, ScaleW(43), self.height)];
        [_boxButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [_boxButton setImage:[UIImage imageNamed:@"all_selected"] forState:UIControlStateSelected];
        [_boxButton addTarget:self action:@selector(selectEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boxButton;
}

-(void)selectEvent
{
    self.boxButton.selected = !self.boxButton.selected;
    if (self.selectBlock) {
        self.selectBlock(self.boxButton.selected);
    }
}


-(void)setViewWithModel:(JB_PayWayModel *)model
{
    self.model = model;
    if ([model.type isEqualToString:@"alipay"]) {
        self.imageView.image = [UIImage imageNamed:@"FBCalpay"];
        self.nameLabel.text = SSKJLocalized(@"支付宝", nil);
    }else if ([model.type isEqualToString:@"backcard"]){
        self.imageView.image = [UIImage imageNamed:@"bankCard"];
        self.nameLabel.text = SSKJLocalized(@"银行卡", nil);
    }else if ([model.type isEqualToString:@"wx"]){
        self.imageView.image = [UIImage imageNamed:@"wechatPayWay"];
        self.nameLabel.text = SSKJLocalized(@"微信", nil);
    }
}

- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    self.boxButton.selected = isSelect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
