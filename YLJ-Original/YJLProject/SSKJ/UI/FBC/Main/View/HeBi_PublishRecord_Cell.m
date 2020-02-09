//
//  HeBi_PublishRecord_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_PublishRecord_Cell.h"

@interface HeBi_PublishRecord_Cell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *priceTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *minTitleLabel;
@property (nonatomic, strong) UILabel *minLabel;

@property (nonatomic, strong) UILabel *amountTitleLabel;
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UILabel *maxTitleLabel;
@property (nonatomic, strong) UILabel *maxLabel;

@property (nonatomic, strong) UILabel *totalTitleLabel;
@property (nonatomic, strong) UILabel *totalLabel;

@property (nonatomic, strong) UILabel *payTitleLabel;

@property (nonatomic, strong) UIView *payMethodView;

@property (nonatomic, strong) UIImageView *aliImageView;
@property (nonatomic, strong) UIImageView *bankImageView;
@property (nonatomic, strong) UIImageView *wxImageView;

//charge
@property (nonatomic, strong) UILabel *chargeTitleLabel;
@property (nonatomic, strong) UILabel *chargeLabel;

@end

@implementation HeBi_PublishRecord_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kMainWihteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.cancleButton];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.lineView];
    
    [self addLabels];
    
    [self.payMethodView addSubview:self.aliImageView];
    [self.payMethodView addSubview:self.bankImageView];
    [self.payMethodView addSubview:self.wxImageView];
}

- (UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"创建时间：2019-06-07 15:15" font:systemFont(ScaleW(13)) textColor: kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(18), ScaleW(300), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _timeLabel;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(55), 0, ScaleW(55), ScaleW(24))];
        _cancleButton.centerY = self.timeLabel.centerY;
        _cancleButton.layer.borderColor = kTextLightBlueColor.CGColor;
        _cancleButton.layer.borderWidth = 1.0f;
        _cancleButton.layer.cornerRadius = _cancleButton.height / 2;
        [_cancleButton setTitle:SSKJLocalized(@"撤单", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(12.5));
        
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [WLTools allocLabel:SSKJLocalized(@"已撤销", nil) font:systemFont(ScaleW(12.5)) textColor:kTextGrayBlueColor frame:self.cancleButton.frame textAlignment:NSTextAlignmentCenter];
    }
    return _statusLabel;
    
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView =[[UIView  alloc]initWithFrame:CGRectMake(ScaleW(15), self.cancleButton.bottom + ScaleW(10), ScreenWidth - ScaleW(30), 0.5)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
    
}

-(void)addLabels
{
    
    for (int i = 0; i < 6; i++) {
        
        NSInteger line = i % 2;
        NSInteger row = i / 2;
        
        CGFloat startY = ScaleW(25) + self.lineView.bottom;
        
        UILabel *titleLabel = [WLTools allocLabel:@"" font:systemThinFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(ScreenWidth / 2 * line + ScaleW(15),startY + row * ScaleW(27), ScaleW(65), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
        
        UILabel *valueLabel = [WLTools allocLabel:@"" font:systemThinFont(ScaleW(13)) textColor: kSubTitleColor frame:CGRectMake(titleLabel.right, titleLabel.y, ScreenWidth / 2 - titleLabel.width - ScaleW(15), titleLabel.height) textAlignment:NSTextAlignmentLeft];
        
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:valueLabel];
        
        switch (i) {
            case 0:
                {
                    self.priceTitleLabel = titleLabel;
                    self.priceLabel = valueLabel;
                }
                break;
            case 1:
            {
                self.minTitleLabel = titleLabel;
                self.minLabel = valueLabel;
                titleLabel.text = SSKJLocalized(@"最小限额:", nil);
            }
                break;
            case 2:
            {
                self.amountTitleLabel = titleLabel;
                self.amountLabel = valueLabel;
            }
                break;
            case 3:
            {
                self.maxTitleLabel = titleLabel;
                self.maxLabel = valueLabel;
                titleLabel.text = SSKJLocalized(@"最大限额:", nil);

            }
                break;
            case 4:
            {
                self.totalTitleLabel = titleLabel;
                self.totalLabel = valueLabel;
            }
                break;
                
            case 5:
            {
                self.chargeTitleLabel = titleLabel;
                titleLabel.text = SSKJLocalized(@"手续费:", nil);
                self.chargeLabel = valueLabel;
            }
                break;
              
            default:
                break;
        }
        
    }
}


-(void)setCellWithPublishType:(PublishType)publishType
{
    if (publishType == PublishTypeBuy) {
        self.priceTitleLabel.text = SSKJLocalized(@"购买价格:", nil);
        self.amountTitleLabel.text = SSKJLocalized(@"购买数量:", nil);
        self.totalTitleLabel.text = SSKJLocalized(@"购买总价:", nil);
        
        self.chargeLabel.hidden = YES;
        self.chargeTitleLabel.hidden = YES;
    }else{
        self.priceTitleLabel.text = SSKJLocalized(@"出售价格:", nil);
        self.amountTitleLabel.text = SSKJLocalized(@"出售数量:", nil);
        self.totalTitleLabel.text = SSKJLocalized(@"出售总价:", nil);
        
        self.chargeLabel.hidden = NO;
        self.chargeTitleLabel.hidden = NO;
    }
}


-(void)cancleEvent
{
    if (self.cancleBlock) {
        self.cancleBlock();
    }
}


-(UIImageView *)aliImageView
{
    if (nil == _aliImageView) {
        _aliImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(15), ScaleW(15))];
        _aliImageView.image = [UIImage imageNamed:@"alpay_payways"];
    }
    return _aliImageView;
}

