//
//  JB_Account_Asset_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_Asset_Cell.h"

@interface JB_Account_Asset_Cell ()
@property (nonatomic, strong) UIImageView *coinImageView;
@property (nonatomic, strong) UILabel *coinNameLabel;
@property (nonatomic, strong) UIImageView *enterImageView;
@property (nonatomic, strong) UILabel *detailLabel;     // 明细
@property (nonatomic, strong) UILabel *canUseTitleLabel;    // 可用
@property (nonatomic, strong) UILabel *canUseLabel;
@property (nonatomic, strong) UILabel *frozeTitleLabel; // 冻结
@property (nonatomic, strong) UILabel *frozeLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation JB_Account_Asset_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kSubBackgroundColor;
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self.contentView addSubview:self.coinImageView];
    [self.contentView addSubview:self.coinNameLabel];
    [self.contentView addSubview:self.enterImageView];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.canUseTitleLabel];
    [self.contentView addSubview:self.canUseLabel];
    [self.contentView addSubview:self.frozeTitleLabel];
    [self.contentView addSubview:self.frozeLabel];
}

-(UIImageView *)coinImageView
{
    if (nil == _coinImageView) {
        _coinImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(7), ScaleW(30), ScaleW(30))];
        _coinImageView.layer.masksToBounds = YES;
        _coinImageView.layer.cornerRadius = _coinImageView.height / 2;
    }
    return _coinImageView;
}

-(UILabel *)coinNameLabel
{
    if (nil == _coinNameLabel) {
        _coinNameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor: kMainTextColor frame:CGRectMake(self.coinImageView.right + ScaleW(10), 0, ScaleW(100), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _coinNameLabel.centerY = self.coinImageView.centerY;
    }
    return _coinNameLabel;
}

-(UIImageView *)enterImageView
{
    if (nil == _enterImageView) {
        _enterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(8), ScaleW(7), ScaleW(8), ScaleW(15))];
        _enterImageView.centerY = self.coinImageView.centerY;
        _enterImageView.image = [UIImage imageNamed:@"wd_icon_right"];
    }
    return _enterImageView;
}

-(UILabel *)detailLabel
{
    if (nil == _detailLabel) {
        _detailLabel = [WLTools allocLabel:SSKJLocalized(@"明细", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.enterImageView.x - ScaleW(10) - ScaleW(100), 0, ScaleW(100), ScaleW(20)) textAlignment:NSTextAlignmentRight];
        _detailLabel.centerY = self.enterImageView.centerY;
    }
    return _detailLabel;
}

-(UILabel *)canUseTitleLabel
{
    if (nil == _canUseTitleLabel) {
        _canUseTitleLabel = [WLTools allocLabel:SSKJLocalized(@"可用", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.coinImageView.x, self.coinImageView.bottom + ScaleW(16), ScaleW(120), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _canUseTitleLabel;
}

-(UILabel *)canUseLabel
{
    if (nil == _canUseLabel) {
        _canUseLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor: kMainTextColor frame:CGRectMake(self.canUseTitleLabel.x, self.canUseTitleLabel.bottom + ScaleW(10), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _canUseLabel;
    
}

-(UILabel *)frozeTitleLabel
{
    if (nil == _frozeTitleLabel) {
        _frozeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"冻结", nil) font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(100), self.canUseTitleLabel.y, ScaleW(50), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _frozeTitleLabel;
}

-(UILabel *)frozeLabel
{
    if (nil == _frozeLabel) {
        _frozeLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor: kMainTextColor frame:CGRectMake(self.frozeTitleLabel.x, self.canUseTitleLabel.bottom + ScaleW(10), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _frozeLabel;
    
}

-(void)setCellWithModel:(JB_Account_Asset_Index_Model *)coinModel assetType:(AssetType)assetType
{
    if (assetType == AssetTypeLicai) {
        self.coinImageView.image = [UIImage imageNamed:coinModel.mark];
        self.coinNameLabel.text = coinModel.mark;
    }else{
        self.coinImageView.image = [UIImage imageNamed:coinModel.pname];
        self.coinNameLabel.text = coinModel.pname;
    }
    self.canUseLabel.text = [WLTools noroundingStringWith:coinModel.usable.doubleValue afterPointNumber:8];
    self.frozeLabel.text = [WLTools noroundingStringWith:coinModel.frost.doubleValue afterPointNumber:8];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
