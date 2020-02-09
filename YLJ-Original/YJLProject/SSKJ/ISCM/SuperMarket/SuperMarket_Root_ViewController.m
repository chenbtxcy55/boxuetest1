//
//  SuperMarket_Root_ViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/5.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SuperMarket_Root_ViewController.h"
#import "SuperHot_ViewController.h"
#import "Super_Notifacation_ViewController.h"
#import "SuperDetail_ViewController.h"
#import "Money_getmoney_ViewController.h"
#import "Shop_Root_ViewController.h"
#import "SuperSearchViewController.h"
#import "SuperCate_ViewController.h"
#import "CXShop_ViewController.h"
#import "SearchViewController.h"
#import "SuperRootHeaderView.h"
#import "MainList_CollectionViewCell.h"
#import "SuperCate_ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "EAEScanVC.h"
#import "MyButton.h"
#import "JB_Login_ViewController.h"
#import "SSKJ_BaseNavigationController.h"

#define kPageSize @"100"


@interface SuperMarket_Root_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SuperRootHeaderView *headerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *kindsArray;
@property (nonatomic, strong) NSMutableArray *allGoodsArray;
//@property (nonatomic, strong)  Money_paymoney_ViewController * payVc;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *noticeArray;


@end

@implementation SuperMarket_Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.collectionView];
    self.page = 1;
//    [self checkVersion];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self setNavigationView];
//    [self requstShopBannerRodeKinds];
//    [self RequstshopAllGoosList];
//    [self requstNoceHttp];
    [self requstUserInfor];
    [self requstShopBannerRode];

    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.translucent=NO;

    self.page = 1;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

