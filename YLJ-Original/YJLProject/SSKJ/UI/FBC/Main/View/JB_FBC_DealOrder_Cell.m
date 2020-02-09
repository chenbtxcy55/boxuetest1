//
//  JB_FBC_DealOrder_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_FBC_DealOrder_Cell.h"

@interface JB_FBC_DealOrder_Cell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *orderNumberLabel;    // 订单号
@property (nonatomic, strong) UILabel *timeLabel;   // 时间
@property (nonatomic, strong) UILabel *statusLabel; // 状态
@property (nonatomic, strong) UILabel *priceTitleLabel; // 单价
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *typeTitleLabel; // 类型
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *amountTitleLabel; // 数量
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *totalPriceTitleLabel; // 总额
@property (nonatomic, strong) UILabel *totalPriceLabel;

@property (nonatomic, strong) UILabel *limitTitleLabel; // 限额
@property (nonatomic, strong) UILabel *limitLabel;

@property (nonatomic, strong) UIImageView *enterImageView;

@end


@implementation JB_FBC_DealOrder_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}




#pragma mark - UI

-(void)setUI
{
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.orderNumberLabel];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.statusLabel];
    
    [self.backView addSubview:self.priceTitleLabel];
    [self.backView addSubview:self.priceLabel];
    
    [self.backView addSubview:self.typeTitleLabel];
    [self.backView addSubview:self.typeLabel];
    
    [self.backView addSubview:self.amountTitleLabel];
    [self.backView addSubview:self.amountLabel];
    
    [self.backView addSubview:self.totalPriceTitleLabel];
    [self.backView addSubview:self.totalPriceLabel];
    
//    [self.backView addSubview:self.limitTitleLabel];
//    [self.backView addSubview:self.limitLabel];
    
//    [self.backView addSubview:self.enterImageView];

}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(110))];
//        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = ScaleW(8);
        _backView.backgroundColor = kMainWihteColor;
        [_backView setShadowView:_backView];

    }
    return _backView;
}

- (UILabel *)orderNumberLabel
{
    if (nil == _orderNumberLabel) {
        _orderNumberLabel = [WLTools allocLabel:@"订单号：312412" font:systemBoldFont(ScaleW(14)) textColor: kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(100), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _orderNumberLabel;
}

- (UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"2019-09-09 09:09" font:systemFont(ScaleW(12)) textColor:kGrayTitleColor frame:CGRectMake(self.orderNumberLabel.right + ScaleW(10), ScaleW(15), ScaleW(100), ScaleW(11)) textAlignment:NSTextAlignmentLeft];
        _timeLabel.bottom = self.orderNumberLabel.bottom;
        _timeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLabel;
}

-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [WLTools allocLabel:@"待付款" font:systemFont(ScaleW(14)) textColor:kMainBlueColor frame:CGRectMake(self.backView.width - ScaleW(15) - ScaleW(100), ScaleW(13), ScaleW(100), ScaleW(15)) textAlignment:NSTextAlignmentRight];
        _statusLabel.centerY = self.orderNumberLabel.centerY;
    }
    return _statusLabel;
}

-(UILabel *)priceTitleLabel
{
    if (nil == _priceTitleLabel) {
        
        NSString *title = SSKJLocalized(@"单价", nil);
        
        _priceTitleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.orderNumberLabel.x, self.orderNumberLabel.bottom + ScaleW(18), 0, ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        CGFloat width = [WLTools getWidthWithText:title font:_priceTitleLabel.font];
        _priceTitleLabel.width = width;
    }
    return _priceTitleLabel;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:@"3.23 ISCM" font:systemFont(ScaleW(12)) textColor: kSubTitleColor frame:CGRectMake(self.priceTitleLabel.right + ScaleW(9), 0, ScaleW(200), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        _priceLabel.centerY = self.priceTitleLabel.centerY;
    }
    return _priceLabel;
}


-(UILabel *)typeTitleLabel
{
    if (nil == _typeTitleLabel) {
        
        NSString *title = SSKJLocalized(@"类型", nil);
        
        _typeTitleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.backView.width / 2 + ScaleW(5), self.priceLabel.y, 0, ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        CGFloat width = [WLTools getWidthWithText:title font:_priceTitleLabel.font];
        _typeTitleLabel.width = width;
    }
    return _typeTitleLabel;
}

