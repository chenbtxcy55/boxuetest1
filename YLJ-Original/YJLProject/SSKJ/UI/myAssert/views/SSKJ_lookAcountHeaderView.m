
//
//  SSKJ_lookAcountHeaderView.m
//  SSKJ
//
//  Created by GT on 2019/9/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_lookAcountHeaderView.h"

@interface bottomItemView :UIView
@property (nonatomic ,strong) UIImageView *imaV;
@property (nonatomic ,strong) UILabel *titleLb;
@property (nonatomic ,strong) UIButton *selectedBtn;
@property (nonatomic ,strong) void(^selectedItemBlock)(NSInteger index);
@end

@implementation bottomItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    self.imaV = [[UIImageView alloc] init];
    self.titleLb = [UILabel new];
    self.selectedBtn = [UIButton new];
    
    [self addSubview:self.imaV];
    [self addSubview:self.titleLb];
    [self addSubview:self.selectedBtn];
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    self.titleLb.textColor = kMainWihteColor;
    self.imaV.contentMode = UIViewContentModeScaleAspectFit;
    self.selectedBtn.titleLabel.font = systemFont(12);
    [self.selectedBtn addTarget:self action:@selector(clickItem) forControlEvents:UIControlEventTouchUpInside];
    self.titleLb.adjustsFontSizeToFitWidth = YES;
}
- (void)clickItem{
    NSInteger index = self.tag - 1000;
    !self.selectedItemBlock ? : self.selectedItemBlock(index);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imaV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(ScaleW(-35));
        make.top.mas_equalTo(self).offset(ScaleW(15));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(ScaleW(5));
        make.right.mas_equalTo(self).offset(ScaleW(-5));
        make.top.mas_equalTo(self);
    }];
    
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsZero);
    }];
}



@end





@interface SSKJ_lookAcountHeaderView()


@property (nonatomic ,strong) UIImageView *bgImageView;

@property (nonatomic ,strong) UIView *topView;
@property (nonatomic ,strong) UIView *bottomView;

@property (nonatomic ,strong) UIImageView *topBgImageV;
@property (nonatomic ,strong) UILabel *titleLb;
@property (nonatomic ,strong) UILabel *assetAcountLb;
@property (nonatomic ,strong) UILabel *moneyLb;
@property (nonatomic ,strong) UIButton *eyeBtn;

@property (nonatomic ,strong) NSMutableArray *itemArr;
@property (nonatomic ,assign) NSInteger itemCount;

@property (nonatomic ,strong) NSArray *titleArr;
@property (nonatomic ,strong) NSArray *imageArr;
@property (nonatomic , assign) BOOL selected;

@property (nonatomic ,strong) UILabel *secretMoneyLb;//加密
@property (nonatomic ,strong) UILabel *sectetMoney2Lb;//加密cny
@end
@implementation SSKJ_lookAcountHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}


- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    self.titleArr = @[SSKJLocalized(@"充币", nil), SSKJLocalized(@"提币", nil), SSKJLocalized(@"兑换", nil),];
    self.imageArr = @[SSKJLocalized(@"充币", nil),SSKJLocalized(@"提币", nil),SSKJLocalized(@"兑换", nil)];
    
//    if (selectedIndex == 0) {
//
//    }else if (selectedIndex == 1){
//        self.titleArr = @[SSKJLocalized(@"收付款设置", nil), SSKJLocalized(@"法币订单", nil), SSKJLocalized(@"划转", nil),];
//        self.imageArr = @[@"收付款设置", @"订单", @"划转"];
//    }else if (selectedIndex == 2){
//        self.titleArr = @[SSKJLocalized(@"币币订单", nil), SSKJLocalized(@"划转", nil),];
//        self.imageArr = @[@"订单", @"划转"];
//    }else if (selectedIndex == 3){
//        self.titleArr = @[SSKJLocalized(@"空投", nil), SSKJLocalized(@"划转", nil),];
//        self.imageArr = @[@"空投", @"划转"];
//    }
    
    
    self.itemCount =  self.titleArr.count;
    //清理item 重新布局
    if (self.itemArr.count > 0) {
        for (UIView *btn in self.itemArr) {
            [btn removeFromSuperview];
        }
        [self.itemArr removeAllObjects];
    }
    
    //布局
    for (int i = 0; i < self.itemCount; i++) {
        bottomItemView *item = [[bottomItemView alloc] init];
        item.frame = CGRectMake(ScaleW(15) + (ScaleW(90) + ScaleW(23))*i, 0, ScaleW(90), ScaleW(30));
        
        item.layer.borderColor = kMainWihteColor.CGColor;
        item.layer.borderWidth = ScaleW(1);
        item.layer.cornerRadius = ScaleW(5);
        item.layer.masksToBounds = YES;
        
        [self.bottomView addSubview:item];
        item.tag = i + 1000;
        item.titleLb.text = self.titleArr[i];
        item.imaV.image = [UIImage imageNamed:self.imageArr[i]];
        [self.itemArr addObject:item];
        item.selectedItemBlock = ^(NSInteger index) {
            !self.selectedItemBlock ? : self.selectedItemBlock(index);
        };
        
    }
    
//    [self layoutIfNeeded];
//    CGFloat itemLenth = ScaleW(90);
//    CGFloat space = 0;
//    if (selectedIndex == 2 || selectedIndex == 3) {
//        space = self.width / 3.0;
//        itemLenth = space;
//    }
//    [self.itemArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:itemLenth leadSpacing:space * 0.5 tailSpacing:space * 0.5];
//    [self.itemArr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(self.bottomView);
//    }];
}





