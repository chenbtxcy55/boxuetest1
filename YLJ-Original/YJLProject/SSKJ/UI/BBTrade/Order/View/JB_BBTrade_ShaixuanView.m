//
//  JB_BBTrade_ShaixuanView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_ShaixuanView.h"
#import "JB_Shaixun_ItemView.h"
#import "ETF_Default_ActionsheetView.h"
@interface JB_BBTrade_ShaixuanView ()

@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) JB_Shaixun_ItemView *productView; // 产品
@property (nonatomic, strong) JB_Shaixun_ItemView *typeView;    // 类型
@property (nonatomic, strong) JB_Shaixun_ItemView *statusView;  // 状态

@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *statusArray;
@property (nonatomic, strong) NSArray *coinNameArray;

@property (nonatomic, copy) NSString *coinCode;
@property (nonatomic, copy) NSString *buySellType;
@property (nonatomic, copy) NSString *status;


@end

@implementation JB_BBTrade_ShaixuanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:self.showView];
        [self.showView addSubview:self.productView];
        [self.showView addSubview:self.typeView];
        [self.showView addSubview:self.statusView];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmButton];
        
        self.showView.height = self.confirmButton.bottom;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        
        
        self.typeArray = @[SSKJLocalized(@"全部", nil),SSKJLocalized(@"买入", nil),SSKJLocalized(@"卖出", nil)];
        self.statusArray = @[SSKJLocalized(@"全部", nil),SSKJLocalized(@"已成交", nil),SSKJLocalized(@"已撤销", nil)];
        
    }
    return self;
}


-(UIView *)showView
{
    if (nil == _showView) {
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, 0)];
        _showView.backgroundColor = kSubBackgroundColor;
    }
    return _showView;
}

-(JB_Shaixun_ItemView *)productView
{
    if (nil == _productView) {
        _productView = [[JB_Shaixun_ItemView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(30), ScaleW(165), ScaleW(63)) title:SSKJLocalized(@"产品", nil)];
        [_productView setValueString:SSKJLocalized(@"全部",nil)];
        WS(weakSelf);
        _productView.selectedBlock = ^{
            weakSelf.productView.selected = YES;
            [ETF_Default_ActionsheetView showWithItems:weakSelf.coinNameArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
                NSString *text = weakSelf.coinNameArray[selectIndex];
                [weakSelf.productView setValueString:text];
                weakSelf.productView.selected = NO;
                if (selectIndex == 0) {
                    weakSelf.coinCode = @"";
                }else{
                    weakSelf.coinCode = text;
                }
            } cancleBlock:^{
                weakSelf.productView.selected = NO;
            }];
        };
    }
    return _productView;
}

-(JB_Shaixun_ItemView *)typeView
{
    if (nil == _typeView) {
        _typeView = [[JB_Shaixun_ItemView alloc]initWithFrame:CGRectMake(self.productView.right + ScaleW(15), self.productView.y, self.productView.width, self.productView.height) title:SSKJLocalized(@"类型", nil)];
        [_typeView setValueString:SSKJLocalized(@"全部",nil)];
        WS(weakSelf);
        _typeView.selectedBlock = ^{
            weakSelf.typeView.selected = YES;
            [ETF_Default_ActionsheetView showWithItems:weakSelf.typeArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
                NSString *text = weakSelf.typeArray[selectIndex];
                [weakSelf.typeView setValueString:text];
                weakSelf.typeView.selected = NO;
                
                if (selectIndex == 0) {
                    weakSelf.buySellType = @"";
                }else{
                    weakSelf.buySellType = [NSString stringWithFormat:@"%ld",selectIndex];
                }
            } cancleBlock:^{
                weakSelf.typeView.selected = NO;
            }];
        };
    }
    return _typeView;
}

-(JB_Shaixun_ItemView *)statusView
{
    if (nil == _statusView) {
        _statusView = [[JB_Shaixun_ItemView alloc]initWithFrame:CGRectMake(self.productView.x, self.productView.bottom + ScaleW(20), self.productView.width, self.productView.height) title:SSKJLocalized(@"状态", nil)];
        [_statusView setValueString:SSKJLocalized(@"全部",nil)];
        WS(weakSelf);

        _statusView.selectedBlock = ^{
            weakSelf.statusView.selected = YES;
            [ETF_Default_ActionsheetView showWithItems:weakSelf.statusArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
                NSString *text = weakSelf.statusArray[selectIndex];
                [weakSelf.statusView setValueString:text];
                weakSelf.statusView.selected = NO;
                if (selectIndex == 0) {
                    weakSelf.status = @"";
                }else{
                    if (selectIndex == 1) {
                        weakSelf.status  = @"2";
                    }else if (selectIndex == 2){
                        weakSelf.status  = @"-1";
                    }
                }
            } cancleBlock:^{
                weakSelf.statusView.selected = NO;

            }];
        };

    }
    return _statusView;
}

- (UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.statusView.bottom + ScaleW(60), self.width / 2, ScaleW(50))];
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kTextLightBlueColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(14));
        _cancleButton.backgroundColor = UIColorFromRGB(0x1a1e39);
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

- (UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width / 2, self.statusView.bottom + ScaleW(60), self.width / 2, ScaleW(50))];
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemFont(ScaleW(14));
        _confirmButton.backgroundColor = UIColorFromRGB(0x506cde);
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(void)confirmEvent
{
    if (self.confirmBlock) {
        self.confirmBlock(self.coinCode, self.buySellType, self.status);
    }
    [self hide];
}


-(void)cancleEvent
{
    [self hide];
}


-(void)showWithCoinCode:(NSString *)coinCode status:(NSString *)status buySellType:(NSString *)buySellType;
{
    self.coinCode = coinCode;
    self.status = status;
    self.buySellType = buySellType;
    if (coinCode.length == 0) {
        [self.productView setValueString:SSKJLocalized(@"全部", nil)];
    }else{
        [self.productView setValueString:coinCode];
    }
    
    if (status.length == 0) {
        [self.statusView setValueString:SSKJLocalized(@"全部", nil)];
    }else{
        if (status.integerValue == 0) {
            [self.typeView setValueString:SSKJLocalized(@"委托中", nil)];
        }else if (status.integerValue == 1){
            [self.typeView setValueString:SSKJLocalized(@"交易中", nil)];
        }else if (status.integerValue == 2){
            [self.typeView setValueString:SSKJLocalized(@"已成交", nil)];
        }else if (status.integerValue == -1){
            [self.typeView setValueString:SSKJLocalized(@"已撤销", nil)];
        }
    }
    
    if (buySellType.length == 0) {
        [self.typeView setValueString:SSKJLocalized(@"全部", nil)];
    }else{
        if (buySellType.integerValue == 1) {
            [self.typeView setValueString:SSKJLocalized(@"买入", nil)];
        }else{
            [self.typeView setValueString:SSKJLocalized(@"买入", nil)];
        }
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)hide
{
    [self removeFromSuperview];
}

-(void)setCoinArray:(NSArray *)coinArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (JB_BBTrade_CoinModel *model in coinArray) {
        [array addObject:model.mark];
    }
    
    self.coinNameArray = array;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
