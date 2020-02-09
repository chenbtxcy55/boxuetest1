//
//  Shop_Root_ViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/5.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Shop_Root_ViewController.h"
#import "Shop_Already_ViewController.h"
#import "Shop_Down_ViewController.h"
#import "ShopShop_RootOrderViewController.h"

#import "Shop_PublishView_ViewController.h"
#import "ShopEdting_ViewController.h"
#import "Shop_Root_headerView.h"
#import "ShopNoShop_View.h"
#import "Shop_ApplyToBeShop.h"
#import "Shop_Root_BarView.h"
#import "Shop_list_view.h"

@interface Shop_Root_ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) Shop_Root_headerView *headerView;
@property (nonatomic, strong) ShopNoShop_View *isNoShopView;
@property (nonatomic, strong) Shop_ApplyToBeShop *alertView;
@property (nonatomic, strong) Shop_Root_BarView *naviBarView;
//列表导航
@property (nonatomic, strong) Shop_list_view *naviList;

@property (nonatomic, strong) UIScrollView *scrollView;
///是不是店铺
@property (nonatomic, assign) BOOL isShop;

@property (nonatomic, strong) NSString *store_id;

@property (nonatomic, assign) BOOL isShopFinish;

@property (nonatomic, strong) NSDictionary *statusDict;

@end

@implementation Shop_Root_ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    [self loadDianPuZhuangTai];
    
    [self loadType];
    
}

-(void)loadDetail{

    NSDictionary *pamas = @{@"store_id":_store_id};
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_user_user_shop_info RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status integerValue] == SUCCESSED) {
            
                if (![[netWorkModel.data objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
            
            
                    self->_isShopFinish = YES;
            
                }
        }else{
            
            [MBProgressHUD showError:netWorkModel.msg];
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
}
-(void)loadType{
    
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:KGoodsType RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([netWorkModel.status integerValue] == SUCCESSED) {
       
            NSArray *array=netWorkModel.data;
            
            [SSKJ_User_Tool sharedUserTool].typeArray=[array mutableCopy];
            
        }
        else  {
            
            SsLog(@"responseObject:::%@",responseObject);
            
            [MBProgressHUD showError:netWorkModel.msg];
            
        }
       
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        
    }];
}
//店铺状态

-(void)loadDianPuZhuangTai{
 
        WS(weakself);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KShopStatus RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status integerValue] == SUCCESSED) {
         
             self.isShop=YES;
           
            self.store_id=[NSString stringWithFormat:@"%@",netWorkModel.data[@"store_id"]];
            [self loadDetail];
       
            [SSKJ_User_Tool sharedUserTool].storeId =  self.store_id;
            
            [weakself.naviList.detailBtn setTitle:[NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"已上架", nil),netWorkModel.data[@"on"] ] forState:(UIControlStateNormal)];
            [weakself.naviList.scoreBtn setTitle:[NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"已下架", nil),netWorkModel.data[@"off"] ] forState:(UIControlStateNormal)];
            
         
        }
         else  {
         
            
            self.isShop=NO;
            
             NSString *msg;
           
             
             if ([netWorkModel.status integerValue] == 0) {
                 
                 msg=@"商家申请正在审核中，请耐心等待";
                 
                 self.isNoShopView.isShowBt=NO;

                 self.isNoShopView.msg=msg;
                 
             }
             
             if ([netWorkModel.status integerValue] == 2) {
                 
                 msg=[NSString stringWithFormat:@"审核失败，失败原因:%@",netWorkModel.msg];
                 
                 self.isNoShopView.isShowBt=YES;
                 
                 self.isNoShopView.msg=msg;
                 
             }
             
        }
        
        [self.view addSubview:self.headerView];
        
        [self.view addSubview:self.isNoShopView];
      
        
        if (self.isShop == NO) {
            self.headerView.rightBtn.hidden = YES;
            [self addRightNavItemWithTitle:@"" color:kMainWihteColor font:systemFont(ScaleW(15))];
        }else{
            [self.view addSubview:self.naviBarView];
            [self.view addSubview:self.naviList];
            [self.view addSubview:self.scrollView];
            [self addChildControllers];

            [self addRightNavItemWithTitle:SSKJLocalized(@"编辑店铺", nil) color:kMainWihteColor font:systemFont(ScaleW(15))];
        }

    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}
