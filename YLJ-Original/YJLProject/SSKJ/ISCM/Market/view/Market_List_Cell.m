//
//  Market_List_Cell.m
//  SSKJ
//
//  Created by zpz on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Market_List_Cell.h"

@implementation Market_List_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    
    UILabel *label = [WLTools allocLabel:nil font:systemScaleBoldFont(16) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(50)));
        make.centerY.equalTo(@0);
    }];
    self.titleLabel = label;
    
    self.subTitleLabel = [WLTools allocLabel:@"/USDT" font:systemScaleFont(12) textColor:kGrayTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.centerY.equalTo(@0);
    }];
    
    
    self.moneyLabel = [WLTools allocLabel:@"0" font:systemScaleFont(16) textColor:kGreenColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(ScreenWidth * 0.4);
        make.top.equalTo(@(ScaleW(15)));
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.28);
    }];
    
    self.subMoneyLabel = [WLTools allocLabel:@"0" font:systemScaleFont(12) textColor:kGrayTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    self.subMoneyLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.subMoneyLabel];
    [self.subMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.moneyLabel);
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(ScaleW(5));
    }];
    
    self.marketBtn = [WLTools allocButton:nil textColor:kMainWihteColor nom_bg:nil hei_bg:nil frame:CGRectZero];
    self.marketBtn.titleLabel.font = systemScaleBoldFont(14);
    self.marketBtn.backgroundColor = kGreenColor;
    self.marketBtn.userInteractionEnabled = NO;
    self.marketBtn.layer.masksToBounds = YES;
    self.marketBtn.layer.cornerRadius = ScaleW(36) * 0.5;
    [self.contentView addSubview:self.marketBtn];
    [self.marketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(ScaleW(-15)));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(ScaleW(70)));
        make.height.equalTo(@(ScaleW(36)));
    }];
    
    
}


- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        self.iconImageView = [WLTools allocImageView:CGRectZero image:nil];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.centerY.equalTo(@0);
            make.width.height.equalTo(@(ScaleW(25)));
        }];
    }
    return _iconImageView;
}


@end
