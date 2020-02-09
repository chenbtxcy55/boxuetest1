//
//  ETF_Mine_HeaderView.m
//  SSKJ
//
//  Created by James on 2019/5/5.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Mine_HeaderView.h"
#import "RegularExpression.h"

@interface JB_Mine_HeaderView()
@property (nonatomic, strong) UIImageView *bgIM;
@property (nonatomic, strong) UIImageView *headerIM;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *mainContentView;
@property (nonatomic, strong) UIButton *settingButton;

@end

@implementation JB_Mine_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgIM];
        [self.bgIM addSubview:self.headerIM];
        [self.bgIM addSubview:self.titleLB];
//        [self addSubview:self.mainScrollView];
//        [self.mainScrollView addSubview:self.mainContentView];
        [self.bgIM addSubview:self.TradeItem];
        [self.bgIM addSubview:self.DealMoneyItem];
        [self.bgIM addSubview:self.settingButton];
        
        
        
        [self setupMasnory];
    }
    return self;
}


- (void)setTradeModel:(JB_AccountItemModel *)tradeModel {
    _tradeModel = tradeModel;
    [self.TradeItem configureViewWithMoney:[WLTools noroundingStringWith:tradeModel.ttl_money.doubleValue
                                                        afterPointNumber:4]
                                       cny:[WLTools noroundingStringWith:tradeModel.ttl_cnymoney.doubleValue
                                                        afterPointNumber:4]];
}

- (void)setDealModel:(JB_AccountItemModel *)dealModel {
    _dealModel = dealModel;
    [self.DealMoneyItem configureViewWithMoney:[WLTools noroundingStringWith:dealModel.ttl_money.doubleValue
                                                        afterPointNumber:4]
                                       cny:[WLTools noroundingStringWith:dealModel.ttl_cnymoney.doubleValue
                                                        afterPointNumber:4]];
}

- (void)configureUserInfoWithModel:(SSKJ_UserInfo_Model *)model {
    self.titleLB.text = [self setupTitle:kPhoneNumber];
    [self.headerIM sd_setImageWithURL:[NSURL URLWithString:model.upic?:@""] placeholderImage:[UIImage imageNamed:@"mrtx_icon"]];
}

- (void)setttingButtonClick {
    if (self.settingBlock) {
        self.settingBlock();
    }
}


#pragma mark -- ETF_Mine_CellItemViewDelegate


#pragma mark -- Private Method

- (void)setupMasnory {
    [self.bgIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
        make.height.mas_equalTo(ScaleW(250));
        
    }];
    [self.headerIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgIM).offset(ScaleW(15));
        make.top.equalTo(self.bgIM).offset(ScaleW(50));
        make.width.height.mas_equalTo(ScaleW(32));
    }];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerIM.mas_right).offset(ScaleW(15));
        make.centerY.equalTo(self.headerIM);
    }];
    [self.TradeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat width = (ScreenWidth-ScaleW(15*2)-ScaleW(10))/2;
        make.left.equalTo(self.bgIM).offset(ScaleW(15));
        make.top.equalTo(self.headerIM.mas_bottom).offset(ScaleW(15));
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(ScaleW(110));
    }];
    [self.DealMoneyItem mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat width = (ScreenWidth-ScaleW(15*2)-ScaleW(10))/2;
        make.left.equalTo(self.TradeItem.mas_right).offset(ScaleW(10));
        make.top.equalTo(self.TradeItem);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(ScaleW(110));
    }];
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerIM);
        make.right.mas_equalTo(self.bgIM).offset(-ScaleW(15));
    }];

}

- (NSString *)setupTitle:(NSString *)title {
    NSMutableString* str1 = [[NSMutableString alloc]initWithString:title];
    NSString *mobileStr;
    if ([RegularExpression validateMobile:title] ) {
        mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        NSRange range = [title rangeOfString:@"@"];

        if (range.location == 0) {
            [str1 insertString:@"*" atIndex:1];
            mobileStr = [NSString stringWithFormat:@"%@",str1];
        }else if (range.location == 1){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
        }else if (range.location == 2){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"****"];
        }else if (range.location == 3){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"****"];
        }else if (range.location == 4){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:@"****"];
        }else if (range.location == 5){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"****"];
        }else{
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 4) withString:@"****"];
        }
    }
    return mobileStr;
}

#pragma mark -- Public Method

#pragma mark -- Getter Method
- (UIImageView *)bgIM {
    if (!_bgIM) {
        _bgIM = [[UIImageView alloc]init];
        _bgIM.image = [UIImage imageNamed:@"topbg_icon"];
        _bgIM.userInteractionEnabled = YES;
    }
    return _bgIM;
}

- (UIImageView *)headerIM {
    if (!_headerIM) {
        _headerIM = [[UIImageView alloc]init];
        _headerIM.image = [UIImage imageNamed:@"mrtx_icon"];
        _headerIM.layer.cornerRadius = ScaleW(16);
        _headerIM.layer.masksToBounds = YES;
        
    }
    return _headerIM;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = kMainTextColor;
        _titleLB.font = [UIFont systemFontOfSize:ScaleW(13)];
        _titleLB.text = @"";
        _titleLB.adjustsFontSizeToFitWidth = YES;
        _titleLB.text = [self setupTitle:_titleLB.text];
    }
    return _titleLB;
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]init];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.contentSize = CGSizeMake(ScaleW(164)*4+ScaleW(12)*5, ScaleW(110));
    }
    return _mainScrollView;
}

- (UIButton *)settingButton {
    if (!_settingButton) {
        _settingButton = [[UIButton alloc]init];
        [_settingButton setImage:[UIImage imageNamed:@"setting_icon"] forState:UIControlStateNormal];
        [_settingButton addTarget:self action:@selector(setttingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingButton;
}

- (UIView *)mainContentView {
    if (!_mainContentView) {
        _mainContentView = [[UIView alloc]init];
    }
    return _mainContentView;
}

- (JB_Mine_CellItemView *)TradeItem {
    if (!_TradeItem) {
        _TradeItem = [[JB_Mine_CellItemView alloc]init];
        [_TradeItem configureViewWithImage:@"jyzh_bg_icon" title:SSKJLocalized(@"交易账户 (AB)", nil)];
    }
    return _TradeItem;
}
- (JB_Mine_CellItemView *)DealMoneyItem {
    if (!_DealMoneyItem) {
        _DealMoneyItem = [[JB_Mine_CellItemView alloc]init];
        [_DealMoneyItem configureViewWithImage:@"lczh_bg_icon" title:SSKJLocalized(@"理财账户 (AB)", nil)];
    }
    return _DealMoneyItem;
}

#pragma mark -- Setter Method

@end
