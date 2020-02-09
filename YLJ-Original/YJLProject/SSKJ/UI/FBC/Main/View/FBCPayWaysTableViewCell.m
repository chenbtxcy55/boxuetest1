//
//  FBCPayWaysTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBCPayWaysTableViewCell.h"
@interface FBCPayWaysTableViewCell()
@property (nonatomic, strong) UIImageView *contImg;
@property (nonatomic, strong) UILabel *contName;
@property (nonatomic, strong) UIButton *allRightBtn;
@property (nonatomic, strong) UIView *line;

@end

@implementation FBCPayWaysTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    self.contentView.backgroundColor = self.backgroundColor = kMianBgColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.contImg];
    [self.contentView addSubview:self.contName];
    [self.contentView addSubview:self.allRightBtn];
    [self.contentView addSubview:self.line];
    
    
}
-(UIImageView *)contImg
{
    if (!_contImg) {
        _contImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(26), ScaleW(26))];
        _contImg.image = [UIImage imageNamed:@"alpay_payways"];
        _contImg.centerY = ScaleW(25);
        
    }
    return _contImg;
}
-(UILabel *)contName
{
    if (!_contName) {
        _contName = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(11) + _contImg.right, 0, ScaleW(100), ScaleW(14))];
        [_contName label:_contName font:ScaleW(14) textColor:kTextColorb2b9e7 text:SSKJLocalized(@"支付宝",nil)];
        _contName.centerY = _contImg.centerY;
    }
    return _contName;
}
-(UIButton *)allRightBtn
{
    if (!_allRightBtn) {
        _allRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allRightBtn.frame = CGRectMake(ScreenWidth - ScaleW(35), 0, ScaleW(35), ScaleW(50));
        [_allRightBtn btn:_allRightBtn font:ScaleW(0) textColor:kText878ff5 text:@"" image:[UIImage imageNamed:@"unSelected"] sel:@selector(selecteBtnAction:) taget:self];
        [_allRightBtn setImage:[UIImage imageNamed:@"FBCSelected"] forState:(UIControlStateSelected)];
    }
    return _allRightBtn;
}
-(UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(50) - 1, ScreenWidth - ScaleW(30), 1)];
        _line.backgroundColor = kTextColor313359;
    }
    return _line;
}
-(void)selecteBtnAction:(UIButton *)sender
{
    sender.selected=!sender.selected;
}
@end
