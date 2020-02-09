//
//  JB_FBC_OrderDetail_PayIndexView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/18.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_FBC_OrderDetail_PayIndexView.h"

@interface JB_FBC_OrderDetail_PayIndexView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *bankNameLabel;
@property (nonatomic, strong) UILabel *branchLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *qrCodeButton;
@property (nonatomic, strong) UIButton *boxButton;

@property (nonatomic, strong) UIButton *numberDumplicationButton; // 银行卡号复制按钮
@property (nonatomic, strong) UIButton *bankDumplicationButton; // 银行卡复制按钮
@property (nonatomic, strong) UIButton *branchDumplicationButton; // 支行复制按钮
@property (nonatomic, strong) UIButton *nameDumplicationButton; // 姓名复制按钮

@end

@implementation JB_FBC_OrderDetail_PayIndexView

- (instancetype)initWithFrame:(CGRect)frame canSelect:(BOOL)isCanSelect
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        [self addSubview:self.bankNameLabel];
        [self addSubview:self.branchLabel];
        [self addSubview:self.nameLabel];
        
        [self addSubview:self.qrCodeButton];
        if (isCanSelect) {
            [self addSubview:self.boxButton];
        }
        
        [self addSubview:self.numberDumplicationButton];
        [self addSubview:self.bankDumplicationButton];
        [self addSubview:self.branchDumplicationButton];
        [self addSubview:self.nameDumplicationButton];

    }
    return self;
}

-(UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(30), 0, ScaleW(20), ScaleW(20))];
        _imageView.centerY = self.height / 2;
    }
    return _imageView;
}

