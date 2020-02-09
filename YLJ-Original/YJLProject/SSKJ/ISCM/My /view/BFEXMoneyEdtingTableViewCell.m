//
//  BFEXMoneyEdtingTableViewCell.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/17.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEXMoneyEdtingTableViewCell.h"


@interface BFEXMoneyEdtingTableViewCell()

@property (nonatomic, strong) UIView *contView;
//描述
@property (nonatomic, strong) UILabel *descrptionLabel;
//地址
@property (nonatomic, strong) UILabel *addressLabel;
//删除
@property (nonatomic, strong) UIButton *deleBtn;
@end
@implementation BFEXMoneyEdtingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self viewConfig];
        self.backgroundColor = kMainColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)viewConfig
{
    [self contView];
}

-(UIView *)contView{
    if (!_contView) {
        _contView = [[UIView alloc]init];
        _contView.width = Screen_Width;
        _contView.height = 82;
        _contView.left = 0;
        _contView.top = 0;
        _contView.backgroundColor = kMainColor;;
        [self.contentView addSubview:_contView];
        [_contView addSubview:self.deleBtn];
        [_contView addSubview:self.descrptionLabel];
        [_contView addSubview:self.addressLabel];
        
    }
    return _contView;
}
-(UIButton *)deleBtn{
    if (!_deleBtn) {
        _deleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _deleBtn.width = [self returnWidth:SSKJLocalized(@"删除", nil) font:14.f];
        _deleBtn.height = 40;
        _deleBtn.right = _contView.width - 15.f;
        _deleBtn.centerY = self.descrptionLabel.centerY;
        [self.contentView btn:_deleBtn font:14.f textColor:kMainTextColor text:SSKJLocalized(@"删除", nil) image:nil sel:@selector(deleteAction:) taget:self];
    }
    return _deleBtn;
}

-(void)deleteAction:(UIButton *)sender
{
    self.deleBlock();
}
-(UILabel *)descrptionLabel{
    if (!_descrptionLabel) {
        _descrptionLabel = [[UILabel alloc]init];
        _descrptionLabel.width = _contView.width - 10.f - _deleBtn.width - 15;
        _descrptionLabel.height = 14.f;
        _descrptionLabel.left = 13.f;
        _descrptionLabel.top = 20.f;
        _descrptionLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView label:_descrptionLabel font:16.f textColor:kSubTxtColor text:@"-----"];
        
    }
    return _descrptionLabel;
}

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.width = _descrptionLabel.width;
        _addressLabel.adjustsFontSizeToFitWidth = YES;
        _addressLabel.height = 15;
        _addressLabel.left = _descrptionLabel.left;
        _addressLabel.top = 15 + _descrptionLabel.bottom;
        [self.contentView label:_addressLabel font:14 textColor:kMainWihteColor text:@"----"];
    }
    return _addressLabel;
}

-(void)setValueWithData:(id)data
{
    self.descrptionLabel.text = data[@"notes"];
    self.addressLabel.text = data[@"qiaobao_url"];
};

@end
