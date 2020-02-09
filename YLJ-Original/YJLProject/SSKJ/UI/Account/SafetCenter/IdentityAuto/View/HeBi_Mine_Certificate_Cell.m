//
//  HeBi_Mine_Certificate_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Mine_Certificate_Cell.h"


@interface HeBi_Mine_Certificate_Cell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *enterImageView;

@end

@implementation HeBi_Mine_Certificate_Cell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kSubBackgroundColor;
        self.backgroundColor = [UIColor clearColor];
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.enterImageView];
    [self.contentView addSubview:self.detailLabel];
}



- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:[UIColor colorWithHexStringToColor:@"b3b7e9"] frame:CGRectMake(ScaleW(15), ScaleW(10), ScaleW(200), ScaleW(30)) textAlignment:NSTextAlignmentLeft];
        _titleLabel.font = [UIFont systemFontOfSize:ScaleW(15) weight:UIFontWeightThin];
    }
    return _titleLabel;
}

-(UIImageView *)enterImageView
{
    if (nil == _enterImageView) {
        _enterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(8.5), 0, ScaleW(8.5), ScaleW(15))];
        _enterImageView.centerY = self.titleLabel.centerY;
        _enterImageView.image = [UIImage imageNamed:@"arrow_right_icon"];
    }
    return _enterImageView;
}

-(UILabel *)detailLabel
{
    if (nil == _detailLabel) {
        _detailLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(self.enterImageView.x - ScaleW(5) - ScaleW(200), 0, ScaleW(200), ScaleW(30)) textAlignment:NSTextAlignmentRight];
        _detailLabel.centerY = self.titleLabel.centerY;
    }
    return _detailLabel;
}

-(void)setTitle:(NSString *)title status:(NSString *)status
{
    self.titleLabel.text = title;
    self.detailLabel.text = status;
    
    if ([status isEqualToString:SSKJLocalized(@"已认证", nil)] || [status isEqualToString:SSKJLocalized(@"审核中", nil)] ) {
        self.detailLabel.textColor = [UIColor colorWithHexStringToColor:@"6b6fb9"];
    }else if ([status isEqualToString:SSKJLocalized(@"未认证", nil)]){
        self.detailLabel.textColor = [UIColor colorWithHexStringToColor:@"6b6fb9"];
    }else if ([status isEqualToString:SSKJLocalized(@"已拒绝", nil)]){
        self.detailLabel.textColor = RED_HEX_COLOR;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