- (void)addChildrenViews{
    
    [self addSubview:self.bgImageView];

    [self.bgImageView addSubview:self.topView];
    [self.bgImageView addSubview:self.bottomView];
    self.eyeBtn = [UIButton new];
    self.titleLb = [UILabel new];
    self.assetAcountLb = [UILabel new];
    self.moneyLb  = [UILabel new];
    self.secretMoneyLb = [UILabel new];
    self.sectetMoney2Lb = [UILabel new];
    
    [self.topView addSubview:self.topBgImageV];
    [self.topView addSubview:self.titleLb];
    [self.topView addSubview:self.assetAcountLb];
    [self.topView addSubview:self.moneyLb];
    [self.topView addSubview:self.eyeBtn];
    [self.topView addSubview:self.secretMoneyLb];
    [self.topView addSubview:self.sectetMoney2Lb];
    
    self.titleLb.font = systemBoldFont(16);
    self.titleLb.textColor = kMainWihteColor;
    
    self.assetAcountLb.font = self.secretMoneyLb.font = systemBoldFont(30);
    self.assetAcountLb.textColor = self.secretMoneyLb.textColor = kMainWihteColor;
    
    self.moneyLb.font = self.sectetMoney2Lb.font = systemFont(13);
    self.moneyLb.textColor = self.sectetMoney2Lb.textColor = kMainWihteColor;
    self.secretMoneyLb.hidden = YES;
    self.sectetMoney2Lb.hidden = YES;
    
    [self.eyeBtn addTarget:self action:@selector(lookAsessBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.eyeBtn setImage:[UIImage imageNamed:@"eyeOpenWhite"] forState:UIControlStateNormal];
//    [self.eyeBtn setImage:[UIImage imageNamed:@"eyeCloseWhite"] forState:UIControlStateSelected];
    
    
    
    //默认是第一列的数据
    self.selectedIndex = 0;
    self.secretMoneyLb.text = self.sectetMoney2Lb.text = @"******";
    
    
    
    self.titleLb.text = SSKJLocalized(@"资产账户", nil);
    self.assetAcountLb.text = @"--";
    self.moneyLb.text = [NSString stringWithFormat:@"≈%@ CNY", @"--"];
    
}

- (void)setAssetDict:(NSDictionary *)assetDict{
    _assetDict = assetDict; //≈%@ CNY
    self.assetAcountLb.text = [NSString stringWithFormat:@"%@ USDT",[WLTools noroundingStringWith:[NSString stringWithFormat:@"%@", assetDict[@"usdt_num"] ? assetDict[@"usdt_num"] : @"0.0000"].doubleValue afterPointNumber:6]];
    NSString *price =  [WLTools roundingStringWith:[NSString stringWithFormat:@"%@", assetDict[@"cny_num"] ? assetDict[@"cny_num"] : @"0.00"].doubleValue afterPointNumber:2];
    self.moneyLb.text = [NSString stringWithFormat:@"≈%@ CNY", price];
}




- (void) lookAsessBtnClick:(UIButton *)sender{
//    sender.selected = !sender.selected;
    self.selected = !self.selected;
    [self.eyeBtn setImage:[UIImage imageNamed:!self.selected ?  @"eyeOpenWhite" : @"eyeCloseWhite"] forState:UIControlStateNormal];
    self.assetAcountLb.hidden = self.moneyLb.hidden = self.selected;
    self.secretMoneyLb.hidden = self.sectetMoney2Lb.hidden = !self.assetAcountLb.hidden;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(@(ScaleW()));
        make.left.mas_equalTo(self).offset(ScaleW(0));
        make.right.mas_equalTo(self).offset(-ScaleW(0));

        make.height.mas_equalTo(ScaleW(174));
    }];

    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.bgImageView);
        make.height.mas_equalTo(ScaleW(130));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.bgImageView);
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];
    
    [self.topBgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.topView).insets(UIEdgeInsetsZero);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_top).offset(ScaleW(21));
        make.height.mas_equalTo(ScaleW(15));
        make.left.mas_equalTo(self.topBgImageV.mas_left).offset(ScaleW(15));
    }];
    [self.assetAcountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScaleW(29));
        make.height.mas_equalTo(ScaleW(25));
        make.left.mas_equalTo(self.titleLb.mas_left);
    }];
    [self.secretMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.assetAcountLb.mas_left);
        make.centerY.mas_equalTo(self.assetAcountLb.mas_centerY).offset(ScaleW(3));
    }];
    
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.assetAcountLb.mas_bottom).offset(ScaleW(18));
        make.height.mas_equalTo(ScaleW(15));
        make.left.mas_equalTo(self.titleLb.mas_left);
    }];
    
    [self.sectetMoney2Lb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.moneyLb.mas_centerX);
        make.centerY.mas_equalTo(self.moneyLb.mas_centerY).offset(ScaleW(3));
//        make.top.mas_equalTo(self.moneyLb.mas_bottom).offset(ScaleW(18));
        make.height.mas_equalTo(ScaleW(11));
        make.left.mas_equalTo(self.moneyLb.mas_left);
        
    }];
    
    [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.topView.mas_right).offset(ScaleW(-25));
        make.top.mas_equalTo(self.topView.mas_top).offset(ScaleW(25));
        make.width.height.mas_equalTo(ScaleW(25));
    }];
    
}

- (UIView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"my_assert_bg"];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor =  [UIColor clearColor];
    }
    return _topView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor clearColor];
        
    }
    return _bottomView;
}
- (UIImageView *)topBgImageV{
    if (!_topBgImageV) {
        _topBgImageV = [[UIImageView alloc] init];
        _topBgImageV.image = [UIImage imageNamed:@"acountHeaderBg"];
    }
    return _topBgImageV;
}
- (NSMutableArray *)itemArr{
    if (!_itemArr) {
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}

@end
