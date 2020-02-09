//
//  HeBi_TiBi_Record_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_TiBi_Record_Cell.h"

@interface HeBi_TiBi_Record_Cell ()
@property (nonatomic, strong) UILabel *addressTitleLabel;    // 地址
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *amountTitleLabel;    // 数量
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UILabel *submitTimeTitleLabel;    // 提交时间
@property (nonatomic, strong) UILabel *submitTimeLabel;       // 时间

@property (nonatomic, strong) UILabel *checkTimeTitleLabel;    // 审核时间
@property (nonatomic, strong) UILabel *checkTimeLabel;       // 时间

@property (nonatomic, strong) UIButton *cancleButton;   // 撤销按钮
@property (nonatomic, strong) UILabel *statusLabel; // 状态

@property (nonatomic, strong) UIView *failView;
@property (nonatomic, strong) UIImageView *failImageView;
@property (nonatomic, strong) UILabel *failReasonLabel; // 失败原因label

@end

@implementation HeBi_TiBi_Record_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kSubBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

#pragma mark - UI

-(void)setUI
{
    [self.contentView addSubview:self.addressTitleLabel];
    [self.contentView addSubview:self.addressLabel];
    
    [self.contentView addSubview:self.amountTitleLabel];
    [self.contentView addSubview:self.amountLabel];
    
    [self.contentView addSubview:self.submitTimeTitleLabel];
    [self.contentView addSubview:self.submitTimeLabel];
    
    [self.contentView addSubview:self.checkTimeTitleLabel];
    [self.contentView addSubview:self.checkTimeLabel];
    
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.cancleButton];
    
    [self.contentView addSubview:self.failView];
    [self.failView addSubview:self.failImageView];
    [self.failView addSubview:self.failReasonLabel];
}

