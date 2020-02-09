//


#import "SuperCate_ViewController.h"
#import "SuperDetail_ViewController.h"
#import "MainList_CollectionViewCell.h"
#define kPageSize @"15"
@interface SuperCate_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UITextField *titleTf;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *allGoodsArray;

@end

@implementation SuperCate_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kSubBackgroundColor;
    [self.view addSubview:self.collectionView];

    
}
-(void)setCate_id:(NSString *)cate_id
{
    _cate_id = cate_id;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    self.page = 1;
    [self RequstshopAllGoosList];
}
-(void)setNaviBarItem
{
    [self setNavgationBackgroundColor:kMainRedColor alpha:1];
    [self addRightNavItemWithTitle:SSKJLocalized(@"取消", nil) color:kMainWihteColor font:systemFont(ScaleW(16))];
    
    
}
-(void)rigthBtnAction:(id)sender{
    
}
-(UITextField *)titleTf
{
    if (!_titleTf) {
        _titleTf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, ScaleW(290), ScaleW(40))];
        _titleTf.layer.cornerRadius = ScaleW(20);
        _titleTf.backgroundColor = kWhiteColorHaveClear;
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        leftBtn.frame = CGRectMake(0, 0, ScaleW(44), ScaleW(40));
        
        [leftBtn btn:leftBtn font:ScaleW(0) textColor:kMainWihteColor text:@"" image:[UIImage imageNamed:@""] sel:@selector(leftAction:) taget:self];
    }
    return _titleTf;
}

-(void)leftAction:(UIButton *)sender
{
    
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScreenWidth, ScreenHeight  - Height_TabBar) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kMainColor;
        if (@available(iOS 11.0, *)){
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
//        layout.minimumLineSpacing = 0.f;
//        layout.minimumInteritemSpacing = ScaleW(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(ScreenWidth, ScaleW(145+32));
        layout.sectionInset = UIEdgeInsetsMake(0, ScaleW(0), 0, ScaleW(0));
        
        [_collectionView registerClass:[MainList_CollectionViewCell class] forCellWithReuseIdentifier:@"MainList_CollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(ScaleW(0), 0, 0, 0);
        _collectionView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //            [weakSelf requstLongList];
            //            [weakSelf requestHeaderMoneyInfo];
            //            [weakSelf requestHeaderPeronalInfo];
            //            [weakSelf LongNoticeHttpRequst];
            self.page = 1;
    
            [self RequstshopAllGoosList];
            
            
        }];
        
        // _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //            [self RequstshopAllGoosListAdd];
        //        }];
        
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self RequstshopAllGoosListAdd];
        }];
        
    }
    return _collectionView;
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
#pragma mark ------requset

-(void)RequstshopAllGoosList{
    //AB_Shop_slide_list_post
    
    self.page = 1;
    NSDictionary *pamas = @{@"p":@(self.page),@"size":kPageSize,@"type":_cate_id};
    
    SsLog(@"pamas:::%@",pamas);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kTransshopcate_list_url RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        
        [self.collectionView.mj_header endRefreshing];
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            [self.allGoodsArray removeAllObjects];
            
            [self.allGoodsArray addObjectsFromArray:[netWorkModel.data objectForKey:@"goods"]];
            
            [SSKJ_NoDataView showNoData:self.allGoodsArray.count toView:self.view offY:0];
            
            [self.collectionView reloadData];
            
        }
        
        else
        {
            [self.collectionView reloadData];

        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)RequstshopAllGoosListAdd{
    //AB_Shop_slide_list_post
    
    self.page ++;
    if (_cate_id==nil) {
        
        NSLog(@"ddddd");
        
        return;
    }
    NSDictionary *pamas = @{@"p":@(self.page),@"size":kPageSize,@"type":_cate_id};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kTransshopcate_list_url RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [self.collectionView.mj_footer endRefreshing];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            [self.allGoodsArray addObjectsFromArray:[netWorkModel.data objectForKey:@"goods"]];
            [SSKJ_NoDataView showNoData:self.allGoodsArray.count toView:self.view offY:0];
            [self.collectionView reloadData];
            
        }
        
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(NSMutableArray *)allGoodsArray
{
    if (!_allGoodsArray) {
        _allGoodsArray = [NSMutableArray array];
        
    }
    return _allGoodsArray;
}
@end
