//
//  YLJShopRootViewController.m
//  SSKJ
//
//  Created by cy5566 on 2019/11/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YLJShopRootViewController.h"
#import "SuperDetail_ViewController.h"
#import "LA_MainShopCollectionCell.h"
#import "LA_MainShopHeaderView.h"
#import "YLJ_MainShopTopModel.h"
#import "LA_MainShopHotListModel.h"
#import "Shop_OrderListViewController.h"

#define kPageSize @"100"

@interface YLJShopRootViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@property (nonatomic, copy) NSArray *topArray;
@property (nonatomic, assign) BOOL isHeader;

@property (nonatomic, assign) NSInteger page;

@end

@implementation YLJShopRootViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.barTintColor = kTheMeColor;
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    statusBar.backgroundColor = [UIColor clearColor];
    self.page = 1;
    [self headerRefresh];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"ylj_shop_dingdan"]];
    self.title = SSKJLocalized(@"商城", nil);
    [self setupUI];
    
}

- (void)setupUI {
    [self.view addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScaleW(0));
        make.right.mas_equalTo(ScaleW(0));
        make.height.mas_equalTo(ScreenHeight - Height_NavBar - Height_TabBar - ScaleW(5));
        make.top.mas_equalTo(ScaleW(5));
    }];
    self.page = 1;
}

#pragma mark collectionViewdelegate

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LA_MainShopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LA_MainShopCollectionCell" forIndexPath:indexPath];
    cell.lModel = self.dataSourceArray[indexPath.row];
    cell.backBtn.tag = 1000 + indexPath.row;
    [cell.backBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//内容整体边距设置:整体边距的优先级，始终高于内部边距的优先级
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //{top, left, bottom, right}
    return UIEdgeInsetsMake(ScaleW(10), ScaleW(15), ScaleW(10), ScaleW(15));
    
}


// 要先设置表头大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(ScreenWidth , ScaleW(445));
}



//段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    LA_MainShopHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"LA_MainShopHeaderView" forIndexPath:indexPath];
    if (self.topArray.count > 0) {
        view.dataSourceArray = self.topArray;
    }
    view.guanggaoBlock = ^{
        if (!kLogin) {
            [MBProgressHUD showError:@"请先登录"];
            [self presentLoginController];
            return;
        }
        [self.tabBarController setSelectedIndex:2];
    };
    view.selectBlock = ^(NSInteger index) {
        LA_MainShopHotListModel *model = self.topArray[index];
        SuperDetail_ViewController *dVC = [SuperDetail_ViewController new];
        dVC.shopId = model.goods_id;
        [weakSelf.navigationController pushViewController:dVC animated:YES];
    };
    
    
    return view;
}

- (void)btnAction:(UIButton *)sender {
    NSInteger index = sender.tag - 1000;
    NSLog(@"点击了第%ld个按钮",index);
    LA_MainShopHotListModel *currentHotModel = self.dataSourceArray[index];
    SuperDetail_ViewController *dVC = [SuperDetail_ViewController new];
    dVC.shopId = currentHotModel.goods_id;
    [self.navigationController pushViewController:dVC animated:YES];
}

- (void)rigthBtnAction:(id)sender {
    if (!kLogin) {
        [MBProgressHUD showError:@"请先登录"];
        [self presentLoginController];
        return;
    }
    Shop_OrderListViewController *oVC = [Shop_OrderListViewController new];
    [self.navigationController pushViewController:oVC animated:YES];
}
#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    self.isHeader = YES;
    [self requestHotList];
    
//    if (self.catListArray.count == 0) {
//        [self requestCateList];
//    }
}

-(void)footerRefresh
{
    self.isHeader = NO;
    [self requestHotList];
}

-(void)endRefresh
{
    //    UITableView *tableView = _type == 0 ? self.teamTableView : self.incomeTableView;
    if (self.mainCollectionView.mj_header.state == MJRefreshStateRefreshing) {
        [self.mainCollectionView.mj_header endRefreshing];
    }
    
    if (self.mainCollectionView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.mainCollectionView.mj_footer endRefreshing];
    }
}

- (void)requestHotList{
    NSDictionary *params = @{
                             @"p":@(self.page),
                             @"size":kPageSize
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_goods_index RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf handleTeamDataWithModel:network_model];
        }else{
            [weakSelf endRefresh];
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf endRefresh];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}

-(void)handleTeamDataWithModel:(WL_Network_Model *)network_model
{
    
    NSArray *array = [LA_MainShopHotListModel mj_objectArrayWithKeyValuesArray:network_model.data[@"goods"]];
    NSArray *topThree;
    NSArray *remaining;
    if (array.count <= 3) {
        topThree = array;
        remaining = nil;
    } else {
        topThree = [array subarrayWithRange:NSMakeRange(0, 3)];
        remaining = [array subarrayWithRange:NSMakeRange(3, array.count-3)];
    }

    
    if (self.isHeader) {
        self.topArray = topThree;
    }
    if (self.page == 1) {
        [self.dataSourceArray removeAllObjects];
    }
    self.page++;
    [self.dataSourceArray addObjectsFromArray:remaining];

    if (array.count != kPageSize.integerValue) {
        self.mainCollectionView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.mainCollectionView.mj_footer.state = MJRefreshStateIdle;
    }

//        [SSKJ_NoDataView showNoData:self.dataSourceArray.count toView:self.mainCollectionView offY:ScaleW(50)];

    [self endRefresh];

    [self.mainCollectionView reloadData];
    
}

#pragma mark - layzyLoad
-(UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = ScaleW(10);
        layout.minimumInteritemSpacing = ScaleW(5);
        //滑动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(ScaleW(107),ScaleW(200));
        
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        //        _mainCollectionView.pagingEnabled = YES;
        [_mainCollectionView registerClass:[LA_MainShopCollectionCell class] forCellWithReuseIdentifier:@"LA_MainShopCollectionCell"];
        [_mainCollectionView registerClass:[LA_MainShopHeaderView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"LA_MainShopHeaderView"];
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        WS(weakSelf);
        _mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        _mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
    }
    return _mainCollectionView;
}



- (NSMutableArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = @[].mutableCopy;
    }
    return _dataSourceArray;
}

@end
