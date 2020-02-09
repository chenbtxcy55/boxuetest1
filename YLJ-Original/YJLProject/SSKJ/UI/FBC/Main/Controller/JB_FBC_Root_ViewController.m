#import "JB_FBC_Root_ViewController.h"
#import "FBDeal_Segment_Control.h"
#import "C2CKineView.h"

// controller
#import "JB_FBC_DealHall_ViewController.h"
#import "JB_FBC_OrderList_ViewController.h"
#import "HeBi_Publish_ViewController.h"

#import "JB_PayWayModel.h"
#import "JB_FBC_BecomeShopView.h"
#import "JJHETFPositionModel.h"

#import "ABRootRecodViewController.h"



#import "OTC_BusinessApply_VC.h"

#import "JB_BBTrade_MarketDetail_ViewController.h"
#import "HeBi_Default_AlertView.h"

@interface JB_FBC_Root_ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) FBDeal_Segment_Control *segmentControl;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) C2CKineView *headerView;
@property (nonatomic, strong) UIButton *publishButton;  // 发布交易按钮



@end

@implementation JB_FBC_Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavigationView];
    //    [self requstWithKline];

    [self setUI];
    
}
-(C2CKineView *)headerView
{
    if (!_headerView) {
        _headerView = [[C2CKineView alloc]init];
    }
    return _headerView;
}
-(void)requstWithKline
{
    
    //VPay_shop_order_fahuo_kline_URL
    //JJHETFPositionModel *model = [JJHETFPositionModel
    
    NSDictionary *pamas = @{};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:VPay_shop_order_fahuo_kline_URL RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"])
        {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in netWorkModel.data) {
                JJHETFPositionModel *model = [[JJHETFPositionModel alloc]init];
                model.closingPrice = dic[@"price"];
                model.time = [WLTools convertTimestamp:[dic[@"add_time"] doubleValue] andFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                [array addObject:model];
            }
            JJHETFPositionModel *dic = [array firstObject];
            self.title =[NSString stringWithFormat:@"参考价：%@CNY",dic.closingPrice];
            self.headerView.dataArr = array;
            
            //
        }
        
        else
        {
            
        }
        // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
-(void)setNavigationView
{
    UIButton *btton = [UIButton buttonWithType:UIButtonTypeCustom];
    btton.frame = CGRectMake(0, 0, ScaleW(17), ScaleW(17));
    [btton btn:btton font:ScaleW(0) textColor:kMainTextColor text:@"" image:[UIImage imageNamed:@"icon_记录"] sel:@selector(recodeAction:) taget:self];
    self.title = @"参考价：6.88CNY";
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:btton];
    self.navigationItem.rightBarButtonItem = rightBar;
}
-(void)recodeAction:(UIButton *)sender
{
//    JB_FBC_OrderList_ViewController *vc = [[JB_FBC_OrderList_ViewController alloc]init];
//    vc.title = @"交易记录";
//    [self.navigationController pushViewController:vc animated:YES];
    ABRootRecodViewController *vc = [[ABRootRecodViewController alloc]init];
    vc.title = @"交易记录";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.navigationController.navigationBar.translucent = NO;
    
    [self requestGetInfo];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];

}

#pragma mark - UI

-(void)setUI
{
//    [self.view addSubview:self.headerView];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];
    
    [self addChildControllers];
    
    [self.view addSubview:self.publishButton];

}



///////////////////


-(FBDeal_Segment_Control *)segmentControl
{
    if (nil == _segmentControl) {
        _segmentControl = [[FBDeal_Segment_Control alloc]initWithFrame:CGRectMake(0, Height_StatusBar, ScreenWidth, ScaleW(50)) titles:@[SSKJLocalized(@"出售大厅", nil),SSKJLocalized(@"购买大厅", nil),SSKJLocalized(@"交易记录", nil)] normalColor:kSubTitleColor selectedColor:kMainBlueColor fontSize:ScaleW(14)];
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^BOOL(NSInteger index) {
            
            if (index == 2 && ![SSKJ_User_Tool sharedUserTool].userInfoModel.mobile) {
                [weakSelf presentLoginController];
                return NO;
            }
            
            weakSelf.publishButton.hidden = (index == 2);
            [weakSelf.scrollView scrollRectToVisible:CGRectMake(ScreenWidth * index, 0, ScreenWidth, weakSelf.scrollView.height) animated:YES];
//            weakSelf.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
            return YES;
        };
    }
    return _segmentControl;
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScreenHeight - self.segmentControl.bottom - Height_TabBar)];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 3, _scrollView.height);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UIButton *)publishButton
{
    if (nil == _publishButton) {
        _publishButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(50), ScreenHeight - Height_TabBar - ScaleW(50) - ScaleW(11) - Height_NavBar, ScaleW(50), ScaleW(50))];
        [_publishButton setImage:[UIImage imageNamed:SSKJLocalized(@"woyaomaimai", nil)] forState:UIControlStateNormal];
        [_publishButton addTarget:self action:@selector(publishEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishButton;
}

#pragma mark scrollDelegae


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    self.segmentControl.selectedIndex = index;
    self.publishButton.hidden = (index == 2);

}



