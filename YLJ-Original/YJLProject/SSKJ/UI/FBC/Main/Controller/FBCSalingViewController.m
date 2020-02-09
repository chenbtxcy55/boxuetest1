//
//  FBCSalingViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/5/15.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "FBCSalingViewController.h"
#import "FBCSellingHeaderView.h"
#import "FBCPayWaysTableViewCell.h"
#import "FBCSaleRecodViewController.h"
@interface FBCSalingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *subNavigation;
@property (nonatomic, strong) UIButton *sellOutBtn;
@property (nonatomic, strong) UIButton *buyInBtn;
@property (nonatomic, strong) UIView *movingLine;
@property (nonatomic, strong) FBCSellingHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *buyBtn;
@property (nonatomic, strong) UIButton *addPaywaysBtn;
//1发布出售 2发布购买

@property (nonatomic, assign) NSInteger sellingType;
@end

@implementation FBCSalingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviView];
    [self.view addSubview:self.tableView];
}
-(FBCSellingHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[FBCSellingHeaderView alloc]init];
        
    }
    return _headerView;
}
-(void)setNaviView
{
    self.navigationItem.titleView = self.subNavigation;
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_recod"] style:(UIBarButtonItemStyleDone) target:self action:@selector(listShowAction:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
-(void)listShowAction:(UIBarButtonItem *)sender
{
    FBCSaleRecodViewController *vc = [[FBCSaleRecodViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setSellingType:(NSInteger)sellingType
{
    _sellingType = sellingType;
    
    
}
-(UIView *)subNavigation
{
    if (!_subNavigation) {
        _subNavigation = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(167), Height_NavBar - Height_StatusBar)];
        _sellOutBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _sellOutBtn.frame = CGRectMake(0, 0, ScaleW(70), _subNavigation.height);
        [_sellOutBtn btn:_sellOutBtn font:ScaleW(15) textColor:kTextColorb3b7e9 text:@"发布出售" image:nil sel:@selector(orderBuyAction:) taget:self];
        [_sellOutBtn setTitleColor:kText878ff5 forState:(UIControlStateSelected)];
        _sellOutBtn.selected = YES;
        [_subNavigation addSubview:_sellOutBtn];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, ScaleW(19))];
        lineView.backgroundColor = kTextColor313359;
        lineView.centerX = _subNavigation.width/2.f;
        lineView.centerY = _subNavigation.height/2.f;
        [_subNavigation addSubview:lineView];
        _buyInBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _buyInBtn.frame = CGRectMake(0, 0, ScaleW(70), _subNavigation.height);
        [_buyInBtn btn:_buyInBtn font:ScaleW(15) textColor:kTextColorb3b7e9 text:@"发布购买" image:nil sel:@selector(orderBuyAction:) taget:self];
        _buyInBtn.right = _subNavigation.right;
        [_subNavigation addSubview:_buyInBtn];
        [_buyInBtn setTitleColor:kText878ff5 forState:(UIControlStateSelected)];
        _buyInBtn.selected = NO;
        _movingLine = [[UIView alloc]initWithFrame:CGRectMake(0, _subNavigation.height - 2, ScaleW(30), 2)];
        _movingLine.backgroundColor = kText878ff5;
        [_subNavigation addSubview:_movingLine];
        _movingLine.centerX = _sellOutBtn.centerX;
        
    }
    return _subNavigation;
}
-(void)orderBuyAction:(UIButton *)sender
{
    if (sender == _buyInBtn) {
        _buyInBtn.selected = YES;
        _sellOutBtn.selected = NO;
    }
    if (sender == _sellOutBtn) {
        _buyInBtn.selected = NO;
        _sellOutBtn.selected = YES;
    }
    _movingLine.centerX = sender.centerX;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.backgroundColor = [UIColor clearColor];
        //_tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.footerView;
        
    }
    
    return _tableView;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBCPayWaysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FBCPayWaysTableViewCell"];
    if (!cell) {
        cell =[[FBCPayWaysTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"FBCPayWaysTableViewCell"];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}
-(UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0  , ScreenWidth, ScaleW(149))];
        _footerView.backgroundColor = kMianDeepBgColor;
        _addPaywaysBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addPaywaysBtn.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(45));
        [_addPaywaysBtn btn:_addPaywaysBtn font:ScaleW(14) textColor:kText878ff5 text:@"添加支付方式" image:nil sel:@selector(addpayWaysAction:) taget:self];
        [_footerView addSubview:_addPaywaysBtn];
        //17
        _buyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _buyBtn.frame = CGRectMake(ScaleW(25), ScaleW(17) + _addPaywaysBtn.bottom, ScaleW(325), ScaleW(45));
        [_buyBtn btn:_buyBtn font:ScaleW(15) textColor:kMainWihteColor text:@"购买" image:nil sel:@selector(buyCommitAction:) taget:self];
        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:(UIControlStateNormal)];
        _buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:ScaleW(15)];
        
        [_footerView addSubview:_buyBtn];
    }
    return _footerView;
}
-(void)addpayWaysAction:(UIButton *)sender
{
    
}
-(void)buyCommitAction:(UIButton *)sender
{
    [self sellBiRequstHttp];
}
//ETF_FBHomeFbtransPmma_URL
-(void)FBHomeFbtransPmmaRequstHttp
{
    
}
-(void)sellBiRequstHttp
{
    if ([self pamasIsOk] == NO) {
        return;
    }
    WS(weakSelf);
    
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];
    NSString *amount= self.headerView.amountTF.text;
    NSString *min_price = self.headerView.lowLimitTf.text;
    NSString *max_price = self.headerView.hightLimitTf.text;
    NSString *price = self.headerView.signlePriceTf.text;
    NSString *type = self.sellingType == 1 ?@"sell":@"pmma";
    NSDictionary *params = @{
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ETF_FBHomeFbtransTrading_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            
            
        }else{
            
            
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}
-(BOOL)pamasIsOk
{
    if (!self.headerView.amountTF.text.length) {
        NSString *message = [NSString stringWithFormat:@"请输入%@数量",(self.headerView.sellingType==1)?@"出售":@"购买"];
        [MBProgressHUD showError:message];
        return NO;
    }
    if (!self.headerView.lowLimitTf.text.length) {
        NSString *message = [NSString stringWithFormat:@"请输入最低%@数量",(self.headerView.sellingType==1)?@"出售":@"购买"];
        [MBProgressHUD showError:message];
        return NO;
    }
    if (!self.headerView.hightLimitTf.text.length) {
        NSString *message = [NSString stringWithFormat:@"请输入最高%@数量",(self.headerView.sellingType==1)?@"出售":@"购买"];
        [MBProgressHUD showError:message];
        return NO;
    }
    if (!self.headerView.signlePriceTf.text.length) {
        NSString *message = [NSString stringWithFormat:@"请输入%@单价",(self.headerView.sellingType==1)?@"出售":@"购买"];
        [MBProgressHUD showError:message];
        return NO;
    }
    return YES;
}
@end
