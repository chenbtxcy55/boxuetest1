//
//  JB_Account_LicaiView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Account_LicaiView.h"
#import "ETF_Default_ActionsheetView.h"
@interface JB_Account_LicaiView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) UILabel *titleLabel;  // 累计收益title
@property (nonatomic, strong) UILabel *incomeLabel; // 累计收益

@property (nonatomic, strong) UILabel *totalLicaiTitleLabel;// 累计理财title
@property (nonatomic, strong) UILabel *totalLicaiLabel; //  累计理财

@property (nonatomic, strong) UIView *vLineView;    // 分割线

@property (nonatomic, strong) UILabel *balanceTitleLabel;  // 账户余额title
@property (nonatomic, strong) UILabel *balanceLabel;        // 账户余额

@property (nonatomic, strong) UIView *bottomBackView;
@property (nonatomic, strong) UITextField *amountTextField; // 数量输入框
@property (nonatomic, strong) UILabel *coinUnitLabel;   // 单位
@property (nonatomic, strong) UIView *unitLineView; // 单位分割线
@property (nonatomic, strong) UIView *amountLineView;

@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UILabel *selectDayLabel;
@property (nonatomic, strong) UIView *dayLineView;
@property (nonatomic, strong) UIButton *alphaButton;

@property (nonatomic, strong) UILabel *percentLabel;
@property (nonatomic, strong) UILabel *percentUnitLabel;
@property (nonatomic, strong) UIView *percentUnitLineView;
@property (nonatomic, strong) UIView *percentLineView;

@property (nonatomic, strong) UIButton *boxButton;  // 选择框
@property (nonatomic, strong) UILabel *openLabel;
@property (nonatomic, strong) UILabel *openDescribeLabel;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UILabel *warningLabel;

@property (nonatomic, strong) JB_Account_Licai_CoinModel *coinModel;

@property (nonatomic, strong) JB_Account_LicaiDetail_Model *licaiDetailModel;

@property (nonatomic, strong) JB_Account_LicaiCycle_Model *cycleModel;

@property (nonatomic, assign) NSInteger day;

@end

@implementation JB_Account_LicaiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainBackgroundColor;
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.topBackView];
        [self.topBackView addSubview:self.titleLabel];
        [self.topBackView addSubview:self.incomeLabel];
        
        [self.topBackView addSubview:self.totalLicaiTitleLabel];
        [self.topBackView addSubview:self.totalLicaiLabel];
        [self.topBackView addSubview:self.balanceTitleLabel];
        [self.topBackView addSubview:self.balanceLabel];
        [self.topBackView addSubview:self.vLineView];
        
        self.topBackView.height = self.balanceLabel.bottom + ScaleW(27);
        
        [self.scrollView addSubview:self.bottomBackView];
        [self.bottomBackView addSubview:self.amountTextField];
        [self.bottomBackView addSubview:self.coinUnitLabel];
        [self.bottomBackView addSubview:self.unitLineView];
        [self.bottomBackView addSubview:self.amountTextField];
        [self.bottomBackView addSubview:self.amountLineView];
        
        [self.bottomBackView addSubview:self.dayLabel];
        [self.bottomBackView addSubview:self.selectImageView];
        [self.bottomBackView addSubview:self.selectDayLabel];
        [self.bottomBackView addSubview:self.dayLineView];
        [self.bottomBackView addSubview:self.alphaButton];
        
        [self.bottomBackView addSubview:self.percentLabel];
        [self.bottomBackView addSubview:self.percentUnitLabel];
        [self.bottomBackView addSubview:self.percentUnitLineView];
        [self.bottomBackView addSubview:self.percentLineView];
        
        self.bottomBackView.height = self.percentLineView.bottom;
        
        [self.scrollView addSubview:self.boxButton];
        [self.scrollView addSubview:self.openLabel];
        [self.scrollView addSubview:self.openDescribeLabel];
        
        [self.scrollView addSubview:self.confirmButton];
        [self.scrollView addSubview:self.warningLabel];
        self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.warningLabel.bottom + ScaleW(32));
    }
    return self;
}

-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    }
    return _scrollView;
}

-(UIView *)topBackView
{
    if (nil == _topBackView) {
        _topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        _topBackView.backgroundColor = kSubBackgroundColor;
    }
    return _topBackView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"累计收益(BTC)" font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(0, ScaleW(42), ScreenWidth, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)incomeLabel
{
    if (nil == _incomeLabel) {
        _incomeLabel = [WLTools allocLabel:@"0.0000" font:systemFont(ScaleW(24)) textColor: kMainTextColor frame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(24)) textAlignment:NSTextAlignmentCenter];
    }
    return _incomeLabel;
}