- (UILabel *)label
{
    if (nil == _label) {
        _label = [WLTools allocLabel:@"" font:systemFont(ScaleW(11)) textColor: kMainTextColor frame:CGRectMake(self.imageView.right + ScaleW(10), 0, 0, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _label.centerY = self.imageView.centerY;
    }
    return _label;
}

- (UILabel *)bankNameLabel
{
    if (nil == _bankNameLabel) {
        _bankNameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(11)) textColor: kMainTextColor frame:CGRectMake(self.imageView.right + ScaleW(10), self.label.bottom + ScaleW(5), ScaleW(200), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        
    }
    return _bankNameLabel;
}

- (UILabel *)branchLabel
{
    if (nil == _branchLabel) {
        _branchLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(11)) textColor: kMainTextColor frame:CGRectMake(self.imageView.right + ScaleW(10), self.bankNameLabel.bottom + ScaleW(5), ScaleW(200), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
    }
    return _branchLabel;
}

- (UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        _nameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(11)) textColor: kMainTextColor frame:CGRectMake(self.imageView.right + ScaleW(10), self.branchLabel.bottom + ScaleW(5), ScaleW(200), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

-(UIButton *)qrCodeButton
{
    if (nil == _qrCodeButton) {
        _qrCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(20), ScaleW(40))];
        _qrCodeButton.centerY = self.label.centerY;
        [_qrCodeButton setImage:[UIImage imageNamed:@"twoCodeImg"] forState:UIControlStateNormal];
        [_qrCodeButton addTarget:self action:@selector(showQRCodeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qrCodeButton;
}

-(UIButton *)boxButton
{
    if (nil == _boxButton) {
        _boxButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(40), 0, ScaleW(40), ScaleW(40))];
        [_boxButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [_boxButton setImage:[UIImage imageNamed:@"all_selected"] forState:UIControlStateSelected];
        _boxButton.centerY = self.qrCodeButton.centerY;
        _boxButton.hidden = YES;
        [_boxButton addTarget:self action:@selector(boxEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boxButton;
}


-(UIButton *)numberDumplicationButton
{
    if (nil == _numberDumplicationButton) {
        _numberDumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(self.boxButton.x - ScaleW(40), 0, ScaleW(40), ScaleW(40))];
        [_numberDumplicationButton setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
        _numberDumplicationButton.centerY = self.qrCodeButton.centerY;
        [_numberDumplicationButton addTarget:self action:@selector(dumplicationEvent:) forControlEvents:UIControlEventTouchUpInside];
        _numberDumplicationButton.hidden = YES;
    }
    return _numberDumplicationButton;
}

-(UIButton *)bankDumplicationButton
{
    if (nil == _bankDumplicationButton) {
        _bankDumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(self.boxButton.x - ScaleW(40), 0, ScaleW(40), ScaleW(40))];
        [_bankDumplicationButton setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
        _bankDumplicationButton.centerY = self.bankNameLabel.centerY;
        [_bankDumplicationButton addTarget:self action:@selector(dumplicationEvent:) forControlEvents:UIControlEventTouchUpInside];
        _bankDumplicationButton.hidden = YES;
    }
    return _bankDumplicationButton;
}


-(UIButton *)branchDumplicationButton
{
    if (nil == _branchDumplicationButton) {
        _branchDumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(self.boxButton.x - ScaleW(40), 0, ScaleW(40), ScaleW(40))];
        [_branchDumplicationButton setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
        _branchDumplicationButton.centerY = self.branchLabel.centerY;
        [_branchDumplicationButton addTarget:self action:@selector(dumplicationEvent:) forControlEvents:UIControlEventTouchUpInside];
        _branchDumplicationButton.hidden = YES;
    }
    return _branchDumplicationButton;
}

-(UIButton *)nameDumplicationButton
{
    if (nil == _nameDumplicationButton) {
        _nameDumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(self.boxButton.x - ScaleW(40), 0, ScaleW(40), ScaleW(40))];
        [_nameDumplicationButton setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
        _nameDumplicationButton.centerY = self.nameLabel.centerY;
        [_nameDumplicationButton addTarget:self action:@selector(dumplicationEvent:) forControlEvents:UIControlEventTouchUpInside];
        _nameDumplicationButton.hidden = YES;
    }
    return _nameDumplicationButton;
}


-(void)setSelected:(BOOL)selected
{
    self.boxButton.selected = selected;
}

-(void)setPayModel:(HeBi_PayMethod_Index_Model *)payModel
{
    payModel.name = [payModel.name stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    _payModel = payModel;
    if (payModel == nil) {
         self.qrCodeButton.hidden = YES;
        return;
    }
    if ([payModel.type isEqualToString:@"wx"]) {
        self.imageView.image = [UIImage imageNamed:@"wechatPayWay"];
        self.label.text = payModel.number;
    }else if ([payModel.type isEqualToString:@"alipay"]){
        self.imageView.image = [UIImage imageNamed:@"alpay_payways"];
        self.label.text = payModel.number;
    }else if ([payModel.type isEqualToString:@"backcard"]){
        self.imageView.image = [UIImage imageNamed:@"bankCard"];
        self.label.text = [NSString stringWithFormat:@"%@ %@",SSKJLocalized(@"银行卡卡号", nil),payModel.number];
        self.bankNameLabel.text = payModel.bank;
        self.branchLabel.text = payModel.branch;
        self.nameLabel.text = payModel.name;

        self.numberDumplicationButton.hidden = NO;
        self.bankDumplicationButton.hidden = NO;
        self.branchDumplicationButton.hidden = NO;
        self.nameDumplicationButton.hidden = NO;
        self.qrCodeButton.hidden = YES;

//        CGFloat height = [self.label.text boundingRectWithSize:CGSizeMake(ScreenWidth - self.label.left, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label.font} context:nil].size.height;
//        self.label.height = height;
        self.height = self.nameLabel.bottom + ScaleW(5);
    }
    
    CGFloat width = [WLTools getWidthWithText:self.label.text font:self.label.font];
    self.label.width = width;
    self.qrCodeButton.x = self.label.right + ScaleW(15);
    
}

-(void)boxEvent
{
    if (self.selectBlock) {
        self.selectBlock(self.boxButton.selected);
    }
}

-(void)showQRCodeEvent
{
    if (self.showQRcodeBlock) {
        self.showQRcodeBlock(self.payModel);
    }
}


-(void)dumplicationEvent:(UIButton *)sender
{
    if ([self.payModel.type isEqualToString:@"backcard"]) {
        
        NSString *string;
        if (sender == self.numberDumplicationButton) {
            string = self.payModel.number;
        }else if (sender == self.bankDumplicationButton) {
            string = self.payModel.bank;
        }else if (sender == self.branchDumplicationButton) {
            string = self.payModel.branch;
        }else if (sender == self.nameDumplicationButton) {
            string = self.payModel.name;
        }

        if (string.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"复制失败", nil)];
            return;
        }
        
        [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = string;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
