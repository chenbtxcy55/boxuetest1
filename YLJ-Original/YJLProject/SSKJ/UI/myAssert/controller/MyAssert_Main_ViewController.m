//
//  MyAssert_Main_ViewController.m
//  SSKJ
//
//  Created by 孙克强 on 2019/10/7.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MyAssert_Main_ViewController.h"
#import "SSKJ_myAcountTableView.h"
#import "CoinDetailViewController.h"
#import "SKMyExtractVC.h"
#import "SKNewExchangeVC.h"
#import "SKMyChargeVC.h"

@interface MyAssert_Main_ViewController ()
@property (nonatomic ,strong) SSKJ_myAcountTableView *tableView;
@property (nonatomic ,strong) NSMutableArray * dataArr;

@end

@implementation MyAssert_Main_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"资产", nil);
    [self.view addSubview: self.tableView];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestList];
    
    
    
}

#pragma mark - 网络请求 请求行情列表
-(void)requestList
{
    
    WS(weakSelf);
    
    //    NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];
    //    NSString *type;
    //    if ([language isEqualToString:@"en"]) {
    //        type = @"2";
    //    }else{
    //        type = @"1";
    //    }
    
    NSDictionary *params = @{
                             };
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:JB_Account_DealAsset_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             weakSelf.tableView.assetDict = network_Model.data;
             
             weakSelf.dataArr = network_Model.data[@"res"][@"asset"];
             
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}
- (SSKJ_myAcountTableView *)tableView{
    if (!_tableView) {
        WS(weakSelf);
        
        _tableView = [[SSKJ_myAcountTableView alloc] initWithFrame:CGRectMake(ScaleW(10),  ScaleW(10), ScreenWidth-ScaleW(20), ScreenHeight - Height_NavBar - ScaleW(10) -Height_TabBar)];
        _tableView.selectedCellBlock = ^(int index) {
            
            NSDictionary * dic  = weakSelf.dataArr[index];
            CoinDetailViewController * coinVC = [CoinDetailViewController new];
            
            coinVC.pidStr = dic[@"pid"];
            coinVC.codeStr = dic[@"mark"];

            coinVC.codeDetailDic = dic;
            
            [weakSelf.navigationController pushViewController:coinVC animated:YES];
            
        };
        _tableView.selectedItemBlock = ^(NSInteger index) {
            
            if (index ==0) {
                
          
                
                SKMyChargeVC * vc = [SKMyChargeVC new];
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            else if (index == 1)
            {
                
                SKMyExtractVC * vc = [SKMyExtractVC new];
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
               
            }
            else
            {
                SKNewExchangeVC * vc = [SKNewExchangeVC new];
                
                
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }
            
        };
        
    }
    return _tableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