-(UILabel *)totalLicaiTitleLabel
{
    if (nil == _totalLicaiTitleLabel) {
        _totalLicaiTitleLabel = [WLTools allocLabel:@"累计理财(BTC)" font:systemFont(ScaleW(12)) textColor:kTextDarkBlueColor frame:CGRectMake(0, self.incomeLabel.bottom + ScaleW(40), self.width / 2, ScaleW(12)) textAlignment:NSTextAlignmentCenter];
    }
    return _totalLicaiTitleLabel;
}

- (UILabel *)totalLicaiLabel
{
    if (nil == _totalLicaiLabel) {
        _totalLicaiLabel = [WLTools allocLabel:@"0.0000" font:systemFont(ScaleW(12)) textColor: kMainTextColor frame:CGRectMake(0, self.totalLicaiTitleLabel.bottom + ScaleW(10), self.totalLicaiTitleLabel.width, ScaleW(12)) textAlignment:NSTextAlignmentCenter];
    }
    return _totalLicaiLabel;
}

-(UILabel *)balanceTitleLabel
{
    if (nil == _balanceTitleLabel) {
        _balanceTitleLabel = [WLTools allocLabel:@"账户余额(BTC)" font:systemFont(ScaleW(12)) textColor:kTextDarkBlueColor frame:CGRectMake(self.totalLicaiTitleLabel.right, self.totalLicaiTitleLabel.y, self.totalLicaiTitleLabel.width, self.totalLicaiTitleLabel.height) textAlignment:NSTextAlignmentCenter];
    }
    return _balanceTitleLabel;
}

-(UILabel *)balanceLabel
{
    if (nil == _balanceLabel) {
        _balanceLabel = [WLTools allocLabel:@"0.0000" font:systemFont(ScaleW(12)) textColor: kMainTextColor frame:CGRectMake(self.balanceTitleLabel.x, self.totalLicaiLabel.y, self.balanceTitleLabel.width, self.totalLicaiLabel.height) textAlignment:NSTextAlignmentCenter];
    }
    return _balanceLabel;
}

-(UIView *)vLineView
{
    if (nil == _vLineView) {
        _vLineView = [[UIView alloc]initWithFrame:CGRectMake(self.totalLicaiTitleLabel.right, self.totalLicaiTitleLabel.y - ScaleW(2), 0.5, ScaleW(29))];
        _vLineView.backgroundColor = kLineGrayColor;
    }
    return _vLineView;
}

-(UIView *)bottomBackView
{
    if (nil == _bottomBackView) {
        _bottomBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topBackView.bottom + ScaleW(10), self.width, 0)];
        _bottomBackView.backgroundColor = kSubBackgroundColor;
    }
    return _bottomBackView;
}

-(UILabel *)coinUnitLabel
{
    if (nil == _coinUnitLabel) {
        _coinUnitLabel = [WLTools allocLabel:@"ETH" font:systemBoldFont(ScaleW(12)) textColor: kMainTextColor frame:CGRectMake(self.width - ScaleW(15) - ScaleW(60), 0, ScaleW(60), ScaleW(50)) textAlignment:NSTextAlignmentCenter];
    }
    return _coinUnitLabel;
}

- (UIView *)unitLineView
{
    if (nil == _unitLineView) {
        _unitLineView = [[UIView alloc]initWithFrame:CGRectMake(self.coinUnitLabel.x - 0.5, 0, 0.5, ScaleW(20))];
        _unitLineView.backgroundColor = kLineGrayColor;
        _unitLineView.centerY = self.coinUnitLabel.centerY;
    }
    return _unitLineView;
}

-(UITextField *)amountTextField
{
    if (nil == _amountTextField) {
        _amountTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, self.unitLineView.x - ScaleW(15), ScaleW(50))];
        _amountTextField.textColor =  kMainTextColor;
        _amountTextField.placeholder = SSKJLocalized(@"请输入数量", nil);
//        [_amountTextField setValue:kTextDarkBlueColor forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入数量", nil) attributes:@{NSForegroundColorAttributeName : kTextDarkBlueColor}];
        
        _amountTextField.attributedPlaceholder = placeholderString1;
        
    }
    
    return _amountTextField;
}

-(UIView *)amountLineView
{
    if (nil == _amountLineView) {
        _amountLineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.amountTextField.bottom, self.width - ScaleW(30), 0.5)];
        _amountLineView.backgroundColor = kLineGrayColor;
    }
    return _amountLineView;
}

