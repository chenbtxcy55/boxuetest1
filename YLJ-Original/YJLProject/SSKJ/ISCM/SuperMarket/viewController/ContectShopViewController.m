

#import "ContectShopViewController.h"
#import "MainList_CollectionViewCell.h"
#import "SuperDetail_ViewController.h"
#define kPageSize  @"30"
@interface ContectShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>
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

@property (nonatomic, strong) UILabel *contentTextLabel;

@property (nonatomic, strong) UIImageView *contextTelImg;
@property (nonatomic, strong) UIImageView *qqImg;

@property (nonatomic, strong) UILabel *ocntenTelLabel;

@property (nonatomic, strong) UIImageView *imageAddress;

@property (nonatomic, strong) UILabel *addrsssLabel;

@property (nonatomic, strong) UILabel *qqLabel;

@end

@implementation ContectShopViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.contenHeader];
    
    
}

-(UILabel *)contentTextLabel{
    if (!_contentTextLabel) {
        _contentTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15) + _headerView.bottom, ScreenWidth - ScaleW(30), ScaleW(200))];
        
        [_contentTextLabel label:_contentTextLabel font:ScaleW(15) textColor:kSubTxtColor text:@"--------"];
        
    }
    return _contentTextLabel;
}

-(UIImageView *)contextTelImg
{
    if (!_contextTelImg) {
        _contextTelImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _contentTextLabel.bottom, ScaleW(20), ScaleW(20))];
        _contextTelImg.image = [UIImage imageNamed:@"phoneIcon"];
    }
    return _contextTelImg;
}

-(UILabel *)ocntenTelLabel
{
    if (!_ocntenTelLabel) {
        _ocntenTelLabel = [[UILabel alloc
                            ]initWithFrame:CGRectMake(_contextTelImg.right + ScaleW(10), ScaleW(20)  + _contentTextLabel.bottom,ScreenWidth - _contextTelImg.right - ScaleW(10)- ScaleW(15) , ScaleW(13))];
        [_ocntenTelLabel label:_ocntenTelLabel font:ScaleW(13) textColor:kSubTxtColor text:@"联系电话：--------"];
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, _ocntenTelLabel.bottom-1, ScreenWidth, 1)];
        style.alpha = 1;
        [self.view addSubview:style];
        
    }
    return _ocntenTelLabel;
}
-(UIImageView *)qqImg
{
    if (!_qqImg) {
        _qqImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(20) + _ocntenTelLabel.bottom, ScaleW(20), ScaleW(20))];
        _qqImg.image = [UIImage imageNamed:@"qqIcon"];
    }
    return _qqImg;
}

-(UILabel *)qqLabel
{
    if (!_qqLabel) {
        _qqLabel = [[UILabel alloc
                            ]initWithFrame:CGRectMake(_qqImg.right + ScaleW(10), _qqImg.top,ScreenWidth - _qqImg.right - ScaleW(10)- ScaleW(15) , ScaleW(13))];
        [_qqLabel label:_qqLabel font:ScaleW(13) textColor:kSubTxtColor text:@"客服QQ：--------"];
       
    }
    return _qqLabel;
}

