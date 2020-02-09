//
//  ZSJ_SettingTableViewCell.m
//  SSKJ
//
//  Created by zhao on 2019/10/7.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ZSJ_SettingTableViewCell.h"
@interface ZSJ_SettingTableViewCell ()

@property (nonatomic, strong) UIImageView *arrowIamge;
@end
@implementation ZSJ_SettingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = kNavBGColor;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.valueLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.arrowIamge];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScaleW(15));
    }];
    [self.arrowIamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
    make.right.mas_equalTo(self.contentView.mas_right).offset(ScaleW(-15));
        make.size.mas_equalTo(CGSizeMake(ScaleW(6), 10));
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.arrowIamge.mas_left).offset(ScaleW(-10));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.equalTo(self.contentView);
        make.height.equalTo(@(ScaleW(1)));
    }];
    
}
-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(15), 0, ScaleW(80), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}
-(UILabel *)valueLabel
{
    if (nil == _valueLabel) {
        _valueLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kSubTxtColor frame:CGRectMake(self.titleLabel.right + ScaleW(10), 0, ScreenWidth - self.titleLabel.right - ScaleW(10)-ScaleW(15), ScaleW(20)) textAlignment:NSTextAlignmentRight];
        _valueLabel.centerY = self.titleLabel.centerY;
    }
    return _valueLabel;
}
- (UIView *)lineView{
    if (_lineView== nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineBgColor;
    }
    
    return _lineView;
}
- (UIImageView *)arrowIamge{
    if (_arrowIamge == nil) {
        _arrowIamge = [[UIImageView alloc] init];
        _arrowIamge.image = [UIImage imageNamed:@"my_rightArrow"];
    }
    return _arrowIamge;
}
@end