-(UIImageView *)selectImageView
{
    if (nil == _selectImageView) {
        _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - ScaleW(15) - ScaleW(8), self.amountLineView.bottom + ScaleW(17.5), ScaleW(8), ScaleW(15))];
        _selectImageView.image = [UIImage imageNamed:@"arrow_right_icon"];
    }
    return _selectImageView;
}

-(UILabel *)selectDayLabel
{
    if (nil == _selectDayLabel) {
        _selectDayLabel = [WLTools allocLabel:SSKJLocalized(@"选择天数", nil) font:systemFont(ScaleW(13.5)) textColor: kMainTextColor frame:CGRectMake(self.selectImageView.x - ScaleW(100), self.amountLineView.bottom, ScaleW(100), ScaleW(50)) textAlignment:NSTextAlignmentRight];
    }
    return _selectDayLabel;
}

-(UILabel *)dayLabel
{
    if (nil == _dayLabel) {
        _dayLabel = [WLTools allocLabel:@"10天" font:systemFont(ScaleW(13.5)) textColor: kMainTextColor frame:CGRectMake(ScaleW(15), self.selectDayLabel.y, ScaleW(100), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _dayLabel;
}

-(UIView *)dayLineView
{
    if (nil == _dayLineView) {
        _dayLineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.dayLabel.bottom, self.width - ScaleW(30), 0.5)];
        _dayLineView.backgroundColor = kLineGrayColor;
    }
    return _dayLineView;
}

-(UIButton *)alphaButton
{
    if (nil == _alphaButton) {
        _alphaButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.dayLabel.y, self.width, self.dayLabel.height)];
        [_alphaButton addTarget:self action:@selector(selectDay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alphaButton;
}


-(UILabel *)percentUnitLabel
{
    if (nil == _percentUnitLabel) {
        _percentUnitLabel = [WLTools allocLabel:@"%" font:systemBoldFont(ScaleW(12)) textColor: kMainTextColor frame:CGRectMake(self.width - ScaleW(15) - ScaleW(44), self.dayLineView.bottom, ScaleW(44), ScaleW(50)) textAlignment:NSTextAlignmentRight];
    }
    return _percentUnitLabel;
}

- (UIView *)percentUnitLineView
{
    if (nil == _percentUnitLineView) {
        _percentUnitLineView = [[UIView alloc]initWithFrame:CGRectMake(self.percentUnitLabel.x - 0.5, 0, 0.5, ScaleW(20))];
        _percentUnitLineView.backgroundColor = kLineGrayColor;
        _percentUnitLineView.centerY = self.percentUnitLabel.centerY;
    }
    return _percentUnitLineView;
}

-(UILabel *)percentLabel
{
    if (nil == _percentLabel) {
        _percentLabel = [WLTools allocLabel:@"0.00" font:systemFont(ScaleW(13.5)) textColor: kMainTextColor frame:CGRectMake(ScaleW(15), self.dayLineView.bottom, ScaleW(200), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _percentLabel;
    
}

-(UIView *)percentLineView
{
    if (nil == _percentLineView) {
        _percentLineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.percentLabel.bottom, self.width - ScaleW(30), 0.5)];
        _percentLineView.backgroundColor = kLineGrayColor;
    }
    return _percentLineView;
}


-(UIButton *)boxButton
{
    if (nil == _boxButton) {
        _boxButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(0), self.bottomBackView.bottom, ScaleW(40), ScaleW(53))];
        [_boxButton setImage:[UIImage imageNamed:@"licai_box_normal"] forState:UIControlStateNormal];
        [_boxButton setImage:[UIImage imageNamed:@"licai_box_select"] forState:UIControlStateSelected];
        [_boxButton addTarget:self action:@selector(boxEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boxButton;
}

-(UILabel *)openLabel
{
    if (nil == _openLabel) {
        _openLabel = [WLTools allocLabel:SSKJLocalized(@"开启自动放贷", nil) font:systemFont(ScaleW(14)) textColor: kMainTextColor frame:CGRectMake(self.boxButton.right, 0, ScaleW(300), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _openLabel.centerY = self.boxButton.centerY;
    }
    return _openLabel;
}

-(UILabel *)openDescribeLabel
{
    if (nil == _openDescribeLabel) {
        
        NSString *text = SSKJLocalized(@"开启自动放贷，系统将根据已收回的贷款自动放贷", nil);
        _openDescribeLabel = [WLTools allocLabel:text font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.openLabel.x, self.openLabel.bottom + ScaleW(10), ScreenWidth - ScaleW(15) - self.openLabel.x, 0) textAlignment:NSTextAlignmentLeft];
        CGFloat heith = [text boundingRectWithSize:CGSizeMake(_openDescribeLabel.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_openDescribeLabel.font} context:nil].size.height;
        _openDescribeLabel.height = heith;
        
    }
    return _openDescribeLabel;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.openDescribeLabel.bottom + ScaleW(57), ScreenWidth - ScaleW(50), ScaleW(45))];
        [_confirmButton setTitle:SSKJLocalized(@"确认挂单", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 4.0f;
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton addGradientColor];
    }
    return _confirmButton;
}


-(UILabel *)warningLabel
{
    if (nil == _warningLabel) {
        NSString *text = SSKJLocalized(@"提示：您需要填写期望收取的利率按百分比计算，后台会自动帮你挂单，等待借款人。理财投资属于自担风险类型，每笔理财收益，平台会收取20%的手续费！", nil);
        _warningLabel = [WLTools allocLabel:text font:systemFont(ScaleW(13)) textColor:kTextDarkBlueColor frame:CGRectMake(self.confirmButton.x, self.confirmButton.bottom + ScaleW(10), ScreenWidth - 2 * self.confirmButton.x, 0) textAlignment:NSTextAlignmentLeft];
        CGFloat heith = [text boundingRectWithSize:CGSizeMake(_openDescribeLabel.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_openDescribeLabel.font} context:nil].size.height;
        _warningLabel.height = heith;
    }
    return _warningLabel;
}


#pragma mark - 逻辑处理

-(void)setViewWithCoinModel:(JB_Account_Licai_CoinModel *)coinModel detailModel:(JB_Account_LicaiDetail_Model *)detailModel
{
    
    _coinModel = coinModel;
    _licaiDetailModel = detailModel;
    
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"理财收益", nil),coinModel.pname];
    self.totalLicaiTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"累计理财", nil),coinModel.pname];
    self.balanceTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"账户余额", nil),coinModel.pname];
    self.coinUnitLabel.text = coinModel.pname;
    self.incomeLabel.text = [WLTools noroundingStringWith:detailModel.in_come.doubleValue afterPointNumber:4];
    
    self.totalLicaiLabel.text = [WLTools noroundingStringWith:detailModel.lend_sum.doubleValue afterPointNumber:4];
    self.balanceLabel.text = [WLTools noroundingStringWith:detailModel.usable.doubleValue afterPointNumber:4];
    
    self.cycleModel = self.coinModel.day_rate.firstObject;
    self.dayLabel.text = [NSString stringWithFormat:@"%@%@",self.cycleModel.days,SSKJLocalized(@"天", nil)];
    self.day = [self.cycleModel.days integerValue];
    self.percentLabel.text = [WLTools noroundingStringWith:[self.cycleModel rate].doubleValue afterPointNumber:4];
}

