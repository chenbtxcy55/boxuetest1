
#import "SuperSearchViewController.h"
#import "SuperDetail_ViewController.h"
#import "MainList_CollectionViewCell.h"
#define kPageSize @"100"
@interface SuperSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITextField *titleTf;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *allGoodsArray;


@end

@implementation SuperSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kSubBackgroundColor;
    [self.view addSubview:self.collectionView];
    self.title = @"热门商品";
    [self setNaviBarItem];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.page = 1;
    //[self RequstshopAllGoosList];
   [self setNaviBarItem];
}
-(void)RequstshopAllGoosList{
    //AB_Shop_slide_list_post
    
    if (_titleTf.text.length == 0) {
        [SSKJ_NoDataView showNoData:NO toView:self.view offY:0];
        return;
    }
    NSDictionary *pamas = @{@"page":@(self.page),@"pageSize":kPageSize,@"keyword":_titleTf.text};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_goods_index RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            [self.allGoodsArray removeAllObjects];
            [self.allGoodsArray addObjectsFromArray:netWorkModel.data];
            [self.collectionView reloadData];
            [SSKJ_NoDataView showNoData:self.allGoodsArray toView:self.view offY:0];
        }
        
        else
        {
            
        }
         //[MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)setNaviBarItem
{
    [self setNavgationBackgroundColor:kNavBGColor alpha:1];
    [self addRightNavItemWithTitle:SSKJLocalized(@"搜索", nil) color:kMainWihteColor font:systemFont(ScaleW(16))];
    
    self.navigationItem.titleView = self.titleTf;
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left_my_baise"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem = bar;
    
   
}
-(void)leftBarButtonItemAction
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)rigthBtnAction:(id)sender{
    
    [self RequstshopAllGoosList];

}
-(UITextField *)titleTf
{
    if (!_titleTf) {
        _titleTf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, ScaleW(250), 30)];
        _titleTf.layer.cornerRadius = ScaleW(15);
        _titleTf.backgroundColor = kWhiteColorClear;
        
        [_titleTf textField:_titleTf textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:SSKJLocalized(@"搜索", nil) textColor:kMainWihteColor placeHolderTextColor:kMainWihteColor];
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        leftBtn.frame = CGRectMake(0, 0, ScaleW(44), ScaleW(35));
        
        [leftBtn btn:leftBtn font:ScaleW(0) textColor:kMainWihteColor text:@"" image:[UIImage imageNamed:@"icon_sousuo"] sel:@selector(leftAction:) taget:self];
        _titleTf.leftViewMode = UITextFieldViewModeAlways;
        
        _titleTf.leftView = leftBtn;
        
        _titleTf.delegate = self;
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
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(ScaleW(0), Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar - Height_TabBar) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kMainColor;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = ScaleW(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(ScaleW(168), ScaleW(250));
        layout.sectionInset = UIEdgeInsetsMake(0, ScaleW(13), 0, ScaleW(13));
        [_collectionView registerClass:[MainList_CollectionViewCell class] forCellWithReuseIdentifier:@"MainList_CollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(ScaleW(15), 0, 0, 0);
        
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
    vc.shopId = dic[@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSMutableArray *)allGoodsArray
{
    if (!_allGoodsArray) {
        _allGoodsArray = [NSMutableArray array];
    }
    return _allGoodsArray;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    [self RequstshopAllGoosList];
}
@end
