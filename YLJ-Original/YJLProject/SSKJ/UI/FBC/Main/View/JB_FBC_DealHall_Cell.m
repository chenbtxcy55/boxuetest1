//
//  JB_FBC_DealHall_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_FBC_DealHall_Cell.h"
#import "JB_PayMethod_View.h"

@interface JB_FBC_DealHall_Cell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *headerView;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *percentLabel;    // 成交单数成交率
@property (nonatomic, strong) JB_PayMethod_View *payView;
@property (nonatomic, strong) UILabel *limiteLabel; // 限额
@property (nonatomic, strong) UILabel *totalPriceLabel; // 总价值
@property (nonatomic, strong) UILabel *numberLabe;;  // 数量
@property (nonatomic, strong) UILabel *buySellLabel;  // 去购买，去出售
@property (nonatomic, strong) JB_FBC_DealHall_OrderModel *model;
@end

@implementation JB_FBC_DealHall_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.backView];
        [self.backView addSubview:self.headerView];
        [self.headerView addSubview:self.headerLabel];
        [self.backView addSubview:self.nameLabel];
//        [self.backView addSubview:self.percentLabel];
        [self.backView addSubview:self.payView];
        [self.backView addSubview:self.limiteLabel];
        [self.backView addSubview:self.numberLabe];
        [self.backView addSubview:self.totalPriceLabel];
        [self.backView addSubview:self.buySellLabel];
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(140))];
        //_backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = ScaleW(8);
        _backView.backgroundColor = kMainWihteColor;
        [_backView setShadowView:_backView];
    }
    return _backView;
}

-(UILabel *)headerView
{
    if (nil == _headerView) {
        _headerView = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(22), ScaleW(22))];
//        _headerView.layer.masksToBounds = YES;
        _headerView.layer.cornerRadius = _headerView.height / 2;
        [_headerView label:_headerView font:ScaleW(20) textColor:kMainRedColor text:@""];
        //[_headerView addGradientColor];
        
        _headerView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _headerView.layer.shadowOffset = CGSizeMake(0, 0);
        _headerView.layer.shadowRadius = 4;
        _headerView.layer.shadowOpacity = 1;
        
//        [_headerView setShadowView:_headerView];
    }
    return _headerView;
}

-(UILabel *)headerLabel
{
    if (nil == _headerLabel) {
        _headerLabel = [WLTools allocLabel:@"B" font:systemFont(ScaleW(15)) textColor:kMainBlueColor frame:CGRectMake(0, 0, ScaleW(22), ScaleW(22)) textAlignment:NSTextAlignmentCenter];
        _headerLabel.backgroundColor = [UIColor whiteColor];
        _headerLabel.layer.masksToBounds = YES;
        _headerLabel.layer.cornerRadius = _headerLabel.height / 2;
        
    }
    return _headerLabel;
}

- (UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        _nameLabel = [WLTools allocLabel:@"小雨" font:systemBoldFont(ScaleW(16)) textColor:kTitleColor frame:CGRectMake(self.headerView.right + ScaleW(10), 0, ScaleW(100), ScaleW(16)) textAlignment:NSTextAlignmentLeft];
        _nameLabel.centerY = self.headerView.centerY;
    }
    return _nameLabel;
}

-(UILabel *)percentLabel
{
    if (nil == _percentLabel) {
        _percentLabel = [WLTools allocLabel:@"111 | 24%" font:systemFont(ScaleW(12)) textColor:kSubSubTxtColor frame:CGRectMake(self.nameLabel.right + ScaleW(10), 0, ScaleW(100), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
        _percentLabel.centerY = self.nameLabel.centerY;
    }
    return _percentLabel;
}

-(JB_PayMethod_View *)payView
{
    if (nil == _payView) {
        _payView = [[JB_PayMethod_View alloc]initWithFrame:CGRectMake(0, 0, ScaleW(100), ScaleW(30))];
    }
    return _payView;
}

- (UILabel *)limiteLabel
{
    
    if (nil == _limiteLabel) {
        _limiteLabel = [WLTools allocLabel:@"限额 1000。00-5000.00CNY" font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.nameLabel.x, self.headerView.bottom + ScaleW(15), ScaleW(200), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _limiteLabel;
}



- (UILabel *)numberLabe
{
    if (nil == _numberLabe) {
        _numberLabe = [WLTools allocLabel:@"数量 22.222222 AB" font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.nameLabel.x, self.limiteLabel.bottom + ScaleW(15), ScaleW(200), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _numberLabe;
}
- (UILabel *)totalPriceLabel
{
    if (nil == _totalPriceLabel) {
        _totalPriceLabel = [WLTools allocLabel:@"单价 600.00cny" font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.nameLabel.x, self.numberLabe.bottom + ScaleW(15), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _totalPriceLabel;
}
-(UILabel *)buySellLabel
{
    if (nil == _buySellLabel) {
        _buySellLabel = [WLTools allocLabel:SSKJLocalized(@"去购买", nil) font:systemFont(ScaleW(13)) textColor:[UIColor whiteColor] frame:CGRectMake(self.backView.width - ScaleW(15) - ScaleW(70), ScaleW(75), ScaleW(70), ScaleW(30)) textAlignment:NSTextAlignmentCenter];
        
        _buySellLabel.backgroundColor = kMainBlueColor;
        _buySellLabel.layer.cornerRadius = ScaleW(5);
        _buySellLabel.layer.masksToBounds = YES;
    }
    return _buySellLabel;
}

-(void)setCellWithModel:(JB_FBC_DealHall_OrderModel *)model buySellType:(BuySellType)buySellType
{
    self.model = model;
    CGFloat width = [WLTools getWidthWithText:model.realname font:self.nameLabel.font];
    self.nameLabel.width = width;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.realname];
//    self.percentLabel.text = [NSString stringWithFormat:@"%@|%@",model.cd_num,model.rate];
    
//    width = [WLTools getWidthWithText:self.percentLabel.text font:self.percentLabel.font];
//    self.percentLabel.x = self.nameLabel.right + ScaleW(10);
//    self.percentLabel.width = width;
    
    self.limiteLabel.text = [NSString stringWithFormat:@"%@  %@ETH",SSKJLocalized(@"限额", nil),model.quota];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"单价 %@ETH",model.price];
    self.numberLabe.text = [NSString stringWithFormat:@"%@  %@ISCM",SSKJLocalized(@"数量", nil),model.amount];
    
    [self.payView setViewWithModel:model];
    self.payView.right = self.backView.width - ScaleW(15);
    
    if (buySellType == BuySellTypeBuy) {
        self.buySellLabel.text = [NSString stringWithFormat:@"%@",SSKJLocalized(@"去购买", nil)];
    }else{
        self.buySellLabel.text = [NSString stringWithFormat:@"%@",SSKJLocalized(@"去出售", nil)];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