-(void)addChildControllers
{
    
    // 出售大厅

    JB_FBC_DealHall_ViewController *vc = [[JB_FBC_DealHall_ViewController alloc]init];
    vc.dealType = BuySellTypeBuy;
    vc.height = self.scrollView.height;
    vc.view.frame = CGRectMake(0, 0, ScreenWidth, self.scrollView.height);
    [self.scrollView addSubview:vc.view];
    [self addChildViewController:vc];
    
    
    // 购买大厅

    JB_FBC_DealHall_ViewController *vc1 = [[JB_FBC_DealHall_ViewController alloc]init];
    vc1.dealType = BuySellTypeSell;
    vc1.height = self.scrollView.height;
    
    vc1.view.frame = CGRectMake(ScreenWidth, 0 , ScreenWidth, self.scrollView.height);
    [self.scrollView addSubview:vc1.view];
    
    [self addChildViewController:vc1];
    
    
   
    
    // 记录
    JB_FBC_OrderList_ViewController *vc2 = [[JB_FBC_OrderList_ViewController alloc]init];
    vc2.height = self.scrollView.height;
    vc2.view.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, self.scrollView.height);
    [self.scrollView addSubview:vc2.view];
    [self addChildViewController:vc2];
}


#pragma mark - 发布
-(void)publishEvent
{
    

    SSKJ_UserInfo_Model *userInfoModel  = [SSKJ_User_Tool sharedUserTool].userInfoModel;
    
    if (!userInfoModel.mobile) {
        [self presentLoginController];
        return;
    }
    
    if (self.segmentControl.selectedIndex == 0) {
        if (![self judgeFristCertificate]) {
            return;
        }
    }
    
    if (self.segmentControl.selectedIndex == 0) {
        if (![self judgeSecondCertificate]) {
            return;
        }
    }
    NSInteger is_shop = [SSKJ_User_Tool sharedUserTool].userInfoModel.is_shop.integerValue;
//    is_shop = 1;
    if (is_shop == 0) {
//        [JB_FBC_BecomeShopView showWithTitle:SSKJLocalized(@"成为商家才能进行发布哦~", nil) confirmBlock:^{
//            if (![self judgeBusinessCertificate]) {
//                return;
//            }
//        }];
        
        
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"成为商家才能进行发布哦~", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"去成为商家", nil) confirmBlock:^{
            OTC_BusinessApply_VC *vcc = [OTC_BusinessApply_VC new];
            [self.navigationController pushViewController:vcc animated:YES];
        }];
        return;
    }
    if (is_shop == 2) {
//        [JB_FBC_BecomeShopView showWithTitle:SSKJLocalized(@"商家认证已拒绝，请重新申请成为商家", nil) confirmBlock:^{
//            if (![self judgeBusinessCertificate]) {
//                return;
//            }
//        }];
        [CMRemind error:@"您的商家认证正在审核中"];
        return;
    }
    
    if (![self judgePayPassword]) {
        return;
    }
    
    
    HeBi_Publish_ViewController *vc = [[HeBi_Publish_ViewController alloc]init];
    
    if (self.segmentControl.selectedIndex == 0) {
        vc.publishType = PublishTypeBuy;
    }else{
        vc.publishType = PublishTypeSell;
    }    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -- 获取个人信息
-(void)requestGetInfo
{
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_get_user_info_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:netWorkModel.data];
            [SSKJ_User_Tool sharedUserTool].userInfoModel = userModel;
        }
        else
        {
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
    }];
}


@end
