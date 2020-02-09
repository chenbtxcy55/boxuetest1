//
//  HomepageRootViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "HomepageRootViewController.h"
#import "HomepageLockedViewController.h"

#import "Super_Notifacation_ViewController.h"
#import "Money_getmoney_ViewController.h"
#import "UpdateViewViewController.h"

//view
#import "HomeHeader.h"
#import "CoinPriceTableViewCell.h"

//model
#import "MoneyModel.h"

#import "MoneyListModel.h"

@interface HomepageRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeHeader *headerView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) UIView* bgView;

@end

@implementation HomepageRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = kMainWihteColor;
    
    

}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight  - Height_TabBar) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.tableHeaderView = self.headerView;
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestRecordList];
            [weakSelf requestRecordkbpayApiList];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //[weakSelf addRequst];
        }];
    }
    
    return _tableView;
}
-(HomeHeader *)headerView
{
    if (!_headerView) {
        _headerView = [[HomeHeader alloc]init];
        WS(weakSelf);
        _headerView.lockedBlock = ^{
            HomepageLockedViewController *vc = [[HomepageLockedViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
        _headerView.notifacationBlock = ^{
            Super_Notifacation_ViewController *vc = [[Super_Notifacation_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        _headerView.showAddressBlock = ^(NSString *address){
            Money_getmoney_ViewController *vc = [[Money_getmoney_ViewController alloc]init];
            vc.addressString = weakSelf.url;
            vc.isHomepage = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    statusBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBarHidden = YES;
    [self requestRecordList];
    [self requestRecordkbpayApiList];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CoinPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CoinPriceTableViewCell"];
    if (!cell) {
        cell = [[CoinPriceTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"CoinPriceTableViewCell"];
    }
    //cell.dataDic = self.dataArray[indexPath.row];
    NSDictionary *dataDic = self.dataArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"ETH";
        cell.coinImg.image = [UIImage imageNamed:@"ETH"];
       
    }
    if (indexPath.row == 1) {
        cell.nameLabel.text = @"YEC";
        cell.coinImg.image = [UIImage imageNamed:@"YEC"];
        
    }
    cell.priceLabel.text = [NSString stringWithFormat:@"%.4f",[dataDic[@"usable"] doubleValue]];
    
    cell.usLabel.text = [NSString stringWithFormat:@"$%.4f",[dataDic[@"usdt"] doubleValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(65);
}





//kIscm_lasset_Api
//AB_Shop_owner_goods_index
-(void)requestRecordList{
    //AB_Shop_slide_list_post
    
    
    NSDictionary *pamas = @{};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_lasset_Api RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
          [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status integerValue] == SUCCESSED) {
            self.headerView.moneyValueLabel.text = [NSString stringWithFormat:@"%.2f",[netWorkModel.data[@"ttl"] doubleValue]];
            [self.dataArray removeAllObjects];
            
            [self.dataArray addObject:netWorkModel.data[@"ETH"]];
            
            [self.dataArray addObject:netWorkModel.data[@"ISCM"]];
            
            
            [self.tableView reloadData];

            
        }else{
            [MBProgressHUD showError:netWorkModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
          [self.tableView.mj_header endRefreshing];
    }];
}
-(NSMutableArray *)dataArray
{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
//kIscm_bpay_Api请求地址
-(void)requestRecordkbpayApiList{
    //AB_Shop_slide_list_post
    
    
    NSDictionary *pamas = @{@"pid":@"3"};
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_bpay_Api RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
          [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status integerValue] == SUCCESSED) {
            [WLTools simpleHashWithTel:@""];
            self.headerView.addressLabel.text = [WLTools simpleHashWithAddress: netWorkModel.data[@"url"]];
            
            self.url = netWorkModel.data[@"url"];
        }else{
            [MBProgressHUD showError:netWorkModel.msg];
        }
        // [MBProgressHUD showError:netWorkModel.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
          [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark -- 检查版本更新
-(void)requestCheckVersion
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_check_version_Api RequestType:RequestTypePost Parameters:@{@"version":AppVersion,@"type":@"2"} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (statusCode ==200) {
            if ([netWorkModel.data isEqualToString:@""] || [netWorkModel.data[@"version"] compare:AppVersion] == kCFCompareLessThan) {
                
                [self requestTanKuang];

                
            }else{
                
                UpdateViewViewController *vc = [[UpdateViewViewController alloc]init];
                
                vc.dataDic = responseObject;
                
                vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
                
                [self.navigationController presentViewController:vc animated:YES completion:^{
                    //
                    vc.view.superview.backgroundColor = [UIColor clearColor];
                    [self requestTanKuang];

                }];
            }
            
        }
        else
        {
            [self requestTanKuang];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [self requestTanKuang];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
}
#pragma mark --  弹框公告
-(void)requestTanKuang
{
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_sign_huoqugg_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (statusCode ==200 &&[netWorkModel.data[@"value"] length]>0) {
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            
            UIView* bgView = [[UIView alloc] initWithFrame:keyWindow.bounds];
            
            
            bgView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
            
            self.bgView  = bgView;
            
            UIView * bgWhiteView =[[UIView alloc] init];
            
            bgWhiteView.frame = CGRectMake(ScaleW(25), 0, ScreenWidth - ScaleW(25)*2, 0);
            
            bgWhiteView.backgroundColor = [UIColor whiteColor];
            
            bgWhiteView.layer.cornerRadius = ScaleW(10);
            bgWhiteView.layer.masksToBounds = YES;
            
            
            [bgView addSubview:bgWhiteView];
            
            
            UILabel * titleLab =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgWhiteView.width, ScaleW(68))];
            
            titleLab.text = @"公告";
            
            titleLab.font = systemBoldFont(ScaleW(16));
            
            titleLab.textAlignment= NSTextAlignmentCenter;
            
            titleLab.textColor = RGBACOLOR(50, 50, 50, 1);
            
            [bgWhiteView addSubview:titleLab];
            
            UILabel * contentLab =[[UILabel alloc] initWithFrame:CGRectMake(ScaleW(26), titleLab.bottom, bgWhiteView.width -ScaleW(26)*2 , 0)];
            
            contentLab.font = systemScaleFont(14);
            
            contentLab.numberOfLines = 0;
            
            contentLab.textColor = RGBACOLOR(100, 100, 100, 1);
            
            CGFloat height = [self.view returnHeight:netWorkModel.data[@"value"] font:ScaleW(15) width:contentLab.width-ScaleW(10)];
            
            contentLab.text = netWorkModel.data[@"value"];
            
            contentLab.height = height;
            
            [bgWhiteView addSubview:contentLab];
            
            UIImageView * lineImageView =[[UIImageView alloc] init];
            lineImageView.frame = CGRectMake(0, contentLab.bottom + ScaleW(29), bgWhiteView.width,1);
            
            lineImageView.backgroundColor = kLineGrayColor;
            
            [bgWhiteView addSubview:lineImageView];
            
            
            
            
            //
            UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelBtn.frame = CGRectMake(0, lineImageView.bottom, bgWhiteView.width/2, ScaleW(50));
            [self.view btn:cancelBtn font:ScaleW(16) textColor:RGBACOLOR(100, 100, 100, 1) text:SSKJLocalized(@"取消", nil) image:nil];
            
            cancelBtn.backgroundColor = [UIColor clearColor];
            [bgWhiteView addSubview:cancelBtn];
            [cancelBtn addTarget:self action:@selector(cancleAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
            
            
            UIButton* sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            sureBtn.frame = CGRectMake(bgWhiteView.width/2, lineImageView.bottom, bgWhiteView.width/2, ScaleW(50));
            [self.view btn:sureBtn font:ScaleW(16) textColor:RGBACOLOR(80,113,210, 1) text:SSKJLocalized(@"确定", nil) image:nil];
            sureBtn.backgroundColor = [UIColor clearColor];
            [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [bgWhiteView addSubview:sureBtn];
            
            
            bgWhiteView.height = sureBtn.bottom;
            
            bgWhiteView.centerY = bgView.centerY;
            
            
            [keyWindow addSubview:bgView];
            
            UIImageView * shuLineImageView =[[UIImageView alloc] init];
            shuLineImageView.frame = CGRectMake(bgWhiteView.width/2, contentLab.bottom + ScaleW(29), 1,ScaleW(50));
            
            shuLineImageView.backgroundColor = kLineGrayColor;
            
            [bgWhiteView addSubview:shuLineImageView];
            
            
            
            
            
        }
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
}

-(void)cancleAction:(UIButton*)sender
{
    
    [self.bgView removeFromSuperview];
    
}
-(void)sureAction:(UIButton*)sender
{
    
    [self.bgView removeFromSuperview];

    
}
@end
