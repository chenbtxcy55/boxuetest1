//
//  ActivateTableViewCell.m
//  SSKJ
//
//  Created by zhao on 2019/10/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 激活预约cell
 */
#import "ActivateTableViewCell.h"
@interface ActivateTableViewCell()

@property (nonatomic,strong)UIView *lineView;//

@end
@implementation ActivateTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kNavBGColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createView];
        [self layoutChildViews];
    }
    return self;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleW(47) - ScaleW(1) , ScreenWidth, ScaleW(1))];
        _lineView.backgroundColor = kLineBgColor;
    }
    return _lineView;
}
-(UIImageView *)clickImage{
    if (!_clickImage) {
        _clickImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clickN"]];
    }
    return _clickImage;
}
- (UILabel *)detailLab{
    if (!_detailLab) {
        _detailLab = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor:kMainWihteColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _detailLab.numberOfLines = 1;
    }
    return _detailLab;
}
- (void)createView {
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.clickImage];
    [self.contentView addSubview:self.detailLab];
}

- (void)layoutChildViews {
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@(ScaleW(1)));
    }];
    [self.clickImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(ScaleW(12), ScaleW(12)));
        make.left.equalTo(self.contentView.mas_left).offset(ScaleW(24));
    }];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.clickImage.mas_right).offset(ScaleW(13));
        make.right.equalTo(self.contentView.mas_right).offset(ScaleW(-24));

    }];
}

@end
