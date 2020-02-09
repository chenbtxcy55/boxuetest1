//
//  SearchViewController.m
//  准到-ipad
//
//  Created by zhundao on 2017/8/25.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchViewModel.h"
#import "AJSearchBar.h"
#import "SearchCollectionView.h"
#import "SearchFlowLayout.h"
#import "MainList_CollectionViewCell.h"
#import "SuperDetail_ViewController.h"
#define kPageSize @"100"
@interface SearchViewController ()<SearchDelegate,historyDelegate,UICollectionViewDelegate,UICollectionViewDataSource> {
    NSInteger row;
    
    UIButton *_deleteBt;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UITextField *titleTf;

@property (nonatomic, strong) NSMutableArray *allGoodsArray;

@property (nonatomic, assign) NSInteger page;

/*! 搜索框 */
@property(nonatomic,strong)AJSearchBar *searchBar;
/*! 搜索历史视图 */
@property(nonatomic,strong)SearchCollectionView *searchView;
/*! 布局 */
@property(nonatomic,strong)SearchFlowLayout *searchFlowLayout;
/*! SearchViewModel */
@property(nonatomic,strong)SearchViewModel *searchVM;
/*! 搜索历史label */
@property(nonatomic,strong)UILabel  *oldLabel;
/*! 垃圾桶 */
@property(nonatomic,strong)BigSizeButton *wastebutton;
/*! 数据源 */
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UILabel *leftLabel;

@property(nonatomic,strong)UILabel *noDataLabel;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden =YES;
    
    self.navigationController.navigationBar.translucent=NO;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

}
#pragma mark --- baseSetting

#warning 若控制位置不正确根据实际情况微调 这里有的不是自动布局


- (void)baseSetting{
    self.view.backgroundColor = kMainColor;
    _searchVM = [[SearchViewModel alloc]init];

    [self.view addSubview:self.searchBar];
    
    [self.view addSubview:self.oldLabel];
  

    [self.view addSubview:self.wastebutton];
    [self.view addSubview:self.leftLabel];
    [self wasteButtonFrame];
   
    [self.view addSubview:self.searchView];
    
  
    [self.view addSubview:self.collectionView];
    
    [self.view sendSubviewToBack:self.oldLabel];

    [self.view sendSubviewToBack:self.wastebutton];

    [self.view bringSubviewToFront:self.collectionView];
    [self.view addSubview:self.noDataLabel];

}

#pragma mark---懒加载 
- (AJSearchBar *)searchBar{
    if (!_searchBar) {
        WS(weakself);
        
        _searchBar = [[AJSearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Height_NavBar+ScaleW(1))];
        _searchBar.SearchDelegate = self;
        _searchBar.block = ^{
            
            
            [weakself.navigationController popViewControllerAnimated:YES];
            [weakself.searchBar removeFromSuperview];

            
        };
        
    }
    return _searchBar;
}

#warning tabbar为rootViewController 下面不加64
- (SearchCollectionView *)searchView{
    if (!_searchView) {
         row = [_searchVM rowForCollection:[_searchVM readHistory]];
        NSLog(@"row = %li",(long)row);
        _searchFlowLayout = [[SearchFlowLayout alloc]init];
        _searchView = [[SearchCollectionView alloc]initWithFrame:CGRectMake(0, Height_NavBar+ScaleW(15)+16, ScreenWidth, ((row+1) * 70)+64) collectionViewLayout:_searchFlowLayout array:[[_searchVM readHistory] mutableCopy]];
        _searchView.historyDelegate = self;
       
    }
    return _searchView;
}

- (UILabel *)oldLabel{
    if (!_oldLabel&&[_searchVM readHistory].count>0) {
        _oldLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _searchBar.bottom+ScaleW(15), 100, 15)];
        _oldLabel.text = SSKJLocalized(@"搜索历史", nil);
        _oldLabel.font = [UIFont systemFontOfSize:12];
        _oldLabel.textColor=kMainTextColor;
        
    }
    return _oldLabel;
}

-(UILabel*)noDataLabel
{
    if (_noDataLabel==nil) {
        _noDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _searchBar.bottom+ScaleW(15), 200, 20)];
        _noDataLabel.text = SSKJLocalized(@"暂无相关搜索结果", nil);
        _noDataLabel.textAlignment = NSTextAlignmentLeft;
        _noDataLabel.font = [UIFont systemFontOfSize:15];
        _noDataLabel.textColor=kMainTextColor;
