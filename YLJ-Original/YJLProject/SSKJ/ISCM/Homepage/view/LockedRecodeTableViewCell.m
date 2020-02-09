//
//  LockedRecodeTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "LockedRecodeTableViewCell.h"

@interface LockedRecodeTableViewCell()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *unLockedLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *lockedLabel;

@property (nonatomic, strong) UIView *septorLine;




@end

@implementation LockedRecodeTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.contentView.backgroundColor = self.backgroundColor = kMainWihteColor;
    
   
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.dateLabel];
    
    [self.contentView addSubview:self.unLockedLabel];
    
    [self.contentView addSubview:self.lockedLabel];
    
    [self.contentView addSubview:self.septorLine];
    
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"xx锁仓套餐" font:systemBoldFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(16), ScaleW(21), ScreenWidth/2.f, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"xxxx-xx-xx xx:xx:xx" font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(16), ScaleW(23), ScreenWidth/2.f, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
        _dateLabel.right = ScreenWidth - ScaleW(16);
    }
    return _dateLabel;
}

-(UILabel *)unLockedLabel
{
    if (!_unLockedLabel) {
        _unLockedLabel = [WLTools allocLabel:@"未解仓" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(_nameLabel.left, ScaleW(20) + _nameLabel.bottom, ScreenWidth/2.f, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _unLockedLabel;
}

-(UILabel *)lockedLabel
{
    if (!_lockedLabel) {
        _lockedLabel = [WLTools allocLabel:@"已解仓" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(16), _unLockedLabel.top, ScreenWidth/2.f, ScaleW(13)) textAlignment:(NSTextAlignmentRight)];
        
        _lockedLabel.right = ScreenWidth - ScaleW(16);
    }
    return _lockedLabel;
}

-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(89) - 1, ScreenWidth, 1)];
        _septorLine.backgroundColor = kBgColor;
    }
    return _septorLine;
}
-(void)setModel:(LockedRecodModel *)model
{
    _model = model;
    
    self.nameLabel.text = _model.rname;
    
    self.lockedLabel.text = [NSString stringWithFormat:@"已解锁%@",_model.ynum];
    
    self.unLockedLabel.text = [NSString stringWithFormat:@"未解锁%@",_model.lnum];
    
    self.dateLabel.text = [WLTools convertTimestamp:_model.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
}
@end
