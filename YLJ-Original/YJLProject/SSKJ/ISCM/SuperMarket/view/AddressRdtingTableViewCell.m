//
//  AddressRdtingTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "AddressRdtingTableViewCell.h"
@interface AddressRdtingTableViewCell()
@property (nonatomic, strong) UIImageView *addressImg;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *detailAddresslabel;

@property (nonatomic, strong) UIView *septoeLine;

@property (nonatomic, strong) UIButton *defultBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIButton *edtingBtn;


@property (nonatomic, strong) UIView *boomLine;



@end

@implementation AddressRdtingTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         [self viewConfig];
        self.backgroundColor = self.contentView.backgroundColor = kMainColor;
        
    }
    return self;
   
}
-(void)viewConfig
{
    [self.contentView addSubview:self.addressImg];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.detailAddresslabel];
    [self.contentView addSubview:self.septoeLine];
    [self.contentView addSubview:self.defultBtn];
    [self.contentView addSubview:self.edtingBtn];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.boomLine];
}
-(UIImageView *)addressImg
{
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(38), ScaleW(13), ScaleW(15))];
        _addressImg.image = [UIImage imageNamed:@"loction_icon"];
        //loction_icon
    }
    return _addressImg;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(37), ScaleW(18),ScreenWidth -  ScaleW(37), ScaleW(13))];
        [_nameLabel label:_nameLabel font:ScaleW(13) textColor:kMainTextColor text:@"xxx xxxxx"];
        
    }
    return _nameLabel;
}
-(UILabel *)detailAddresslabel
{
    if (!_detailAddresslabel) {
        _detailAddresslabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, ScaleW(11) + _nameLabel.bottom, ScaleW(300), ScaleW(32))];
        [_detailAddresslabel label:_detailAddresslabel font:ScaleW(13) textColor:kGrayTitleColor text:@"-------------------------"];
        _detailAddresslabel.numberOfLines = 0;
        
    }
    return _detailAddresslabel;
}

-(UIView *)septoeLine
{
    if (!_septoeLine) {
        _septoeLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(80), ScreenWidth, ScaleW(1))];
        _septoeLine.backgroundColor = kLineGrayColor;
    }
    return _septoeLine;
}

-(UIButton *)defultBtn
{
    if (!_defultBtn) {
        _defultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defultBtn btn:_defultBtn font:ScaleW(12) textColor:kMainTextColor text:SSKJLocalized(@"默认地址", nil) image:[UIImage imageNamed:@"selected"] sel:@selector(defultAction:) taget:self];
        _defultBtn.frame = CGRectMake(0, _septoeLine.bottom, ScaleW(87), ScaleW(40));
        [_defultBtn setImage:[UIImage imageNamed:@"all_selected"] forState:(UIControlStateSelected)];
        [self setBtnOff:_defultBtn];
    }
    return _defultBtn;
}

-(UIButton *)edtingBtn
{
    if (!_edtingBtn) {
        _edtingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _edtingBtn.frame = CGRectMake(ScreenWidth - ScaleW(80), _septoeLine.bottom, ScaleW(80), ScaleW(40));
        //delete_icon retite_icon01
        [_edtingBtn btn:_edtingBtn font:ScaleW(12) textColor:kMainTextColor text:SSKJLocalized(@"编辑", nil) image:[UIImage imageNamed:@"retite_icon01"] sel:@selector(edtingAction:) taget:self];
        [self setBtnOff:_edtingBtn];
    }
    return _edtingBtn;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(ScaleW(205), _septoeLine.bottom, ScaleW(80), ScaleW(40));
        //delete_icon retite_icon01
        [_deleteBtn btn:_deleteBtn font:ScaleW(12) textColor:kMainTextColor text:SSKJLocalized(@"删除", nil) image:[UIImage imageNamed:@"lajitong_shop"] sel:@selector(deleteAction:) taget:self];
        [self setBtnOff:_deleteBtn];
    }
    return _deleteBtn;
}

-(UIView *)boomLine

{
    if (!_boomLine) {
        _boomLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(120), ScreenWidth, ScaleW(10))];
        _boomLine.backgroundColor = kLineGrayColor;
    }
    return _boomLine;
}
-(void)setBtnOff:(UIButton *)sender
{
    [sender setImageEdgeInsets:UIEdgeInsetsMake(0, ScaleW(-5), 0, 0)];
}

-(void)defultAction:(UIButton *)sender
{
    !self.defultBlock?:self.defultBlock();
    sender.selected = !sender.selected;
    
}
-(void)edtingAction:(UIButton *)sender
{
    !self.edtingBlock?:self.edtingBlock();
}
-(void)deleteAction:(UIButton *)sender
{
    !self.deleteBlock?:self.deleteBlock();
}
-(void)setModel:(AddressMessageModel *)model
{
    _model = model;
    
    self.nameLabel.text =[NSString stringWithFormat:@"%@  %@",model.name,model.mobile];
    
    self.detailAddresslabel.text = [NSString stringWithFormat:@" %@  %@  %@  %@",model.sheng,model.shi,model.qu,model.address];
    
   
    self.defultBtn.selected =model.default_status.integerValue;
    
    
    
}

@end
