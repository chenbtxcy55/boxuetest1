//
//  SuperNotifaTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/13.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SuperNotifaTableViewCell.h"

@implementation SuperNotifaTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.backgroundColor = self.contentView.backgroundColor = kBgColor353750;
    [self.contentView addSubview:self.headerImg];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.septorLine];
}
-(UIImageView *)headerImg
{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(30), ScaleW(40), ScaleW(40))];
        _headerImg.image = [UIImage imageNamed:@"messageIcon"];
        
    }
    return _headerImg;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(_headerImg.right + ScaleW(15), ScaleW(23), ScaleW(290),ScaleW(35)) textAlignment:(NSTextAlignmentLeft)];
        _messageLabel.numberOfLines = 2;
    }
    return _messageLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"--------" font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(_messageLabel.left, _messageLabel.bottom + ScaleW(10), _messageLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _dateLabel;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(99),ScreenWidth - ScaleW(30), ScaleW(1))];
        _septorLine.backgroundColor = kMainLineColor;
    }
    return _septorLine;
}
@end
