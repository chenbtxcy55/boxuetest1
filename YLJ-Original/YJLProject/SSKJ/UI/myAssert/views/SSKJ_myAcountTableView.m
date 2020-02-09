

//
//  SSKJ_myAcountTableView.m
//  SSKJ
//
//  Created by GT on 2019/9/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_myAcountTableView.h"
#import "SSKJ_myAcountTableViewCell.h"
#import "SSKJ_lookAcountHeaderView.h"

@interface SSKJ_myAcountTableView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataSourceArr;
//@property (nonatomic ,strong) NSMutableArray *shaiXuanDataSourceArr;
@property (nonatomic ,strong) UIView *headerV;

@property (nonatomic ,strong) SSKJ_lookAcountHeaderView *headerView;
//@property (nonatomic ,assign) BOOL isShowShaiXuan;


@end
@implementation SSKJ_myAcountTableView

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

- (void)addChildrenViews{
//    for (int i = 0; i < 10; i++) {
//        [self.dataSourceArr addObject:@""];
//    }
    [self addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    WS(weakSelf);
    self.headerView.selectedItemBlock = ^(NSInteger index) {
        !weakSelf.selectedItemBlock ? : weakSelf.selectedItemBlock(index);
    };
}


- (void)setAssetDict:(NSDictionary *)assetDict{
    if (assetDict == nil) {
        [self.dataSourceArr removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    _assetDict = assetDict;
    self.headerView.assetDict = assetDict;
    
    self.dataSourceArr = [WLLAssetsInfoModel mj_keyValuesArrayWithObjectArray:assetDict[@"res"][@"asset"]];
    
    
    
    
    [self.dataSourceArr removeAllObjects];
    
    for (NSDictionary *dict in assetDict[@"res"][@"asset"]) {
        WLLAssetsInfoModel *model = [[WLLAssetsInfoModel alloc] init];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            [model setValuesForKeysWithDictionary:dict];
            NSLog(@"%@", model.pname);
            [self.dataSourceArr addObject:model];
        }
        
    }

    
    
    [self.tableView reloadData];
}


- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    self.headerView.selectedIndex = selectedIndex;
    [self.dataSourceArr removeAllObjects];
    [self.tableView reloadData];
}




- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSKJ_myAcountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SSKJ_myAcountTableViewCell class]) forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSourceArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //传model
    !self.selectedCellBlock ? : self.selectedCellBlock(indexPath.row);
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScaleW(60);
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScaleW(50);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-ScaleW(20), ScaleW(50))];
    headerV.backgroundColor = kNavBGColor;
    UIView *leftView = [[UIView alloc] init];
    UILabel *titleLb = [UILabel new];
    UIView *topLineV = [UIView new];
    topLineV.backgroundColor = kMainColor;
    titleLb.font = systemBoldFont(15);
    titleLb.textColor = kMainTextColor;
    leftView.backgroundColor = kMainWihteColor;
    [headerV addSubview:leftView];
    [headerV addSubview:titleLb];
    [headerV addSubview:topLineV];
    titleLb.text = SSKJLocalized(@"币种列表", nil);
    

    
    
    [topLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(headerV);
        make.height.mas_equalTo(ScaleW(0));
    }];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLineV.mas_bottom).offset(ScaleW(18));
        make.bottom.mas_equalTo(headerV.mas_bottom).offset(ScaleW(-18));
        make.width.mas_equalTo(ScaleW(3));
        make.left.mas_equalTo(headerV.mas_left).offset(ScaleW(16));
    }];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView.mas_right).offset(10);
        make.centerY.mas_equalTo(leftView.mas_centerY);
    }];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:headerV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:(CGSize){ScaleW(8)}];
    // 绘制4个角，指定角半径
    // bezierPath = [UIBezierPath bezierPathWithRoundedRect:imageView2.bounds cornerRadius:20.0];
    // 绘制圆
    // bezierPath = [UIBezierPath bezierPathWithOvalInRect:imageView2.bounds];
    // 初始化shapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    // 设置绘制路径
    shapeLayer.path = bezierPath.CGPath;
    // 将shapeLayer设置为imageView2的layer的mask(遮罩)
    headerV.layer.mask = shapeLayer;
    
    self.headerV = headerV;
    
    
    return self.headerV;
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-ScaleW(20), self.bounds.size.height) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor = kMainWihteColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorColor = kLineGrayColor;
        [_tableView registerClass:[SSKJ_myAcountTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SSKJ_myAcountTableViewCell class])];

        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.tableView.mj_header endRefreshing];
            !weakSelf.refreshHeader ? : weakSelf.refreshHeader();
        }];
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_tableView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:(CGSize){ScaleW(8)}];
        // 绘制4个角，指定角半径
        // bezierPath = [UIBezierPath bezierPathWithRoundedRect:imageView2.bounds cornerRadius:20.0];
        // 绘制圆
        // bezierPath = [UIBezierPath bezierPathWithOvalInRect:imageView2.bounds];
        // 初始化shapeLayer
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        // 设置绘制路径
        shapeLayer.path = bezierPath.CGPath;
        // 将shapeLayer设置为imageView2的layer的mask(遮罩)
        _tableView.layer.mask = shapeLayer;
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf.tableView.mj_footer endRefreshing];
//            !weakSelf.refreshFooter ? : weakSelf.refreshFooter();
//        }];
    }
    return _tableView;
}
- (NSMutableArray *)dataSourceArr{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

- (SSKJ_lookAcountHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[SSKJ_lookAcountHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-ScaleW(20), ScaleW(184))];
        _headerView.backgroundColor = kMainColor;
    }
    return _headerView;
}

@end