//   [self setNavgationBackgroundColor:kMainWihteColor alpha:1];
}
-(SuperRootHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[SuperRootHeaderView alloc]init];
         _headerView.frame = CGRectMake(0, -_headerView.height, [UIScreen mainScreen].bounds.size.width, _headerView.height);
        WS(weakSelf);
        _headerView.hotBlock = ^{
            SuperHot_ViewController *vc = [[SuperHot_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _headerView.notifacationBlock = ^{
            Super_Notifacation_ViewController *vc = [[Super_Notifacation_ViewController alloc]init];
            vc.isShop=YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };

        _headerView.naviClickBlock = ^(NSInteger type) {
            
            if (!kLogin) {
                
                [weakSelf presentLoginController];
                
                return ;
            }
            
            if (type ==0) {
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            if (type ==1) {
                
                SearchViewController *vc = [[SearchViewController alloc]init];
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            if (type ==2) {
                
//                if (!kLogin) {
//                    
//                JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
//                    
//                SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:vc];
//                    
//                [weakSelf.navigationController presentViewController:naviVC animated:YES completion:^{
//                    
//                            }];
//                    return;
//                    
//                }
                Shop_Root_ViewController *vc=[Shop_Root_ViewController new];
                
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }
     
        };
#pragma makr 类别商品
        _headerView.cateReteBlock = ^(NSDictionary * _Nonnull cate_id) {
            if (!kLogin) {
                
                [weakSelf presentLoginController];
                
                return ;
            }
            
            SuperCate_ViewController *vc = [[SuperCate_ViewController alloc]init];
            
            vc.cate_id = cate_id[@"type_id"];
            
            vc.title = cate_id[@"type_name"];
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
#pragma mark 诚信商铺
        
        _headerView.gotoBaussBlock = ^{
            if (!kLogin) {
                
                [weakSelf presentLoginController];
                
                return ;
            }
            
            CXShop_ViewController *vc = [[CXShop_ViewController alloc]init];
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
    }
    return _headerView;
}
-(void)setNavigationView
{
    
//    [self setNavgationBackgroundColor:RGBCOLOR(10, 113,210) alpha:1];
    
    UIButton *leftBtn = [MyButton buttonWithType:UIButtonTypeCustom];
     leftBtn.frame = CGRectMake(0, 0, ScaleW(40), ScaleW(40));
    [leftBtn btn:leftBtn font:ScaleW(15) textColor:kMainWihteColor text:nil image:[UIImage imageNamed:KLeftImgName] sel:@selector(leftAction:) taget:self];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0,     0, ScaleW(17), ScaleW(17))];
    image.image = [UIImage imageNamed:@"code_super"];
    image.centerX = ScaleW(20);
    
    UILabel *label1 = [WLTools allocLabel:SSKJLocalized(@"搜索", nil) font:systemFont(ScaleW(15)) textColor:kMainWihteColor frame:CGRectMake(image.right + ScaleW(60), 0, ScaleW(100), leftBtn.height) textAlignment:(NSTextAlignmentLeft)];
    [leftBtn addSubview:image];
    [leftBtn addSubview:label1];
    
   
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftBar;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, ScaleW(40), ScaleW(40));
    UIImageView *rimage = [[UIImageView alloc]initWithFrame:CGRectMake(0,     0, ScaleW(17), ScaleW(17))];
    rimage.image = [UIImage imageNamed:@"scanscan"];
    rimage.centerX = ScaleW(20);
    
    [right addSubview:rimage];
    
    UILabel *labelr = [[UILabel alloc]initWithFrame:CGRectMake(0, ScaleW(6) + image.bottom, leftBtn.width, ScaleW(10))];
    [labelr label:labelr font:ScaleW(10) textColor:kMainWihteColor text:SSKJLocalized(@"我的店铺", nil)];
    labelr.textAlignment = NSTextAlignmentCenter;
    
    [right addSubview:labelr];
    
    [right addTarget:self action:@selector(rightAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    UIButton *centerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    centerbtn.frame = CGRectMake(0, 0 , ScaleW(220), ScaleW(32));
    [centerbtn addTarget:self action:@selector(findAction:) forControlEvents:(UIControlEventTouchUpInside)];
    centerbtn.layer.cornerRadius = ScaleW(16);
    centerbtn.backgroundColor = kClearBackWhiteColor;
    UIImageView *findImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(8), ScaleW(17), ScaleW(17))];
    findImg.image = [UIImage imageNamed:@"icon_sousuo"];
    [centerbtn addSubview:findImg];
    self.navigationItem.titleView = centerbtn;
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(ScaleW(0), 0, ScreenWidth, ScreenHeight-Height_TabBar ) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kNavBGColor;
        if (@available(iOS 11.0, *)){
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = ScaleW(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
 layout.itemSize = CGSizeMake(ScreenWidth, ScaleW(145+32));        layout.sectionInset = UIEdgeInsetsMake(ScaleW(0), ScaleW(0), ScaleW(0), ScaleW(0));
        [_collectionView registerClass:[MainList_CollectionViewCell class] forCellWithReuseIdentifier:@"MainList_CollectionViewCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
       _collectionView.contentInset = UIEdgeInsetsMake(self.headerView.height, 0, 0, 0);
       [_collectionView addSubview:self.headerView];
        
        _collectionView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //            [weakSelf requstLongList];
            //            [weakSelf requestHeaderMoneyInfo];
            //            [weakSelf requestHeaderPeronalInfo];
            //            [weakSelf LongNoticeHttpRequst];
            self.page = 1;
//            [self setNavigationView];
            [self requstShopBannerRode];
//            [self requstShopBannerRodeKinds];
//            [self RequstshopAllGoosList];
//            [self requstNoceHttp];
//            [self requstUserInfor];
            
        }];
        

//        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [self RequstshopAllGoosListAdd];
//        }];
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
    if (!kLogin) {
        
        [self presentLoginController];
        
        return ;
    }
    
    NSDictionary *dic = self.allGoodsArray[indexPath.row];
    
    SuperDetail_ViewController *vc = [[SuperDetail_ViewController alloc]init];
    vc.shopId = dic[@"goods_id"];
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)findAction:(UIButton *)sender
{
    SearchViewController *vc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)leftAction:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightAction:(UIButton *)sender
{
 
    if (!kLogin) {
        
        JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
        
        SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:vc];
        naviVC.modalPresentationStyle = UIModalPresentationFullScreen;

        [self.navigationController presentViewController:naviVC animated:YES completion:^{
            
        }];
        return;
        
    }
    Shop_Root_ViewController *vc=[Shop_Root_ViewController new];
    

    [self.navigationController pushViewController:vc animated:YES];
    
//    self.payVc= [[Money_paymoney_ViewController alloc]init];
//    
//    NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//    [array insertObject:self.payVc atIndex:array.count - 1];
//    self.navigationController.viewControllers = array;
   
}
-(void)pushVc

{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        // app名称
        
        NSString *message = [NSString stringWithFormat:@"请在iPhone的\"设置\"-\"隐私\"-\"相机\"功能中，找到\"%@\"打开相机访问权限",@""];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:confirmAction];
        alert.modalPresentationStyle = UIModalPresentationFullScreen;

        [self.navigationController presentViewController:alert animated:YES completion:nil];
        
        return;
        
    };
    EAEScanVC *vcE = [[EAEScanVC alloc] init];
    WS(weakSelf);
    vcE.qrUrlBlock = ^(NSString *url) {
        if ([url hasPrefix:@"AB:"]) {
            //self.userId = [url substringFromIndex:3];
//            weakSelf.payVc.userId = [url substringFromIndex:3];
        }
        
    };
    
    [self.navigationController pushViewController:vcE animated:NO];
}