-(UIImageView *)bankImageView
{
    if (nil == _bankImageView) {
        _bankImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.aliImageView.right + ScaleW(8), 0, ScaleW(15), ScaleW(15))];
        _bankImageView.image = [UIImage imageNamed:@"bankCard"];
    }
    return _bankImageView;
}

-(UIImageView *)wxImageView
{
    if (nil == _wxImageView) {
        _wxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bankImageView.right + ScaleW(8), 0, ScaleW(15), ScaleW(15))];
        _wxImageView.image = [UIImage imageNamed:@"wechatPayWay"];
    }
    return _wxImageView;
}

-(void)setCellWithModel:(HeBi_FB_PublishRecord_Index_Model *)model
{
    self.timeLabel.text = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"创建时间", nil),[WLTools convertTimestamp:model.add_time.doubleValue andFormat:@"yyyy-MM-dd HH:mm:ss"]];
    
    
    if (model.status.integerValue == 3) {       // 已撤单
        self.statusLabel.hidden = NO;
        self.cancleButton.hidden = YES;
        self.statusLabel.text = SSKJLocalized(@"已撤销", nil);
        self.statusLabel.textColor = kTextDarkBlueColor;
    }else if (model.status.integerValue == 2) {       // 已完成
        self.statusLabel.hidden = NO;
        self.cancleButton.hidden = YES;
        self.statusLabel.text = SSKJLocalized(@"已完成", nil);
        self.statusLabel.textColor =  kMainTextColor;
    }else if (model.status.integerValue == 1) {     // 进行中
        self.statusLabel.hidden = YES;
        self.cancleButton.hidden = NO;
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@ETH",[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:4]];
    self.minLabel.text = [NSString stringWithFormat:@"%@ETH",[WLTools noroundingStringWith:model.min_price.doubleValue afterPointNumber:4]];
    self.maxLabel.text = [NSString stringWithFormat:@"%@ETH",[WLTools noroundingStringWith:model.max_price.doubleValue afterPointNumber:4]];
    self.amountLabel.text = [NSString stringWithFormat:@"%@ ISCM",[WLTools noroundingStringWith:model.trans_num.doubleValue afterPointNumber:0]];
    
    self.totalLabel.text = [NSString stringWithFormat:@"%@ETH",[WLTools noroundingStringWith:model.totalprice.doubleValue afterPointNumber:4]];
    self.chargeLabel.text = [NSString stringWithFormat:@"%@ETH",[WLTools noroundingStringWith:model.deals_sxfee.doubleValue afterPointNumber:4]];
    
    self.aliImageView.hidden = !model.pay_alipay.boolValue;
    self.bankImageView.hidden = !model.pay_backcard.boolValue;
    self.wxImageView.hidden = !model.pay_wx.boolValue;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