-(void)clearView
{
    self.amountTextField.text = nil;
}

#pragma mark - 用户操作
-(void)boxEvent
{
    self.boxButton.selected = !self.boxButton.selected;
}

-(void)selectDay
{
    WS(weakSelf);
    
    __block NSMutableArray *array = [NSMutableArray array];
    
    for (JB_Account_LicaiCycle_Model *model in self.coinModel.day_rate) {
        [array addObject:[model.days stringByAppendingString:SSKJLocalized(@"天", nil)]];
    }
    [ETF_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *text = array[selectIndex];
        weakSelf.dayLabel.text = text;
        JB_Account_LicaiCycle_Model *selectModel = weakSelf.coinModel.day_rate[selectIndex];
        weakSelf.cycleModel = selectModel;
        weakSelf.percentLabel.text = [WLTools noroundingStringWith:selectModel.rate.doubleValue  afterPointNumber:4];
        weakSelf.day = selectModel.days.integerValue;
        
    } cancleBlock:^{
        
    }];
    
}

-(void)confirmEvent
{
    if (self.amountTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入理财数量", nil)];
        return;
    }
    
    if (self.amountTextField.text.doubleValue == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"理财数量不能为0", nil)];
        return;
    }
    
    if (self.amountTextField.text.doubleValue > self.licaiDetailModel.usable.doubleValue) {
        [MBProgressHUD showError:SSKJLocalized(@"账户余额不足", nil)];
        return;
    }
    
    if (self.confirmBlock) {
        self.confirmBlock(self.amountTextField.text, self.day,self.boxButton.selected,self.cycleModel.rate);
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