-(void)rigthBtnAction:(id)sender{
    
    if (self.isShop == NO) {
        
        return;
        
    }
    else{
        
        ShopEdting_ViewController *vc = [[ShopEdting_ViewController alloc]init];
        
        vc.shopid=self.store_id;
        
        
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}

-(void)setIsShop:(BOOL)isShop
{
    _isShop = isShop;
    
    if (_isShop == NO) {
        self.isNoShopView.hidden = NO;
        self.naviBarView.hidden = YES;
        self.naviList.hidden = YES;
        self.scrollView.hidden = YES;
        
    }
    
    if (_isShop == YES)
    {
        self.isNoShopView.hidden = YES;
        
        self.naviBarView.hidden = NO;
        self.naviList.hidden = NO;
        self.scrollView.hidden = NO;
    }
}

-(void)applyToBeShopRequst
{
    WS(weakSelf);

    
    NSDictionary *params = @{};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:AB_Shop_user_owner_apply_post RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == 200) {
            
            weakSelf.alertView.hidden = NO;
        
            weakSelf.alertView.sub2label.text =[NSString stringWithFormat:@"发送邮件名为“成为商家”的邮件至%@，内容需包含以下内容：", net_model.data[@"email"]];
            
            weakSelf.alertView.dataDic = net_model.data;
      
        }else{
           
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {

        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    statusBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBarHidden = YES;
   
    self.navigationController.navigationBar.translucent = YES;
    if (_store_id) {
        
        [self loadDetail];
        
    }

}
-(Shop_Root_BarView *)naviBarView
{
    
    if (!_naviBarView) {
        
        _naviBarView = [[Shop_Root_BarView alloc]init];
        
#pragma mark 发布商品
        
        WS(weakSelf);
        _naviBarView.pulishBlock = ^{
          
            if (weakSelf.isShopFinish) {
                
                Shop_PublishView_ViewController *vc = [[Shop_PublishView_ViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
            else{
                
                showAlert(@"请完善商家信息");
                
                ShopEdting_ViewController *vc = [[ShopEdting_ViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }
           
        };
        
#pragma mark 订单管理
        _naviBarView.orderMangedBlock = ^{

         ShopShop_RootOrderViewController *vc = [[ShopShop_RootOrderViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _naviBarView.top = ScaleW(68) + Height_StatusBar;
    }
    return _naviBarView;
}
-(ShopNoShop_View *)isNoShopView
{
    if (!_isNoShopView) {
        _isNoShopView = [[ShopNoShop_View alloc]init];
        _isNoShopView.top = _headerView.bottom+Height_NavBar;
        WS(weakSelf);
        _isNoShopView.tobeShopBlock = ^{
            [weakSelf applyToBeShopRequst];
        };
    }
    return _isNoShopView;
}
-(Shop_ApplyToBeShop *)alertView
{
    if (!_alertView) {
        _alertView = [[Shop_ApplyToBeShop alloc]init];
         WS(weakSelf);
         self.alertView.hidden = YES;
        _alertView.cancellBlock = ^{
            weakSelf.alertView.hidden = YES;
        };
        _alertView.copBlock = ^{
            
            [weakSelf applyShop];
            
            weakSelf.alertView.hidden = YES;
        };
    }
    return _alertView;
}
#pragma mark 申请店铺
-(void)applyShop{
    
    
    NSDictionary *pamas = @{};
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:KShopApply RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([netWorkModel.status integerValue] == SUCCESSED) {
          
            
            NSString *msg=@"商家申请正在审核中，请耐心等待";
            
            self.isNoShopView.isShowBt=NO;
            
            self.isNoShopView.msg=msg;
        }
        else{
            
            self.isNoShopView.isShowBt=YES;
            
            self.isNoShopView.msg=[NSString stringWithFormat:@"审核失败，失败原因:%@",netWorkModel.msg];
        }
            
        
      
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(Shop_Root_headerView *)headerView
{
    if (!_headerView) {
        _headerView = [[Shop_Root_headerView alloc]init];
        
        WS(weakSelf);
        
        _headerView.rightAction = ^{
            ShopEdting_ViewController *vc = [[ShopEdting_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
        _headerView.leftAction = ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _headerView;
}

-(Shop_list_view *)naviList
{
    if (!_naviList) {
        
        _naviList = [[Shop_list_view alloc]init];
        
        _naviList.top = self.naviBarView.bottom;
        WS(weakSelf);
        _naviList.selectBlock = ^(NSInteger index) {
            
             [kNotifyCenter postNotificationName:[NSString stringWithFormat:@"reloadOther%ld",index+1] object:nil];
            [weakSelf.scrollView setContentOffset:(CGPointMake(index*ScreenWidth, 0)) animated:YES];
        };
        
    }
    return _naviList;
}
-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _naviList.bottom, ScreenWidth, ScreenHeight -  _naviList.bottom -(Height_TabBar-49) )];
        
        _scrollView.pagingEnabled = YES;
        
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, _scrollView.height);
        
        _scrollView.delegate = self;
        _scrollView.backgroundColor = kNavBGColor;
    }
    
    return _scrollView;
    
}

-(void)addChildControllers
{

#pragma mark 已上架
    // 已上架 ScreenWidth - ScaleW(30), ScaleW(90)
    Shop_Already_ViewController *vc = [[Shop_Already_ViewController alloc]init];
    vc.view.frame = CGRectMake(0, 0 , ScreenWidth,  ScreenHeight- (Height_TabBar-49) - self.naviList.bottom);
    vc.bottomLine =self.naviList.bottom;
  
    
    [self.scrollView addSubview:vc.view];
    
    [self addChildViewController:vc];
    WS(weakSelf);
    
    vc.backBlock = ^(NSInteger index) {
        [weakSelf.naviList.detailBtn setTitle:[NSString stringWithFormat:@"%@(%ld)",SSKJLocalized(@"已上架", nil),(long)index] forState:(UIControlStateNormal)];
        
    };
    
#pragma mark 已下架
    Shop_Down_ViewController *vc1 = [[Shop_Down_ViewController alloc]init];
    vc1.view.frame = CGRectMake(ScreenWidth, 0 , ScreenWidth, ScreenHeight  - self.naviList.bottom- (Height_TabBar-49) );
    vc1.bottomLine =self.naviList.bottom;

    vc1.backBlock = ^(NSInteger index) {
        
        [weakSelf.naviList.scoreBtn setTitle:[NSString stringWithFormat:@"%@(%ld)",SSKJLocalized(@"已下架", nil),index] forState:(UIControlStateNormal)];
        
    };
   
    [self.scrollView addSubview:vc1.view];
    
    [self addChildViewController:vc1];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    self.naviList.selectIndex = index;

}
@end
