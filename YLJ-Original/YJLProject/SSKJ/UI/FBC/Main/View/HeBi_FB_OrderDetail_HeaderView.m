//
//  HeBi_FB_OrderDetail_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_FB_OrderDetail_HeaderView.h"
#import "FDLabelView.h"

@interface HeBi_FB_OrderDetail_HeaderView ()
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *orderNumberTitleLabel;
@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *priceTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *ammountTitleLabel;
@property (nonatomic, strong) UILabel *ammountLabel;

@property (nonatomic, strong) UILabel *totalMoneyTitleLabel;
@property (nonatomic, strong) UILabel *totalMoneyLabel;

@property (nonatomic, strong) FDLabelView *phoneTitleLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UIButton *dumplicationButton; // 复制按钮

@property (nonatomic, strong) UILabel *beizhu;

@property (nonatomic, strong) UILabel *beizhuLabel;



@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bottomlineView;

@property (nonatomic, strong) UILabel *sellLabel;
@property (nonatomic, strong) UILabel *sellInfoLabel;


@property(nonatomic, strong)HeBi_FB_OrderDetail_Model *model;

@property(nonatomic, strong)NSTimer *timer;
@end


@implementation HeBi_FB_OrderDetail_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainWihteColor;
        [self setUI];
    }
    return self;
}

#pragma mark - UI

-(void)setUI
{
    [self addSubview:self.infoLabel];
    [self addSubview:self.orderNumberTitleLabel];
    [self addSubview:self.statusLabel];
    [self addSubview:self.orderNumberLabel];
    [self addSubview:self.priceTitleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.ammountTitleLabel];
    [self addSubview:self.ammountLabel];
    [self addSubview:self.totalMoneyTitleLabel];
    [self addSubview:self.totalMoneyLabel];
//    [self addSubview:self.phoneTitleLabel];
//    [self addSubview:self.phoneLabel];
//    [self addSubview:self.dumplicationButton];
    [self addSubview:self.beizhu];
    [self addSubview:self.beizhuLabel];

    [self addSubview:self.lineView];
    
    [self setupSellView];
    
}

- (void)setupSellView{
    
    self.sellLabel = [WLTools allocLabel:@"买家信息" font:systemFont(ScaleW(15)) textColor: kTitleColor frame:CGRectMake(ScaleW(30), self.lineView.bottom + 25, ScreenWidth - ScaleW(60), ScaleW(16)) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.sellLabel];
    
    self.sellInfoLabel = [WLTools allocLabel:@"买家信息" font:systemFont(ScaleW(14)) textColor: kSubTitleColor frame:CGRectMake(ScaleW(30), self.sellLabel.bottom + 10, ScreenWidth - ScaleW(90), ScaleW(16)) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.sellInfoLabel];
    
    _dumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(60), 0, ScaleW(60), ScaleW(40))];
    _dumplicationButton.centerY = self.sellInfoLabel.centerY;
    [_dumplicationButton setImage:[UIImage imageNamed:@"otc_copy"] forState:UIControlStateNormal];
    [_dumplicationButton addTarget:self action:@selector(dumplicationEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_dumplicationButton];
    
    _bottomlineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.sellInfoLabel.bottom + ScaleW(20), ScreenWidth - ScaleW(30), 0.5)];
    _bottomlineView.backgroundColor = kLineGrayColor;
    [self addSubview:_bottomlineView];

    
    self.detailLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor: kTitleColor frame:CGRectMake(ScaleW(15), self.bottomlineView.bottom + 20, ScreenWidth - ScaleW(30), ScaleW(16)) textAlignment:NSTextAlignmentLeft];
    [self addSubview:self.detailLabel];
    

    self.height = self.detailLabel.bottom + 30;

}


-(UILabel *)infoLabel
{
    if (nil == _infoLabel) {
        _infoLabel = [WLTools allocLabel:@"您向刘*雨 购买2.0000 AB" font:systemFont(ScaleW(21)) textColor: kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(41), ScreenWidth - ScaleW(30), ScaleW(21)) textAlignment:NSTextAlignmentLeft];
    }
    return _infoLabel;
}

