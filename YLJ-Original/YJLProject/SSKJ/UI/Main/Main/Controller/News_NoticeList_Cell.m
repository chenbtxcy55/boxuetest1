//
//  News_NoticeList_Cell.m
//  SSKJ
//
//  Created by zpz on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "News_NoticeList_Cell.h"

@implementation News_NoticeList_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:kNavBGColor];
        
        [self titleLabel];
        [self subTitleLabel];
        [self lineView];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = [WLTools allocLabel:nil font:systemScaleFont(15) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));;
            make.right.equalTo(@(ScaleW(-15)));
            make.top.equalTo(@(ScaleW(16)));
        }];
        [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    }
    return _titleLabel;
}



- (UILabel *)subTitleLabel{
    if (_subTitleLabel == nil) {
        self.subTitleLabel = [WLTools allocLabel:nil font:systemScaleFont(12) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_subTitleLabel];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(17));
            make.right.equalTo(@(ScaleW(-15)));
            make.bottom.equalTo(@(ScaleW(-20)));
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