-(UILabel *)typeLabel
{
    if (nil == _typeLabel) {
        _typeLabel = [WLTools allocLabel:@"出售" font:systemFont(ScaleW(12)) textColor: kSubTitleColor frame:CGRectMake(self.typeTitleLabel.right + ScaleW(9), 0, ScaleW(200), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        _typeLabel.centerY = self.priceTitleLabel.centerY;
    }
    return _typeLabel;
}


-(UILabel *)amountTitleLabel
{
    if (nil == _amountTitleLabel) {
        
        NSString *title = SSKJLocalized(@"数量", nil);
        
        _amountTitleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.orderNumberLabel.x, self.priceTitleLabel.bottom + ScaleW(11), 0, ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        CGFloat width = [WLTools getWidthWithText:title font:_priceTitleLabel.font];
        _amountTitleLabel.width = width;
    }
    return _amountTitleLabel;
}

-(UILabel *)amountLabel
{
    if (nil == _amountLabel) {
        _amountLabel = [WLTools allocLabel:@"3.23 ISCM" font:systemFont(ScaleW(12)) textColor: kSubTitleColor frame:CGRectMake(self.priceTitleLabel.right + ScaleW(9), 0, ScaleW(200), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        _amountLabel.centerY = self.amountTitleLabel.centerY;
    }
    return _amountLabel;
}


-(UILabel *)totalPriceTitleLabel
{
    if (nil == _totalPriceTitleLabel) {
        
        NSString *title = SSKJLocalized(@"总额", nil);
        
        _totalPriceTitleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.typeTitleLabel.x, self.amountTitleLabel.y, 0, ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        CGFloat width = [WLTools getWidthWithText:title font:_priceTitleLabel.font];
        _totalPriceTitleLabel.width = width;
    }
    return _totalPriceTitleLabel;
}

-(UILabel *)totalPriceLabel
{
    if (nil == _totalPriceLabel) {
        _totalPriceLabel = [WLTools allocLabel:@"出售" font:systemFont(ScaleW(12)) textColor: kSubTitleColor frame:CGRectMake(self.typeTitleLabel.right + ScaleW(9), 0, ScaleW(200), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        _totalPriceLabel.centerY = self.totalPriceTitleLabel.centerY;
    }
    return _totalPriceLabel;
}



-(UILabel *)limitTitleLabel
{
    if (nil == _limitTitleLabel) {
        
        NSString *title = SSKJLocalized(@"限额", nil);
        
        _limitTitleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:kTextDarkBlueColor frame:CGRectMake(self.orderNumberLabel.x, self.amountTitleLabel.bottom + ScaleW(11), 0, ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        CGFloat width = [WLTools getWidthWithText:title font:_priceTitleLabel.font];
        _limitTitleLabel.width = width;
    }
    return _limitTitleLabel;
}

-(UILabel *)limitLabel
{
    if (nil == _limitLabel) {
        _limitLabel = [WLTools allocLabel:@"3.23 ISCM" font:systemFont(ScaleW(12)) textColor: kMainTextColor frame:CGRectMake(self.limitTitleLabel.right + ScaleW(9), 0, ScaleW(200), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        _limitLabel.centerY = self.limitTitleLabel.centerY;
    }
    return _limitLabel;
}

-(UIImageView *)enterImageView
{
    if (nil == _enterImageView) {
        _enterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.backView.width - ScaleW(15) - ScaleW(8), 0, ScaleW(8), ScaleW(15))];
        _enterImageView.image = [UIImage imageNamed:@"wd_icon_right"];
        _enterImageView.centerY = self.backView.height / 2;
    }
    return _enterImageView;
}


-(void)setCellWithModel:(JB_FBC_DealOrder_Model *)model
{
    self.orderNumberLabel.text = [NSString stringWithFormat:@"%@ %@",SSKJLocalized(@"订单号", nil),model.order_num];
    
    CGFloat width = [WLTools getWidthWithText:self.orderNumberLabel.text  font:self.orderNumberLabel.font];
    self.orderNumberLabel.width = width;
    self.timeLabel.x = self.orderNumberLabel.right + ScaleW(10);
    
    self.timeLabel.text = [WLTools convertTimestamp:[model.add_time doubleValue] andFormat:@"yyyy-MM-dd HH:mm"];
    
    
    NSString *type;
    UIColor *typeColor;
    BOOL isBuyer = model.type.integerValue == 1;    // 是否是购买者
    if (model.type.integerValue == 2) {
        type = SSKJLocalized(@"出售", nil);
        typeColor = kTextOrgleColor;
    }else{
        type = SSKJLocalized(@"购买", nil);
        typeColor = GREEN_HEX_COLOR;
    }
    self.typeLabel.text = type;
    self.typeLabel.textColor = typeColor;
    
    NSString *statusString = nil;
    UIColor *color;
    //状态  1待付款 2已付款 3已确认完成 4 申诉中 5已取消
    switch ([model.status integerValue]) {
        case 1:
        {
            if (isBuyer) {
                statusString = SSKJLocalized(@"待付款",nil);
                color = kTextOrgleColor;
            }else{
                statusString = SSKJLocalized(@"等待付款",nil);
                color = kTextLightBlueColor;
            }
            
        }
            break;
        case 2:
        {
            
            if (isBuyer) {
                statusString = SSKJLocalized(@"已完成",nil);
                color = kTextOrgleColor;
            }else{
                statusString = SSKJLocalized(@"已完成",nil);
                color = UIColorFromRGB(0xff3333);
            }

        }
            break;
        case 3:
        {
            statusString = SSKJLocalized(@"已完成",nil);
            color =  kMainTextColor;
        }
            break;
        case 4:
        {
            statusString = SSKJLocalized(@"申诉中",nil);
            color = UIColorFromRGB(0xff3333);

        }
            break;
        case 5:
        {
            statusString = SSKJLocalized(@"已取消",nil);
            color = kTextDarkBlueColor;

        }
            break;
        default:
            break;
    }
    
    self.statusLabel.text = statusString;
    self.statusLabel.textColor = color;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ETH",[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:4]];
    self.amountLabel.text = [NSString stringWithFormat:@"%@ISCM",model.total_num];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%@ETH",[WLTools noroundingStringWith:model.total_price.doubleValue afterPointNumber:4]];
    
//    self.limitLabel.text = [NSString stringWithFormat:@"%@-%@ISCM",[WLTools noroundingStringWith:model.min_price.doubleValue afterPointNumber:2],[WLTools noroundingStringWith:model.max_price.doubleValue afterPointNumber:2]];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
