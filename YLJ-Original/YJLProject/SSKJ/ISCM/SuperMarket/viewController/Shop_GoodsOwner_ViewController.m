//
//  Shop_GoodsOwner_ViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/14.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_GoodsOwner_ViewController.h"
#import "MainList_CollectionViewCell.h"
#import "SuperDetail_ViewController.h"

#import "ContectShopViewController.h"
#define kPageSize  @"30"
@interface Shop_GoodsOwner_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>
{
    NSMutableArray *_bannerArray;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *allGoodsArray;
@property (nonatomic, strong) SDCycleScrollView *headerView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIView *contenHeader;

@property (nonatomic, strong) NSMutableArray *bannerArray;

@end

@implementation Shop_GoodsOwner_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    [self addRightNavItemWithTitle:SSKJLocalized(@"详情", nil) color:kMainTextColor font:systemFont(15)];
}
-(void)rigthBtnAction:(id)sender{
    ContectShopViewController *vc = [[ContectShopViewController alloc]init];
    vc.dataDic = _dataDic;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView *)contenHeader
{
    if (!_contenHeader) {
        _contenHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(200))];
        [_contenHeader addSubview:self.headerView];
        [_contenHeader addSubview:self.backView];
        _contenHeader.height = self.backView.bottom;
        _contenHeader.frame = CGRectMake(0, -_contenHeader.height, [UIScreen mainScreen].bounds.size.width, _contenHeader.height);
        _contenHeader.backgroundColor = kNavBGColor;
    }
    return _contenHeader;
}
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(20) + _headerView.bottom, ScreenWidth, ScaleW(45))];
        _backView.backgroundColor = kNavBGColor;
        UILabel *hotTitle = [WLTools allocLabel:SSKJLocalized(@"热门商品", nil) font:systemFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(60), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        UILabel *subTile = [WLTools allocLabel:SSKJLocalized(@"（海量特价商品）", nil) font:systemFont(ScaleW(10)) textColor:kSubTxtColor frame:CGRectMake(hotTitle.right, ScaleW(20), ScaleW(100), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        [_backView addSubview:hotTitle];
        [_backView addSubview:subTile];
    }
    return _backView;
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScreenWidth, ScreenHeight - Height_NavBar ) collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = kNavBGColor;
        
        layout.minimumLineSpacing = 0.f;
        
        layout.minimumInteritemSpacing = ScaleW(10);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout.itemSize = CGSizeMake(ScreenWidth, ScaleW(145+32));
        
        layout.sectionInset = UIEdgeInsetsMake(0, ScaleW(0), 0, ScaleW(0));
        
        [_collectionView registerClass:[MainList_CollectionViewCell class] forCellWithReuseIdentifier:@"MainList_CollectionViewCell"];
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.contentInset = UIEdgeInsetsMake(self.contenHeader.height, 0, 0, 0);
        [_collectionView addSubview:self.contenHeader];
        
        _collectionView.alwaysBounceVertical = YES;  // 垂直// 水平
//        WS(weakSelf);
//        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//            self.page=1;
//
//            [weakSelf RequstshopAllGoosList];
//        }];
//        self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//            self.page+=1;
//
//            [weakSelf RequstshopAllGoosList];
//
//        }];
    }
    
    return _collectionView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.page=1;
    
    [self RequstshopAllGoosList];
    
    [self requstLunbo];
}
#pragma mark - 头部轮播视图
-(SDCycleScrollView *)headerView
{
    if (_headerView==nil)
    {
        
        _headerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ScaleW(15),ScaleW(0), ScreenWidth - ScaleW(30), ScreenWidth - ScaleW(30)) delegate:self placeholderImage:nil];
        
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        _headerView.delegate = self;
        
        _headerView.layer.cornerRadius = ScaleW(10);
        
        _headerView.layer.masksToBounds = YES;
        
        _headerView.backgroundColor = kSubBackgroundColor;
        
        _headerView.autoScrollTimeInterval = 3.0;
        
        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
        _headerView.currentPageDotColor = kMainRedColor;
        
        _headerView.pageDotColor = kMainWihteColor;
        
        _headerView.currentPageDotImage = [UIImage imageNamed:@"banner_selected"];
        
        _headerView.pageDotImage = [UIImage imageNamed:@"banner_normal"];
        
        
    }
    
    return _headerView;
}

#pragma mark collectionViewdelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allGoodsArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainList_CollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainList_CollectionViewCell" forIndexPath:indexPath];
    //    Market_Main_List_Model * model =  _colictionViewArray [indexPath.row];
    collectionCell.dataDic = self.allGoodsArray[indexPath.row];
    return collectionCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.allGoodsArray[indexPath.row];
    
    SuperDetail_ViewController *vc = [[SuperDetail_ViewController alloc]init];
    
    vc.shopId = dic[@"goods_id"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray *)allGoodsArray{
    if (!_allGoodsArray) {
        _allGoodsArray = [NSMutableArray array];
        
    }
    return _allGoodsArray;
}
//AB_Shop_owner_goods_index
-(void)RequstshopAllGoosList{
    //AB_Shop_slide_list_post
    
    WS(weakself);
    
    
    NSDictionary *pamas = @{@"page":@(self.page),@"pageSize":kPageSize,@"store_id":self.dataDic[@"store_id"]};
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_user_shop_goods_list RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            if (self
                .page ==1) {
                 [self.allGoodsArray removeAllObjects];
                
            }
           
            
            [self.allGoodsArray addObjectsFromArray:[netWorkModel.data objectForKey:@"store"]];
            
            [self.collectionView reloadData];
            
            
            
        }
        
        else
        {
            
        }
        
        [weakself endRefresh];
        
        // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakself endRefresh];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)endRefresh
{
    if (self.collectionView.mj_header.state == MJRefreshStateRefreshing) {
        [self.collectionView.mj_header endRefreshing];
    }
    
    if (self.collectionView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.collectionView.mj_footer endRefreshing];
    }
}
-(void)requstLunbo
{
    
    NSDictionary *pamas = @{@"store_id":self.dataDic[@"store_id"]};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_user_user_shop_info RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            self.headerView.imageURLStringsGroup = netWorkModel.data[@"pic_urls"];
            
            self.title = [NSString stringWithFormat:@"%@",netWorkModel.data[@"name"]];
            
        }
        
        else
        {
            
        }
        // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(NSMutableArray *)bannerArray
{
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}
-(void)setBannerArray:(NSMutableArray *)bannerArray
{
    _bannerArray = bannerArray;

}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
}

@end
