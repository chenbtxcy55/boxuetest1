

#import "SuperDetail_ViewController.h"
#import "Shop_GoodsOwner_ViewController.h"
#import "SuperConfimViewController.h"
#import "YLJConfimOrderViewController.h"
#import "ShopDetailBoomView.h"
#import "SuperDetail_HeaderView.h"
#import "YLJShopDetail_HeaderView.h"
#import "ServersContactView.h"
#import "Super_Myaddress_ViewController.h"
#import "My_SetTPWD_ViewController.h"
#import "UIImage+ImgSize.h"
#import "GoodsDetailCell.h"
#import "ImgModel.h"
#import "LA_MainShopHotListModel.h"
#import "SSKJ_Service_AlertView.h"
#import "GoCoin_Login_NavView.h"

@interface SuperDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataAray;
@property (nonatomic, strong) ShopDetailBoomView *boomView;
@property (nonatomic, strong) YLJShopDetail_HeaderView *headerView;
//@property (nonatomic, strong) ServersContactView *cooyView;
@property (nonatomic, assign) NSInteger payType; //可售1 待售 2

@property (nonatomic, strong) NSMutableArray *imgHeightArray;


@property (nonatomic,strong) GoCoin_Login_NavView *navView;

@end

@implementation SuperDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"商品详情", nil);

    
    self.payType=1;
    
    [self configUI];
    
    
}

- (void)configUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.boomView];
    [self navView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];

    [self requstGoodsDetail];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
-(NSArray *)dataAray{
    if (!_dataAray) {
        _dataAray = @[];
        
    }
    return _dataAray;
}

- (GoCoin_Login_NavView *)navView
{
    if (_navView == nil) {
        
        _navView = [[GoCoin_Login_NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Height_NavBar)];
        
        _navView.rightBtn.hidden = YES;
        _navView.titleLabel.text = SSKJLocalized(@"商品详情", nil);
//        _navView.backBtn.hidden = YES;
        WS(weakSelf);
        
        _navView.BackBtnBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (YLJShopDetail_HeaderView *)headerView {
    if (!_headerView) {
        _headerView = [YLJShopDetail_HeaderView new];
    }
    return _headerView;
}


-(ShopDetailBoomView *)boomView
{
    if (!_boomView) {
        _boomView = [[ShopDetailBoomView alloc]init];
        _boomView.top = _tableView.bottom;
        WS(weakSelf);
        _boomView.serverBlock = ^{
            //联系客服
            [weakSelf requestService];
        };
        
        _boomView.commitBlock = ^{
                  [weakSelf buyListBuyRequst];
          
        };
    }
    return _boomView;
}

#pragma mark - 联系客服

- (void)requestService {
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CustomerService_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            [SSKJ_Service_AlertView showWithModel:network_Model.data[@"phone"] confirmBlock:^{
//                NSString *tel = [NSString stringWithFormat:@"telprompt://%@",network_Model.data[@"phone"]];
//                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:tel]];
            } cancleBlock:^{
                
            }];
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
    }];
    
}

//-(ServersContactView *)cooyView
//{
//    if (!_cooyView) {
//        _cooyView = [[ServersContactView alloc]init];
//        WS(weakSelf);
//         self.cooyView.hidden = YES;
//        _cooyView.cancellBlock = ^{
//            weakSelf.cooyView.hidden = YES;
//        };
//        _cooyView.commitBlock = ^{
//           weakSelf.cooyView.hidden = YES;
//        };
//    }
//    return _cooyView;
//}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight  - ScaleW(44)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = ScreenWidth;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.estimatedRowHeight = ScreenWidth;
        _tableView.backgroundColor = kMainColor;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _tableView.tableHeaderView = self.headerView;
        
        [_tableView registerClass:[GoodsDetailCell class] forCellReuseIdentifier:@"GoodsDetailCell"];
        
    }
    return _tableView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    NSString *str=[self.dataAray objectAtIndex:section];

    return 0;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *nameString = [self.dataAray objectAtIndex:indexPath.row];
//
//    NSLog(@"nameString::%@",nameString);
//

    ImgModel *model=self.dataAray[indexPath.row];
    
    GoodsDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"GoodsDetailCell" forIndexPath:indexPath];
    if (self.dataAray.count > 0) {
        cell.model=model;
    }

    WS(weakself);

    cell.block = ^{

        [weakself.tableView reloadData];

    };
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }
    
}
#pragma mark ------商品详情


- (void)requstGoodsDetail {
        NSDictionary *pamas = @{@"goods_id":_shopId};

//    LA_MainShopHotListModel
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [[WLHttpManager shareManager]requestWithURL_HTTPCode:KGoodsDetail RequestType:RequestTypePost Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            if ([netWorkModel.status isEqualToString:@"200"]) {
                LA_MainShopHotListModel *sModel = [LA_MainShopHotListModel mj_objectWithKeyValues:netWorkModel.data];
                self.headerView.sModel = sModel;
                self.tableView.tableHeaderView = self.headerView;
            }
            else
            {
    
    
            }
//            [MBProgressHUD showError:netWorkModel.msg];
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:error.domain];
        }];

}



-(void)buyListBuyRequst

{
    if (!kLogin) {
        
        JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
        
        SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:vc];
        naviVC.modalPresentationStyle = UIModalPresentationFullScreen;

        [self.navigationController presentViewController:naviVC animated:YES completion:^{
            
        }];
        
        return;
        
    }

    YLJConfimOrderViewController *vc = [[YLJConfimOrderViewController alloc]init];
    vc.goodsID = self.shopId;
      [self.navigationController pushViewController:vc animated:YES];

}

- (void)backEvent {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)orderEvent {
    
}

@end
