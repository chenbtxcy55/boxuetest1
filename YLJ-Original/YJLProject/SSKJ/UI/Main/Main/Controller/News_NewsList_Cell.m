//
//  News_NewsList_Cell.m
//  SSKJ
//
//  Created by zpz on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "News_NewsList_Cell.h"

@implementation News_NewsList_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kNavBGColor;
        
        [self iconImageView];
        [self titleLabel];
        [self subTitleLabel];
        [self lineView];
    }
    return self;
}

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        self.iconImageView = [WLTools allocImageView:CGRectZero image:nil];
        [self.contentView addSubview:_iconImageView];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(@((ScaleW(15))));
            make.width.height.equalTo(@((ScaleW(100))));
        }];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = [WLTools allocLabel:nil font:systemScaleFont(15) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 3;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(ScaleW(16));
            make.right.equalTo(@(ScaleW(-15)));
            make.top.equalTo(@(ScaleW(17)));
        }];
    }
    return _titleLabel;
}



- (UILabel *)subTitleLabel{
    if (_subTitleLabel == nil) {
        self.subTitleLabel = [WLTools allocLabel:nil font:systemScaleFont(12) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_subTitleLabel];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(ScaleW(-15)));
            make.bottom.equalTo(@(ScaleW(-14)));
        }];
    }
    return _subTitleLabel;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kLineColor];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.right.equalTo(@(ScaleW(-15)));
            make.height.equalTo(@(ScaleW(1.0)));
            make.bottom.equalTo(@(0));
        }];
    }
    return _lineView;
}

@end
