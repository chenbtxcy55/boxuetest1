

#import "FBCSaleRecodViewController.h"
#import "FBCSellingHeaderView.h"
#import "FBCPayWaysTableViewCell.h"
#import "FBSellRecodTableViewCell.h"
@interface FBCSaleRecodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *subNavigation;
@property (nonatomic, strong) UIButton *sellOutBtn;
@property (nonatomic, strong) UIButton *buyInBtn;
@property (nonatomic, strong) UIView *movingLine;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FBCSaleRecodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviView];
    [self.view addSubview:self.tableView];
}

-(void)setNaviView
{
    self.navigationItem.titleView = self.subNavigation;
   
}
-(void)listShowAction:(UIBarButtonItem *)sender
{
    
}
-(UIView *)subNavigation
{
    if (!_subNavigation) {
        _subNavigation = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(167), Height_NavBar - Height_StatusBar)];
        _sellOutBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _sellOutBtn.frame = CGRectMake(0, 0, ScaleW(70), _subNavigation.height);
        [_sellOutBtn btn:_sellOutBtn font:ScaleW(15) textColor:kTextColorb3b7e9 text:@"发布记录" image:nil sel:@selector(orderBuyAction:) taget:self];
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
        [_buyInBtn btn:_buyInBtn font:ScaleW(15) textColor:kTextColorb3b7e9 text:@"购买记录" image:nil sel:@selector(orderBuyAction:) taget:self];
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
        [_tableView registerClass:[FBSellRecodTableViewCell class] forCellReuseIdentifier:@"FBSellRecodTableViewCell"];
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
    FBSellRecodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FBCPayWaysTableViewCell"];
//    if (!cell) {
//        cell =[[FBSellRecodTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"FBCPayWaysTableViewCell"];
//        
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(175);
}

-(void)addpayWaysAction:(UIButton *)sender
{
    
}
-(void)buyCommitAction:(UIButton *)sender
{
    
}
@end