#pragma mark ------requset


-(void)requstShopBannerRode
{
    //AB_Shop_slide_list_post
    
       SsLog(@"baner");
    
        NSDictionary *pamas = @{};
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_slide_list_post RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
            WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([netWorkModel.status isEqualToString:@"200"]) {
                
                [self.bannerArray removeAllObjects];

                [self.bannerArray addObjectsFromArray:[netWorkModel.data objectForKey:@"pics"]];

                self.headerView.bannerArray = self.bannerArray;
                
                [self.kindsArray removeAllObjects];
                
                NSArray *array=[netWorkModel.data objectForKey:@"types"];
                
                [self.kindsArray addObjectsFromArray:array];
                
                self.headerView.kindsArray = self.kindsArray;
                
                [self.noticeArray removeAllObjects];
                
                [self.noticeArray addObjectsFromArray:[netWorkModel.data objectForKey:@"notices"]];
                
                self.headerView.noticeArray = self.noticeArray;
                
                [self.allGoodsArray removeAllObjects];
                
                [self.allGoodsArray addObjectsFromArray:[netWorkModel.data objectForKey:@"goods"]];
                
                [self.collectionView reloadData];
                
            }
           
            else
            {
                
            }
           // [MBProgressHUD showError:netWorkModel.msg];
//            [self.collectionView];

            [self.collectionView.mj_header endRefreshing];
            
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [self.collectionView.mj_header endRefreshing];

            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
}
//AB_Shop_cate_list_post列表分类
-(void)requstShopBannerRodeKinds
{
    //AB_Shop_slide_list_post
    
    
    NSDictionary *pamas = @{};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_cate_list_post RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            [self.kindsArray removeAllObjects];
            [self.kindsArray addObjectsFromArray:netWorkModel.data];
            self.headerView.kindsArray = self.kindsArray;
            
            [SSKJ_User_Tool sharedUserTool].typeArray = self.kindsArray;
        }
        
        else
        {
            
        }
       // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
//AB_Shop_owner_goods_index
-(void)requstNoceHttp{
    //AB_Shop_slide_list_post
    
    
    NSDictionary *pamas = @{};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KShopNoticeUrl RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            [self.noticeArray removeAllObjects];
            [self.noticeArray addObjectsFromArray:[netWorkModel.data objectForKey:@"notices"]];
            self.headerView.noticeArray = self.noticeArray;

        }
        
        else
        {
            
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
       // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

-(void)RequstshopAllGoosList{
    //AB_Shop_slide_list_post
    self.page = 1;
    
    NSDictionary *pamas = @{@"page":@(self.page),@"pageSize":kPageSize,@"hot":@"1"};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_goods_index RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            [self.allGoodsArray removeAllObjects];
            [self.allGoodsArray addObjectsFromArray:netWorkModel.data];
            [self.collectionView reloadData];
            
        }
        
        else
        {
            
           

        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)RequstshopAllGoosListAdd{
    //AB_Shop_slide_list_post
    
    self.page ++;
    NSDictionary *pamas = @{@"page":@(self.page),@"pageSize":kPageSize,@"hot":@"1"};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_goods_index RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [self.collectionView.mj_footer endRefreshing];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
          
            [self.allGoodsArray addObjectsFromArray:netWorkModel.data];
            [self.collectionView reloadData];
            
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

-(NSMutableArray *)kindsArray{
    if (!_kindsArray) {
        _kindsArray = [NSMutableArray array];
        
    }
    return _kindsArray;
}
-(NSMutableArray *)allGoodsArray{
    if (!_allGoodsArray) {
        _allGoodsArray = [NSMutableArray array];
        
    }
    return _allGoodsArray;
}
-(NSMutableArray *)noticeArray
{
    if (!_noticeArray) {
        _noticeArray = [NSMutableArray array];
    }
    return _noticeArray;
}

-(void)requstUserInfor
{
    //AB_user_info_url
    NSDictionary *params = @{};
    WS(weakSelf);
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_get_user_info_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [self.collectionView.mj_header endRefreshing];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            SSKJ_UserInfo_Model *model = [SSKJ_UserInfo_Model mj_objectWithKeyValues:netWorkModel.data];
            
            [SSKJ_User_Tool sharedUserTool].userInfoModel = model;
        }
        else
        {
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}




@end