-(UILabel *)orderNumberTitleLabel
{
    if (nil == _orderNumberTitleLabel) {
        _orderNumberTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), self.infoLabel.bottom + ScaleW(34), ScaleW(44), ScaleW(15))];
        _orderNumberTitleLabel.font = systemFont(ScaleW(14));
        _orderNumberTitleLabel.textColor = kTitleColor;
        _orderNumberTitleLabel.text = SSKJLocalized(@"订单号", nil);

    }
    return _orderNumberTitleLabel;
}

-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [WLTools allocLabel:@"待付款" font:systemBoldFont(ScaleW(14)) textColor:kTextLightBlueColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(100), self.orderNumberTitleLabel.y, ScaleW(100), ScaleW(14)) textAlignment:NSTextAlignmentRight];
    }
    return _statusLabel;
}

-(UILabel *)orderNumberLabel
{
    if (nil == _orderNumberLabel) {
        _orderNumberLabel = [WLTools allocLabel:@"xxx" font:systemFont(ScaleW(14)) textColor: kSubTitleColor frame:CGRectMake(self.orderNumberTitleLabel.right + ScaleW(20), self.orderNumberTitleLabel.y, self.statusLabel.x - self.orderNumberTitleLabel.right - ScaleW(20), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _orderNumberLabel;
}


-(UILabel *)priceTitleLabel
{
    if (nil == _priceTitleLabel) {
        _priceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), self.orderNumberTitleLabel.bottom + ScaleW(16), self.orderNumberTitleLabel.width, ScaleW(15))];
        _priceTitleLabel.font = systemFont(ScaleW(14));
        _priceTitleLabel.textColor = kTitleColor;
        _priceTitleLabel.text = SSKJLocalized(@"买入价", nil);
        
    }
    return _priceTitleLabel;
}


-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor: kSubTitleColor frame:CGRectMake(_orderNumberLabel.x, self.priceTitleLabel.y, self.orderNumberLabel.width, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _priceLabel;
}

-(UILabel *)ammountTitleLabel
{
    if (nil == _ammountTitleLabel) {
        _ammountTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), self.priceTitleLabel.bottom + ScaleW(16), self.orderNumberTitleLabel.width, ScaleW(15))];
        _ammountTitleLabel.font = systemFont(ScaleW(14));
        _ammountTitleLabel.textColor = kTitleColor;
        _ammountTitleLabel.text = SSKJLocalized(@"数量", nil);
        
    }
    return _ammountTitleLabel;
}


-(UILabel *)ammountLabel
{
    if (nil == _ammountLabel) {
        _ammountLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor: kSubTitleColor frame:CGRectMake(_orderNumberLabel.x, self.ammountTitleLabel.y, self.priceLabel.width, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _ammountLabel;
}

-(UILabel *)totalMoneyTitleLabel
{
    if (nil == _totalMoneyTitleLabel) {
        _totalMoneyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), self.ammountTitleLabel.bottom + ScaleW(16), self.orderNumberTitleLabel.width, ScaleW(15))];
        _totalMoneyTitleLabel.font = systemFont(ScaleW(14));
        _totalMoneyTitleLabel.textColor = kTitleColor;
        _totalMoneyTitleLabel.text = SSKJLocalized(@"总金额", nil);
        
    }
    return _totalMoneyTitleLabel;
}