-(UIImageView *)imageAddress{
    if (!_imageAddress) {
        _imageAddress = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), _qqLabel.bottom + ScaleW(20), ScaleW(20), ScaleW(20))];
        //_imageAddress.backgroundColor = [UIColor purpleColor];
        _imageAddress.image = [UIImage imageNamed:@"adressIcon"];
    }
    return _imageAddress;
}
-(UILabel *)addrsssLabel
{
    if (!_addrsssLabel) {
        _addrsssLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(9) + _imageAddress.right, _imageAddress.top , ScreenWidth - _contextTelImg.right - ScaleW(10)- ScaleW(15), ScaleW(32))];
        //_addrsssLabel.backgroundColor = [UIColor purpleColor];
        _addrsssLabel.top = _imageAddress.top;
        
        [_addrsssLabel label:_addrsssLabel font:ScaleW(13) textColor:kSubTxtColor text:@"店铺地址：--------"];
        _addrsssLabel.numberOfLines = 2;
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, _addrsssLabel.bottom-1, ScreenWidth, 1)];
        style.alpha = 1;
        [self.view addSubview:style];
    }
    return _addrsssLabel;
}
-(UIView *)contenHeader
{
    if (!_contenHeader) {
        _contenHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _contenHeader.backgroundColor = kNavBGColor;
        
        [_contenHeader addSubview:self.headerView];
        //[_contenHeader addSubview:self.backView];
       
        [_contenHeader addSubview:self.contentTextLabel];
        [_contenHeader addSubview:self.contextTelImg];
        [_contenHeader addSubview:self.ocntenTelLabel];
        [_contenHeader addSubview:self.qqImg];
        [_contenHeader addSubview:self.qqLabel];
        [_contenHeader addSubview:self.imageAddress];
        [_contenHeader addSubview:self.addrsssLabel];
//         _contenHeader.height = self.addrsssLabel.bottom;
//        _contenHeader.frame = CGRectMake(0, -_contenHeader.height, [UIScreen mainScreen].bounds.size.width, _contenHeader.height);
//        self.view.backgroundColor=kMainWihteColor;

    }
    return _contenHeader;
}
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(20) + _headerView.bottom, ScreenWidth, ScaleW(34))];
        _backView.backgroundColor = kMainWihteColor;
        UILabel *hotTitle = [WLTools allocLabel:SSKJLocalized(@"热门商品", nil) font:systemBoldFont(ScaleW(14)) textColor:kMainTextColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(60), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
        UILabel *subTile = [WLTools allocLabel:SSKJLocalized(@"（海量特价商品）", nil) font:systemFont(ScaleW(10)) textColor:kSubSubTxtColor frame:CGRectMake(hotTitle.right, ScaleW(20), ScaleW(100), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        [_backView addSubview:hotTitle];
        [_backView addSubview:subTile];
    }
    return _backView;
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScreenWidth, ScreenHeight ) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kMainWihteColor;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = ScaleW(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(ScaleW(168), ScaleW(250));
        layout.sectionInset = UIEdgeInsetsMake(ScaleW(13), ScaleW(13), ScaleW(13), ScaleW(13));
        [_collectionView registerClass:[MainList_CollectionViewCell class] forCellWithReuseIdentifier:@"MainList_CollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.contentInset = UIEdgeInsetsMake(self.contenHeader.height, 0, 0, 0);
        [_collectionView addSubview:self.contenHeader];
        _collectionView.alwaysBounceVertical = YES;  // 垂直// 水平
        
    }
    return _collectionView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
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
        
        _headerView.backgroundColor = kNavBGColor;
        
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
    vc.shopId = dic[@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray *)allGoodsArray{
    if (!_allGoodsArray) {
        _allGoodsArray = [NSMutableArray array];
        
    }
    return _allGoodsArray;
}

-(void)requstLunbo
{
    
    NSDictionary *pamas = @{@"store_id":self.dataDic[@"store_id"]};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kowner_shopuser_shop_info RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            
            self.headerView.imageURLStringsGroup = netWorkModel.data[@"pic_urls"];
//            id": "17",
//            "name": "Tes1",
//            "account": "246421214",
//            "phone": "176102999881",
//            "qq": "132132132",
//            "address": "葫芦岛无奇穷111fdsafdsafsad",
//            "detail": "啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊1\nFdasfasfdsa\nFdsafssa fdssa\n12313",
            self.title = [NSString stringWithFormat:@"%@",netWorkModel.data[@"name"]];
            
            
            
            self.contentTextLabel.text =[NSString stringWithFormat:@"%@",netWorkModel.data[@"detail"]];
        
            
            self.ocntenTelLabel.text =[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"联系电话:", nil), netWorkModel.data[@"phone"]];
            
            self.qqLabel.text=[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"客服QQ:", nil), netWorkModel.data[@"qq"]];
            
            self.addrsssLabel.text = [NSString stringWithFormat:@"%@%@",SSKJLocalized(@"详细地址:", nil),netWorkModel.data[@"address"]];
            
            self.contentTextLabel.numberOfLines = 0;
            
            [self.contentTextLabel sizeToFit];
            
            self.contextTelImg.top = ScaleW(20) + self.contentTextLabel.bottom;
            
            self.ocntenTelLabel.centerY = self.contextTelImg.centerY;
            
            UILabel *line = [UILabel new];
            
            
            [self->_contenHeader addSubview:line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.right.equalTo(self.view);
                
                make.height.mas_equalTo(1);
                
                make.top.equalTo(self.ocntenTelLabel.mas_bottom).offset(ScaleW(10));
                
            }];
            
            self.qqImg.top=ScaleW(20) + self.ocntenTelLabel.bottom;
            
            self.qqLabel.top=self.qqImg.top+ScaleW(3);
            
            UILabel *line2 = [UILabel new];
            
            [self->_contenHeader addSubview:line2];
            
            [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.equalTo(self.view);
                
                make.height.mas_equalTo(1);
                
            make.top.equalTo(self.qqLabel.mas_bottom).offset(ScaleW(9));;
                
            }];
            self.imageAddress.top =  self.qqLabel.bottom + ScaleW(25);
            
            self.addrsssLabel.top = self.imageAddress.top;
            
            [self.addrsssLabel sizeToFit];
            
//            self.contenHeader.height = self.addrsssLabel.bottom;
         
            
            UILabel *line3 = [UILabel new];
            
            [self->_contenHeader addSubview:line3];
            
            
            [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.equalTo(self.view);
                
                make.height.mas_equalTo(1);
                
                make.top.equalTo(self.addrsssLabel.mas_bottom).offset(ScaleW(10));;
                
            }];
            
           
            UILabel *line4 = [UILabel new];
            
            [self->_contenHeader addSubview:line4];
            
            
            [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.equalTo(self.view);
                
                make.height.mas_equalTo(1);
                
                make.bottom.equalTo(self.ocntenTelLabel.mas_top).offset(-ScaleW(10));
                
            }];
            line.backgroundColor=UIColorFromRGB(0x353750);
            line2.backgroundColor=UIColorFromRGB(0x353750);
            line3.backgroundColor=UIColorFromRGB(0x353750);
            line4.backgroundColor=UIColorFromRGB(0x353750);

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
