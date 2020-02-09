//
//  HeBi_Address_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Address_Cell.h"

@interface HeBi_Address_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UILabel *addressLabel;
@end

@implementation HeBi_Address_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kSubBackgroundColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.deleteButton];
    [self.contentView addSubview:self.addressLabel];
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"描述", nil)  font:systemBoldFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"6b6fb9"] frame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(200), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIButton *)deleteButton
{
    if (nil == _deleteButton) {
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(30), 0, ScaleW(30), ScaleW(40))];
        _deleteButton.centerY = self.titleLabel.centerY;
        [_deleteButton setTitle:SSKJLocalized(@"删除", nil) forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = systemFont(ScaleW(13));
        [_deleteButton addTarget:self action:@selector(deleteEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

-(UILabel *)addressLabel
{
    if (nil == _addressLabel) {
        _addressLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(11)) textColor:[UIColor colorWithHexStringToColor:@"5b5e95"] frame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom + ScaleW(15), ScreenWidth - ScaleW(30), ScaleW(11)) textAlignment:NSTextAlignmentLeft];
    }
    return _addressLabel;
}


#pragma mark - 删除操作
-(void)deleteEvent
{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

-(void)setCellWithModel:(HeBi_WalletAddress_Model *)model
{
    self.addressLabel.text = model.qiaobao_url;
    self.titleLabel.text = model.notes;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