-(UILabel *)totalMoneyLabel
{
    if (nil == _totalMoneyLabel) {
        _totalMoneyLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor: kSubTitleColor frame:CGRectMake(_orderNumberLabel.x, self.totalMoneyTitleLabel.y, self.priceLabel.width, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _totalMoneyLabel;
}


-(FDLabelView *)phoneTitleLabel
{
    if (nil == _phoneTitleLabel) {
        
        _phoneTitleLabel = [[FDLabelView alloc]initWithFrame:CGRectMake(ScaleW(15), self.totalMoneyTitleLabel.bottom + ScaleW(16), ScaleW(90), ScaleW(15))];
        _phoneTitleLabel.font = systemFont(ScaleW(13.5));
        _phoneTitleLabel.textColor = kTextDarkBlueColor;
        _phoneTitleLabel.text = SSKJLocalized(@"", nil);
        _phoneTitleLabel.fdTextAlignment = FDTextAlignmentFill;
        _phoneTitleLabel.fixedLineHeight = 0.00;
        _phoneTitleLabel.fdLineScaleBaseLine = FDLineHeightScaleBaseLineTop;
        _phoneTitleLabel.fdTextAlignment = FDTextAlignmentFill;
        _phoneTitleLabel.fdAutoFitMode = FDAutoFitModeAutoHeight;
    }
    return _phoneTitleLabel;
}


-(UILabel *)phoneLabel
{
    if (nil == _phoneLabel) {
        _phoneLabel = [WLTools allocLabel:@"" font:systemThinFont(ScaleW(15)) textColor: kMainTextColor frame:CGRectMake(self.phoneTitleLabel.right + ScaleW(20), self.phoneTitleLabel.y, self.priceLabel.width, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _phoneLabel;
}


-(UIButton *)dumplicationButton
{
    if (nil == _dumplicationButton) {
        _dumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(60), 0, ScaleW(60), ScaleW(40))];
        _dumplicationButton.centerY = self.phoneLabel.centerY;
        [_dumplicationButton setImage:[UIImage imageNamed:@"otc_copy"] forState:UIControlStateNormal];
        [_dumplicationButton addTarget:self action:@selector(dumplicationEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dumplicationButton;
}

-(UILabel *)beizhu
{
    if (nil == _beizhu) {
        
        _beizhu = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), self.totalMoneyLabel.bottom + ScaleW(16), ScaleW(90), ScaleW(15))];
        _beizhu.font = systemFont(ScaleW(14));
        _beizhu.textColor = kTitleColor;
        _beizhu.text = SSKJLocalized(@"备注", nil);
        
    }
    return _beizhu;
}


-(UILabel *)beizhuLabel
{
    if (nil == _beizhuLabel) {
        _beizhuLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor: kSubTitleColor frame:CGRectMake(_orderNumberLabel.x, self.beizhu.y, self.priceLabel.width, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _beizhuLabel;
}
-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.beizhuLabel.bottom + ScaleW(26), ScreenWidth - ScaleW(30), 0.5)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}


#pragma mark - 设置信息
-(void)setViewWithModel:(HeBi_FB_OrderDetail_Model *)model
{
    self.model = model;
    
    NSString *info;
    NSString *name = model.oop_name;
    
    if ([name isEqual:[NSNull null]] || name.length == 0) {
        name = model.oop_mobile;
    }
    
    if (model.type.integerValue == 1) {     // 出售者
        
        
        info = [NSString stringWithFormat:@"您向%@ 出售%@ ISCM",name,[WLTools noroundingStringWith:model.total_num.doubleValue afterPointNumber:4]];
        
        if ([[[SSKJLocalized sharedInstance]currentLanguage]containsString:@"en"]) {
            info = [NSString stringWithFormat:@"You sell%@ ISCM to%@",[WLTools noroundingStringWith:model.total_num.doubleValue afterPointNumber:4],name];
        }
        
        self.phoneTitleLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"买家", nil),SSKJLocalized(@"联系方式", nil)];
        
        self.sellLabel.text = @"买家信息";
        _priceTitleLabel.text = SSKJLocalized(@"出售价", nil);

        
    }else{                                  // 购买者
        info = [NSString stringWithFormat:@"您向%@ 购买%@ ISCM",name,[WLTools noroundingStringWith:model.total_num.doubleValue afterPointNumber:4]];
        if ([[[SSKJLocalized sharedInstance]currentLanguage]containsString:@"en"]) {
            info = [NSString stringWithFormat:@"You buy%@ ISCM from%@",[WLTools noroundingStringWith:model.total_num.doubleValue afterPointNumber:4],name];
        }
        self.phoneTitleLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"卖家", nil),SSKJLocalized(@"联系方式", nil)];
        
        self.sellLabel.text = @"卖家信息";
        _priceTitleLabel.text = SSKJLocalized(@"买入价", nil);

    }
    
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:info];
    
    if ([[[SSKJLocalized sharedInstance]currentLanguage]containsString:@"en"]) {
        if (model.type.integerValue == 1) {     // 出售者
            [attributeString addAttribute:NSForegroundColorAttributeName value:kTextLightBlueColor range:NSMakeRange(4 , 4)];

        }else{
            [attributeString addAttribute:NSForegroundColorAttributeName value:kTextLightBlueColor range:NSMakeRange(4, 3)];

        }

    }else{
        [attributeString addAttribute:NSForegroundColorAttributeName value:kTextLightBlueColor range:NSMakeRange(2 + name.length + 1, 2)];
    }
    
    self.infoLabel.attributedText = attributeString;
    
    self.orderNumberLabel.text = model.order_num;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ ETH",[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:4]];
    self.ammountLabel.text = [NSString stringWithFormat:@"%@ ISCM",model.total_num];
    self.totalMoneyLabel.text =  [NSString stringWithFormat:@"%@ ETH",[WLTools noroundingStringWith:model.total_price.doubleValue afterPointNumber:4]];

    NSString *statusString;
    NSInteger status = model.status.integerValue;
    if (model.type.integerValue == 1) {     // 出售者
        switch (status) {
            case 1:
                statusString = SSKJLocalized(@"等待对方付款", nil);
                
                self.detailLabel.text = @"等待对方付款";

                break;
            case 2:
                statusString = SSKJLocalized(@"已完成", nil);
                
                self.detailLabel.text = @"订单已完成";

//                statusString = SSKJLocalized(@"对方已付款", nil);
                break;
            case 3:
//                statusString = SSKJLocalized(@"已完成", nil);
                break;
            case 4:
//                statusString = SSKJLocalized(@"申诉中", nil);
                break;
            case 5:
                statusString = SSKJLocalized(@"已取消", nil);
                self.detailLabel.text = @"订单已取消";

                break;
                
            default:
                break;
        }
    }else{                  // 购买者
        switch (status) {
            case 1:
                statusString = SSKJLocalized(@"待付款", nil);
                
                self.detailLabel.text = @"待付款";

                break;
            case 2:
                statusString = SSKJLocalized(@"已完成", nil);

                self.detailLabel.text = @"订单已完成";

                break;
            case 3:
//                statusString = SSKJLocalized(@"已完成", nil);
                break;
            case 4:
//                statusString = SSKJLocalized(@"申诉中", nil);
                break;
            case 5:
                statusString = SSKJLocalized(@"已取消", nil);
                self.detailLabel.text = @"订单已取消";
                break;
                
            default:
                break;
        }
    }
    
    self.statusLabel.text = statusString;
    
    
    
    self.sellInfoLabel.text = [NSString stringWithFormat:@"%@ %@", model.oop_name, model.oop_mobile];
    
//    if (model.oop_name) {
//        self.phoneLabel.text = model.oop_mobile;
//    }else{
//        self.phoneLabel.text = model.oop_mail;
//    }
//
    self.beizhuLabel.text = model.notes;
    
//    self.height = self.beizhuLabel.bottom;
    self.lineView.y = self.beizhuLabel.bottom + ScaleW(26);
    self.sellLabel.y = self.lineView.bottom + 25;
    self.sellInfoLabel.y = self.sellLabel.bottom + 10;
    _dumplicationButton.centerY = self.sellInfoLabel.centerY;
    _bottomlineView.y = self.sellInfoLabel.bottom + ScaleW(20);
    self.detailLabel.y = self.bottomlineView.bottom + 20;
    
    self.height = self.detailLabel.bottom + 30;

}

-(void)dumplicationEvent
{
    if (self.model.oop_mobile.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"复制失败", nil)];
        return;
    }
    
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string=self.model.oop_mobile;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