//        _noDataLabel.backgroundColor  = [UIColor redColor];
        _noDataLabel.hidden = YES;
        
    }
    
    return _noDataLabel;
}
- (BigSizeButton *)wastebutton{
    if (!_wastebutton&&[_searchVM readHistory].count>0) {
        _wastebutton = [[BigSizeButton alloc]initWithFrame:CGRectZero];
        [_wastebutton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Search-Waste" ofType:@".png"]] forState:UIControlStateNormal];
        [_wastebutton addTarget:self action:@selector(deleteAll) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteBt=[UIButton new];
        
        [self.view addSubview:_deleteBt];
        
        [_deleteBt mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.view).offset(-ScaleW(15));
            
            make.width.mas_equalTo(25);
            
            make.height.mas_equalTo(15);
            
            make.top.equalTo(self.view).offset(Height_NavBar+ScaleW(15));
            
        }];
        
        [_deleteBt setTitle:SSKJLocalized(@"清空", nil) forState:UIControlStateNormal];
        
        _deleteBt.titleLabel.font=systemFont(11);
        
        [_deleteBt setTitleColor:kMainTextColor forState:UIControlStateNormal];
        
         [_deleteBt addTarget:self action:@selector(deleteAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wastebutton;
    
}
#pragma mark --- 布局

- (void)wasteButtonFrame{
    __weak typeof(self) weakSelf = self;
    [_wastebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.oldLabel);
        
        make.right.equalTo(weakSelf.view).offset(-50);
        
        make.size.mas_equalTo(CGSizeMake(22, 17));
        
    }];
}


#pragma mark --- SearchDelegate
/*! 新增历史搜索 */
- (void)searchWithStr:(NSString *)text{
    /*! 保存历史数据 */
    
     [self search:text];
    
    if ([_searchVM readHistory].count==0) {
        
        [self.view addSubview:self.oldLabel];
        
        [self.view addSubview:self.wastebutton];
        
        [self wasteButtonFrame];
        
          [self reloadView:text];
        
    }
    else{
        
        [self reloadView:text];
    }
    
//    [self.collectionView reloadData];
    
   
    
}
- (void)reloadView :(NSString *)text{
    
    [_searchVM saveHistory:text];
    
    _searchView.dataArray = [[_searchVM readHistory] mutableCopy];
    
    for (NSString *str in _searchView.dataArray) {
        
        NSLog(@"str::::%@",str);
    }
    
    [self updataFrame];
    
    [_searchView reloadData];
    
    
}



- (void)updataFrame{
    
    row = [_searchVM rowForCollection:[_searchVM readHistory]];
    
    NSLog(@"row:::%ld",row);
    
    
    _searchView.frame = CGRectMake(0, Height_NavBar+ScaleW(15)+16, ScreenWidth, ( (row+1) * 70)+64);
    
    
    
}





#pragma mark-----------------搜索
- (void)qingChu{
    [self.allGoodsArray removeAllObjects];
    [self.collectionView reloadData];
    if ([_searchVM readHistory].count !=0) {
        
        [self.view addSubview:self.oldLabel];
        
        [self.view addSubview:self.wastebutton];
        
        [self wasteButtonFrame];
        
        [self updataFrame];
        self.wastebutton.hidden=NO;
        self.oldLabel.hidden=NO;
            _deleteBt.hidden=NO;
        self.noDataLabel.hidden = YES;
    }
   
   
 
    
    self.collectionView.hidden=YES;
    
}
/*! 搜索关键词 */
- (void)search:(NSString *)text{
    NSLog(@"开始搜索%@",text);
   
    
    [_searchVM saveHistory:text];
    
 
   
    
    self.page = 1;
    if (text.length == 0) {
        
        showAlert(@"请输入搜索内容");
        
        return;
    }
    self.wastebutton.hidden=YES;
    self.oldLabel.hidden=YES;
    _deleteBt.hidden=YES;
    self.noDataLabel.hidden = YES;

    _collectionView.hidden=NO;

    NSString *count=[[SSKJ_User_Tool sharedUserTool] getAccount];
    SsLog(@"count:::%@",count);

    NSDictionary *pamas = @{@"keyword":text,@"account":count};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KGoods_search RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            [self.allGoodsArray removeAllObjects];
            [self.collectionView reloadData];
            if ([netWorkModel.data isKindOfClass:[NSDictionary class]]) {
                
                if([[netWorkModel.data allKeys] containsObject:@"result"] )
                {
                   

                    NSArray *array=[netWorkModel.data objectForKey:@"result"];
                    
                
                    if (array.count) {
                        
                        [self.allGoodsArray addObjectsFromArray:array];
                        
                    }
                    
                    if (self.allGoodsArray.count>0) {
                        self.noDataLabel.hidden = YES;

                        
                    }
                    else
                    {
                        self.noDataLabel.hidden = NO;
                        [self.view bringSubviewToFront:self.noDataLabel];
                    }
                   

                }
                
            }
            
            
        }
        
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
        //
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}







