

#import "SuperHot_ViewController.h"
#import "MainList_CollectionViewCell.h"
#import "SuperDetail_ViewController.h"
#define kPageSize @"100"

@interface SuperHot_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UITextField *titleTf;

@property (nonatomic, strong) NSMutableArray *allGoodsArray;

@property (nonatomic, assign) NSInteger page;



@end

@implementation SuperHot_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kSubBackgroundColor;
    [self.view addSubview:self.collectionView];
    self.title = SSKJLocalized(@"热门商品", nil);
    
}
-(void)setNaviBarItem
{
//    [self setNavgationBackgroundColor:kMainRedColor alpha:1];
//    [self addRightNavItemWithTitle:@"取消" color:kMainWihteColor font:systemFont(ScaleW(16))];
    
    
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
        _collectionView.backgroundColor = kNavBGColor;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

        if (@available(iOS 11.0, *)){
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = ScaleW(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(ScreenWidth, ScaleW(145+32));
        layout.sectionInset = UIEdgeInsetsMake(ScaleW(0), ScaleW(0), ScaleW(0), ScaleW(0));
        [_collectionView registerClass:[MainList_CollectionViewCell class] forCellWithReuseIdentifier:@"MainList_CollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(ScaleW(15), 0, 0, 0);
        WS(weakSelf);
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
             [weakSelf RequstshopAllGoosList];
        }];
        self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf RequstshopAllGoosListAdd];
        }];
         _collectionView.mj_header.ignoredScrollViewContentInsetTop = _collectionView.contentInset.top;
        
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
-(NSMutableArray *)allGoodsArray
{
    if (!_allGoodsArray) {
        _allGoodsArray = [NSMutableArray array];
    }
    return _allGoodsArray;
}

-(void)RequstshopAllGoosList{
    //AB_Shop_slide_list_post
    
    WS(weakself);
    
    self.page = 1;
    NSDictionary *pamas = @{@"p":@(self.page),@"size":kPageSize};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_goods_index RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            [self.allGoodsArray removeAllObjects];
            
            NSArray *array=[netWorkModel.data objectForKey:@"goods"];
          
                
            [self.allGoodsArray addObjectsFromArray:array];
            [self.collectionView reloadData];

         
        }
        
        else
        {
            
        }
        
        
        
        if (self.allGoodsArray.count == 0) {
            
            [SSKJ_NoDataView showNoData:NO toView:self.view offY:0];
            
        }
        [weakself endRefresh];
        
        // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [weakself endRefresh];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)RequstshopAllGoosListAdd{
    //AB_Shop_slide_list_post
    WS(weakself);
    
    self.page ++;
    NSDictionary *pamas = @{@"p":@(self.page),@"size":kPageSize};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_goods_index RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [self.collectionView.mj_footer endRefreshing];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            NSArray *array=[netWorkModel.data objectForKey:@"goods"];
            
            
            [self.allGoodsArray addObjectsFromArray:array];
            
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.page = 1;
    [self RequstshopAllGoosList];
}
@end