-(UILabel *)addressTitleLabel
{
    if (nil == _addressTitleLabel) {
        _addressTitleLabel = [WLTools allocLabel:SSKJLocalized(@"充币地址", nil) font:systemThinFont(ScaleW(13.5)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(18), ScaleW(70), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _addressTitleLabel;
}

-(UILabel *)addressLabel
{
    if (nil == _addressLabel) {
        _addressLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemThinFont(ScaleW(13.5)) textColor:kTextColor5b5e95 frame:CGRectMake(self.addressTitleLabel.right, ScaleW(22), ScreenWidth - ScaleW(15) - ScaleW(65) - self.addressTitleLabel.right, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _addressLabel;
}

-(UILabel *)amountTitleLabel
{
    if (nil == _amountTitleLabel) {
        _amountTitleLabel = [WLTools allocLabel:SSKJLocalized(@"充币数量", nil) font:systemThinFont(ScaleW(13.5)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.addressTitleLabel.bottom + ScaleW(13.5), ScaleW(70), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _amountTitleLabel;
}

-(UILabel *)amountLabel
{
    if (nil == _amountLabel) {
        _amountLabel = [WLTools allocLabel:SSKJLocalized(@"xxxx", nil) font:systemThinFont(ScaleW(13.5)) textColor:kTextColor5b5e95 frame:CGRectMake(self.amountTitleLabel.right,self.amountTitleLabel.y, ScreenWidth - self.amountTitleLabel.right - ScaleW(15), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _amountLabel;
}

-(UILabel *)submitTimeTitleLabel
{
    if (nil == _submitTimeTitleLabel) {
        _submitTimeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"提交时间", nil) font:systemThinFont(ScaleW(13.5)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.amountTitleLabel.bottom + ScaleW(13.5), ScaleW(70), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _submitTimeTitleLabel;
}

-(UILabel *)submitTimeLabel
{
    if (nil == _submitTimeLabel) {
        _submitTimeLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemThinFont(ScaleW(13.5)) textColor:kTextColor5b5e95 frame:CGRectMake(self.amountTitleLabel.right,self.submitTimeTitleLabel.y, ScreenWidth - self.amountTitleLabel.right - ScaleW(15), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _submitTimeLabel;
}


-(UILabel *)checkTimeTitleLabel
{
    if (nil == _checkTimeTitleLabel) {
        _checkTimeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"审核时间", nil) font:systemThinFont(ScaleW(13.5)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), self.submitTimeTitleLabel.bottom + ScaleW(13.5), ScaleW(70), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _checkTimeTitleLabel;
}

-(UILabel *)checkTimeLabel
{
    if (nil == _checkTimeLabel) {
        _checkTimeLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemThinFont(ScaleW(13.5)) textColor:kTextColor5b5e95 frame:CGRectMake(self.amountTitleLabel.right,self.checkTimeTitleLabel.y, ScreenWidth  - self.amountTitleLabel.right- ScaleW(15), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _checkTimeLabel;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(60), 0, ScaleW(60), ScaleW(30))];
        _cancleButton.centerY = self.addressLabel.centerY;
        _cancleButton.layer.masksToBounds = YES;
        _cancleButton.layer.cornerRadius = _cancleButton.height / 2;
        _cancleButton.layer.borderColor = [UIColor colorWithHexStringToColor:@"878ff5"].CGColor;
        _cancleButton.layer.borderWidth = 0.5;
        _cancleButton.titleLabel.font = systemThinFont(ScaleW(14));
        [_cancleButton setTitle:@"撤销" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor colorWithHexStringToColor:@"878ff5"] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}
-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [WLTools allocLabel:@"已到账" font:systemThinFont(ScaleW(13)) textColor:[UIColor colorWithHexStringToColor:@"8087e8"] frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(65), 0, ScaleW(65), ScaleW(20)) textAlignment:NSTextAlignmentRight];
        _statusLabel.centerY = self.checkTimeTitleLabel.centerY;
    }
    return _statusLabel;
}


-(UIView *)failView
{
    if (nil == _failView) {
        _failView = [[UIView alloc]initWithFrame:CGRectMake(0, self.checkTimeTitleLabel.bottom + ScaleW(13.5), ScreenWidth, ScaleW(20))];
    }
    return _failView;
}
-(UIImageView *)failImageView
{
    if (nil == _failImageView) {
        _failImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(15), ScaleW(15))];
        _failImageView.centerY = self.failView.height / 2;
        _failImageView.image = [UIImage imageNamed:@"icon_fail"];
//        _failImageView.backgroundColor = [UIColor redColor];
    }
    return _failImageView;
}

-(UILabel *)failReasonLabel
{
    if (nil == _failReasonLabel) {
        _failReasonLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemThinFont(ScaleW(13.5)) textColor:[UIColor colorWithHexStringToColor:@"a5a9d8"] frame:CGRectMake(self.failImageView.right + ScaleW(5),self.checkTimeTitleLabel.y, ScreenWidth  - self.failImageView.right- ScaleW(20), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _failReasonLabel.centerY = self.failImageView.centerY;
    }
    return _failReasonLabel;
}

-(void)setCellWithDealType:(DealType)dealType model:(HeBi_TiBiRecord_Index_Model *)model
{
    if (dealType == DealTypeChongbi) {
        self.addressTitleLabel.text = SSKJLocalized(@"充币地址", nil);
        self.amountTitleLabel.text = SSKJLocalized(@"充币数量", nil);
        self.cancleButton.hidden = YES;
    }else{
        self.addressTitleLabel.text = SSKJLocalized(@"提币地址", nil);
        self.amountTitleLabel.text = SSKJLocalized(@"提币数量", nil);
    }
    
    self.addressLabel.text = model.qianbao_url;
    self.amountLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:2],model.pname?:@""];
    
    if (model.addtime) {
        self.submitTimeLabel.text = model.addtime?:@"";
    }else{
        self.submitTimeLabel.text = @"--";
    }
    if (model.check_time) {
        self.checkTimeLabel.text = model.check_time?:@"";
    }else{
        self.checkTimeLabel.text = @"--";
    }

    NSInteger status = model.state.integerValue;
    NSString *statusString;
    UIColor *color = kMainTextColor;
    self.failView.hidden = YES;
    switch (status) {
        case 1:
        {
            if (dealType == DealTypeTibi) {
                self.statusLabel.hidden = NO;
                self.cancleButton.hidden = NO;
                statusString = SSKJLocalized(@"待审核", nil);
            }else{
                self.statusLabel.hidden = NO;
                self.cancleButton.hidden = YES;
                statusString = SSKJLocalized(@"未支付", nil);
            }
            
            
            self.statusLabel.textColor = [UIColor colorWithHexStringToColor:@"8087e8"];
            self.checkTimeLabel.text = @"--";
        }
            break;
        case 2:
        {
            self.statusLabel.hidden = NO;
            self.cancleButton.hidden = YES;
            if (dealType == DealTypeTibi) {
                statusString = SSKJLocalized(@"到账中", nil);
            }else{
                statusString = SSKJLocalized(@"已支付", nil);
            }
            self.statusLabel.textColor = [UIColor colorWithHexStringToColor:@"8087e8"];
        }
            break;
        case 3:
        {
            self.statusLabel.hidden = NO;
            self.cancleButton.hidden = YES;
            self.failView.hidden = NO;
            statusString = SSKJLocalized(@"已拒绝", nil);
            color = RED_HEX_COLOR;
            self.statusLabel.textColor = [UIColor colorWithHexStringToColor:@"ff484d"];
            
        }
            break;
        case 4:
        {
            self.statusLabel.hidden = NO;
            self.cancleButton.hidden = YES;
            statusString = SSKJLocalized(@"已到账", nil);
            self.statusLabel.textColor = [UIColor colorWithHexStringToColor:@"8087e8"];
            self.checkTimeLabel.text = @"--";
        }
            break;
        case 5:
        {
            self.statusLabel.hidden = NO;
            self.cancleButton.hidden = YES;
            statusString = SSKJLocalized(@"已撤销", nil);
            self.statusLabel.textColor = [UIColor colorWithHexStringToColor:@"ff484d"];
            self.checkTimeLabel.text = @"--";
        }
            break;
            
        default:
            break;
    }
    self.statusLabel.text = statusString;
}

-(void)cancleEvent
{
    if (self.cancleBlock) {
        self.cancleBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