#pragma mark --- historyDelegate
/*! 删除搜索历史 */
- (void)delete :(NSString *)text
{
//    ! 删除沙盒数据
    [_searchVM deleteHistory:text];
    /*! 刷新本地视图 */
    [_searchView.dataArray removeObject:text];
    /*! 是否删除垃圾桶和label */
    [self deleteOther];
    [_searchView reloadData];
}
/*! 移除控件 */
- (void)deleteOther {
    if ([_searchVM readHistory].count==0) {
        [_oldLabel removeFromSuperview];
        [_wastebutton removeFromSuperview];
        [_deleteBt removeFromSuperview];

    }
    [self updataFrame];
}
/*! cell选中搜索 */
- (void)select :(NSString *)text{
    
    _searchBar.name=text;
    [self.dataArray removeAllObjects];
    
    [self.collectionView reloadData];
    
    
    [self search:text];
}

#pragma mark  ---- 垃圾桶按钮删除历史记录

- (void)deleteAll{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:SSKJLocalized(@"亲,确定清空吗?要三思啊", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:SSKJLocalized(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /*! 删除所有历史记录 */
        [self->_searchVM deleteHistory:@""];
        [self deleteOther];
        [self->_searchView.dataArray removeAllObjects];
        [self->_searchView reloadData];
    }]];
    alert.modalPresentationStyle = UIModalPresentationFullScreen;

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark---网络判断

- (void)netWork:(NSString *)text{
    NSInteger status =  [[NSUserDefaults standardUserDefaults]integerForKey:@"ZDNet"];
    /*! 有网的结果 */
    if (status==1||status==2) [self haveNet:text];
    /*! 没有网的结果 */
    else [self NotNet:text];
}
/*! 有网搜索 */
- (void)haveNet:(NSString *)text{
    
}
/*! 没网 */
- (void)NotNet:(NSString *)text{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(ScaleW(0), _searchBar.bottom, ScreenWidth, ScreenHeight  - Height_TabBar-Height_NavBar) collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = kMainColor;
        
        layout.minimumLineSpacing = 0.f;
        
        layout.minimumInteritemSpacing = ScaleW(10);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(ScreenWidth, ScaleW(145+32));
        
        layout.sectionInset = UIEdgeInsetsMake(ScaleW(0), ScaleW(0), ScaleW(0), ScaleW(0));
        
        [_collectionView registerClass:[MainList_CollectionViewCell class] forCellWithReuseIdentifier:@"MainList_CollectionViewCell"];
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.contentInset = UIEdgeInsetsMake(ScaleW(15), 0, 0, 0);
        WS(weakSelf);
        
//        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf RequstshopAllGoosList];
//        }];
//
//        self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf RequstshopAllGoosListAdd];
//        }];
        
        _collectionView.hidden=YES;
        
        
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

-(void)RequstshopAllGoosList{
    //AB_Shop_slide_list_post
    
   
}
-(void)RequstshopAllGoosListAdd{
    //AB_Shop_slide_list_post
    
    self.page ++;
    NSDictionary *pamas = @{@"p":@(self.page),@"size":kPageSize};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_goods_index RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [self.collectionView.mj_footer endRefreshing];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.allGoodsArray removeAllObjects];
        
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            NSArray *array=[netWorkModel.data objectForKey:@"goods"];
            
            
            [self.allGoodsArray addObjectsFromArray:array];
            
            
        }
        
        [self.collectionView reloadData];

         [MBProgressHUD showError:netWorkModel.msg];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


@end
