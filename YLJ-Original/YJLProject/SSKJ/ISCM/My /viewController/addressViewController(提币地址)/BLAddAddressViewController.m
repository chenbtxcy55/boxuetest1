//
//  BLAddAddressViewController.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BLAddAddressViewController.h"
#import "BLMangeAddressViewController.h"
#import "BFEXMoneyEdtingTableViewCell.h"
#import "QBWShowNoDataView.h"

#import "HeBi_AddAddress_ViewController.h"


@interface BLAddAddressViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger dataCount;
//以太坊
@property (nonatomic, strong) NSMutableArray *ethArray;
//比特币
@property (nonatomic, strong) NSMutableArray *btcArray;
////usdt
@property (nonatomic, strong) NSMutableArray *yecArray;
@property (nonatomic, strong) NSMutableArray *usdtArray;


@property (nonatomic, strong) UIView *etcHeaderView;

@property (nonatomic, strong) UIView *btcHeaderView;

@property (nonatomic, strong) UIView *yecHeaderView;

@property (nonatomic, strong) UIView *usdtHeaderView;
//@property (nonatomic, strong) UIView *usdtHeaderView;


@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation BLAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"地址管理", nil);
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self requesAddressList];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:self.btcArray];
        [_dataSource addObject:self.ethArray];
        [_dataSource addObject:self.yecArray];
        [_dataSource addObject:self.usdtArray];
    }
    return _dataSource;
}

#pragma mark - method
/**
 初始化
 */
- (void)setupUI {
    // header label

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    tableView.backgroundColor = kMainColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // bottom button
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(ScaleW(20), CGRectGetMaxY(tableView.frame) + 10, ScreenWidth - ScaleW(20) * 2, 45);
    [addButton setTitle:@"添加地址" forState:UIControlStateNormal];
    addButton.backgroundColor = SKRandomColor;
    [addButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    addButton.hidden = YES;
    [self.view addSubview:addButton];
    
}

- (void)requesAddressList

{
//    _dataCount = 5;
    __weak typeof(self) weakSelf = self;
    self.HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
  
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_my_AddrList_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 200) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.btcArray removeAllObjects];
            [weakSelf.ethArray removeAllObjects];
            [weakSelf.yecArray removeAllObjects];
            [weakSelf.usdtArray removeAllObjects];
            //            [self.usdtArray removeAllObjects];
            
            [weakSelf.ethArray addObjectsFromArray:(NSArray *)responseObject[@"data"][@"eth"]];
            [weakSelf.btcArray addObjectsFromArray:(NSArray *)responseObject[@"data"][@"btc"]];
            [weakSelf.yecArray addObjectsFromArray:(NSArray *)responseObject[@"data"][@"yec"]];
            [weakSelf.usdtArray addObjectsFromArray:(NSArray *)responseObject[@"data"][@"usdt"]];
            
            //            [self.usdtArray addObjectsFromArray:(NSArray *)json[@"data"][@"usdt"]];
            
            [weakSelf.dataSource addObject:weakSelf.ethArray];
            [weakSelf.dataSource addObject:weakSelf.btcArray];
            [weakSelf.dataSource addObject:weakSelf.yecArray];
            [weakSelf.dataSource addObject:weakSelf.usdtArray];
            //            [_dataSource addObject:self.usdtArray];
            
            [weakSelf.tableView reloadData];
            
            [weakSelf.HUD hideAnimated:YES];
            [SSKJ_NoDataView showNoData:weakSelf.dataSource.count toView:weakSelf.tableView offY:1.f];
        } else {
            [MBProgressHUD showError:responseObject[@"msg"]];
            [weakSelf.HUD hideAnimated:YES];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        [weakSelf.HUD hideAnimated:YES];
    }];

}


-(NSMutableArray *)ethArray{
    if (!_ethArray) {
        _ethArray = [NSMutableArray array];
        
    }
    return _ethArray;
}

-(NSMutableArray *)btcArray{
    if (!_btcArray) {
        _btcArray = [NSMutableArray array];
    }
    return _btcArray;
}

-(NSMutableArray *)yecArray{
    if (!_yecArray) {
        _yecArray = [NSMutableArray array];
        
    }
    return _yecArray;
}

-(NSMutableArray *)usdtArray{
    if (!_usdtArray) {
        _usdtArray = [NSMutableArray array];
    }
    return _usdtArray;
}

/**
 添加地址
 */
- (void)addAddress:(UIButton *)button {
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataSource[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    BFEXMoneyEdtingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"BFEXMoneyEdtingTableViewCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
    if (!cell) {
        cell = [[BFEXMoneyEdtingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"BFEXMoneyEdtingTableViewCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
        //cell.backgroundColor = RGBCOLOR16(0xf4f9fa);
        WS(weakSelf);
        cell.deleBlock = ^{
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:SSKJLocalized(@"提醒", nil) message:SSKJLocalized(@"确定删除该地址么?", nil) preferredStyle:UIAlertControllerStyleAlert];
            
            [alertVC addAction:[UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleDefault handler:nil]];
            
            [alertVC addAction:[UIAlertAction actionWithTitle:SSKJLocalized(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf tableView:tableView deleteAddressIndexPath:indexPath];
            }]];
            
            alertVC.modalPresentationStyle = UIModalPresentationFullScreen;

            [weakSelf presentViewController:alertVC animated:YES completion:nil];
        };
    }
    NSInteger section = indexPath.section;
    NSArray *array = self.dataSource[section];
    [cell setValueWithData:array[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.fromVC == 1) {
        NSInteger section = indexPath.section;
        NSArray *array = self.dataSource[section];
        self.getAddressBlock(array[indexPath.row][@"qiaobao_url"]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return   UITableViewCellEditingStyleNone;
}
//先要设Cell可编辑
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0)
//    {
//         return self.dataSource[section] == self.btcArray?self.btcHeaderView:self.etcHeaderView;
//    }
//    if (section == 1)
//    {
//         return self.dataSource[section] == self.ethArray?self.etcHeaderView:self.btcHeaderView;
//    }
//   return self.dataSource[section] == self.ethArray?self.etcHeaderView:self.btcHeaderView;
    if (section == 0) {
        return self.btcHeaderView;

    }else if (section == 1)
    {
        return self.etcHeaderView;

    }
    else if (section == 2)
    {
        return self.usdtHeaderView;

    }
    else if (section == 3)
    {
        return self.yecHeaderView;

    }
    return nil;
//    else{
//        return self.usdtHeaderView;
//    }
    
}

-(UIView *)etcHeaderView{
    if (!_etcHeaderView) {
        
        _etcHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,   55)];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 45)];
        backView.backgroundColor = kNavBGColor;
        [_etcHeaderView addSubview:backView];
        UILabel *messagelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Screen_Width - 10, 45)];
        NSString * str = @"ETH";
//        [NSString stringWithFormat:@"ETH(KT)%@",SSKJLocalized(@"提币地址", nil)];

        [self.view label:messagelabel font:16 textColor:[UIColor whiteColor] text:str];
        messagelabel.font = [UIFont boldSystemFontOfSize:16];
        [backView addSubview:messagelabel];
        //btn
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"tianjia-icon"] forState:UIControlStateNormal];
        addBtn.width = 60;
        addBtn.height = 45;
        addBtn.right = backView.right - 5;
        addBtn.top = 0;
        [addBtn addTarget:self action:@selector(addETCBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:addBtn];
    }
    return _etcHeaderView;
}
-(UIView *)btcHeaderView{
    if (!_btcHeaderView) {
        _btcHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,   55)];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 45)];
        backView.backgroundColor = kNavBGColor;
        [_btcHeaderView addSubview:backView];
        UILabel *messagelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Screen_Width - 10, 45)];
//        NSString * str = [NSString stringWithFormat:@"BTC(USDT)%@",SSKJLocalized(@"提币地址", nil)];
        [self.view label:messagelabel font:16 textColor:[UIColor whiteColor] text:@"BTC"];
        messagelabel.font = [UIFont boldSystemFontOfSize:16];
        [backView addSubview:messagelabel];
        //btn
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"tianjia-icon"] forState:UIControlStateNormal];
        addBtn.width = 60;
        addBtn.height = 45;
        addBtn.right = backView.right - 5;
        addBtn.top = 0;
        [addBtn addTarget:self action:@selector(addBTCBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:addBtn];
    }
    return _btcHeaderView;
}

-(UIView *)yecHeaderView{
    if (!_yecHeaderView) {
        _yecHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,   55)];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 45)];
        backView.backgroundColor = kNavBGColor;
        [_yecHeaderView addSubview:backView];
        UILabel *messagelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Screen_Width - 10, 45)];
        //        NSString * str = [NSString stringWithFormat:@"BTC(USDT)%@",SSKJLocalized(@"提币地址", nil)];
        [self.view label:messagelabel font:16 textColor:[UIColor whiteColor] text:@"YEC"];
        messagelabel.font = [UIFont boldSystemFontOfSize:16];
        [backView addSubview:messagelabel];
        //btn
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"tianjia-icon"] forState:UIControlStateNormal];
        addBtn.width = 60;
        addBtn.height = 45;
        addBtn.right = backView.right - 5;
        addBtn.top = 0;
        [addBtn addTarget:self action:@selector(addYECBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:addBtn];
    }
    return _yecHeaderView;
}

-(UIView *)usdtHeaderView{
    if (!_usdtHeaderView) {
        _usdtHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,   55)];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 45)];
        backView.backgroundColor = kNavBGColor;
        [_usdtHeaderView addSubview:backView];
        UILabel *messagelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Screen_Width - 10, 45)];
        //        NSString * str = [NSString stringWithFormat:@"BTC(USDT)%@",SSKJLocalized(@"提币地址", nil)];
        [self.view label:messagelabel font:16 textColor:[UIColor whiteColor] text:@"USDT"];
        messagelabel.font = [UIFont boldSystemFontOfSize:16];
        [backView addSubview:messagelabel];
        //btn
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"tianjia-icon"] forState:UIControlStateNormal];
        addBtn.width = 60;
        addBtn.height = 45;
        addBtn.right = backView.right - 5;
        addBtn.top = 0;
        [addBtn addTarget:self action:@selector(addUSDTBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:addBtn];
    }
    return _usdtHeaderView;
}

//-(UIView *)usdtHeaderView{
//    if (!_usdtHeaderView) {
//        _usdtHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,   55)];
//        _usdtHeaderView.backgroundColor = BgViewColor;
//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 45)];
//        backView.backgroundColor = KNavBgColor;
//        [_usdtHeaderView addSubview:backView];
//        UILabel *messagelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Screen_Width - 10, 45)];
//        //        NSString * str = [NSString stringWithFormat:@"BTC(USDT)%@",SSKJLocalized(@"提币地址", nil)];
//        [self.view label:messagelabel font:18 textColor:kMainWhiteColor text:@"USDT"];
//        messagelabel.font = [UIFont boldSystemFontOfSize:18];
//        [backView addSubview:messagelabel];
//        //btn
//        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [addBtn setImage:[UIImage imageNamed:@"tianjia-icon"] forState:UIControlStateNormal];
//        addBtn.width = 60;
//        addBtn.height = 45;
//        addBtn.right = backView.right - 5;
//        addBtn.top = 0;
//        [addBtn addTarget:self action:@selector(addUSDTBtn:) forControlEvents:(UIControlEventTouchUpInside)];
//        [backView addSubview:addBtn];
//    }
//    return _usdtHeaderView;
//}

-(void)addETCBtn:(UIButton *)sender
{
//    __weak typeof(self) weakSelf = self;
//    BLMangeAddressViewController *addressVC = [[BLMangeAddressViewController alloc] init];
//    addressVC.currentType = @"eth";
//    addressVC.refreshListBlock = ^{
//        [weakSelf requesAddressList];
//    };
    
    
    HeBi_AddAddress_ViewController *addressVC = [[HeBi_AddAddress_ViewController alloc]init];
    addressVC.coinType = @"eth";
    [self.navigationController pushViewController:addressVC animated:YES];

}
-(void)addBTCBtn:(UIButton *)sender
{
//    __weak typeof(self) weakSelf = self;
//    BLMangeAddressViewController *addressVC = [[BLMangeAddressViewController alloc] init];
//    addressVC.currentType = @"btc";
//    addressVC.refreshListBlock = ^{
//        [weakSelf requesAddressList];
//    };
    HeBi_AddAddress_ViewController *addressVC = [[HeBi_AddAddress_ViewController alloc]init];
    addressVC.coinType = @"BTC";
    [self.navigationController pushViewController:addressVC animated:YES];

}

-(void)addYECBtn:(UIButton *)sender
{
    //    __weak typeof(self) weakSelf = self;
    //    BLMangeAddressViewController *addressVC = [[BLMangeAddressViewController alloc] init];
    //    addressVC.currentType = @"btc";
    //    addressVC.refreshListBlock = ^{
    //        [weakSelf requesAddressList];
    //    };
    HeBi_AddAddress_ViewController *addressVC = [[HeBi_AddAddress_ViewController alloc]init];
    addressVC.coinType = @"YEC";
    [self.navigationController pushViewController:addressVC animated:YES];
    
}
-(void)addUSDTBtn:(UIButton *)sender
{
    //    __weak typeof(self) weakSelf = self;
    //    BLMangeAddressViewController *addressVC = [[BLMangeAddressViewController alloc] init];
    //    addressVC.currentType = @"btc";
    //    addressVC.refreshListBlock = ^{
    //        [weakSelf requesAddressList];
    //    };
    HeBi_AddAddress_ViewController *addressVC = [[HeBi_AddAddress_ViewController alloc]init];
    addressVC.coinType = @"USDT";
    [self.navigationController pushViewController:addressVC animated:YES];
    
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self tableView:tableView deleteAddressIndexPath:indexPath];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SSKJLocalized(@"删除", nil);
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView deleteAddressIndexPath:(NSIndexPath *)indexPath {
    //删除
    NSArray *array = self.dataSource[indexPath.section];
    NSDictionary *dataDic = array[indexPath.row];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    NSDictionary *params = @{
                             @"address":dataDic[@"qiaobao_url"],
                             @"notes":dataDic[@"notes"],
                             @"type":dataDic[@"type"],
                             @"act":@"del",
                             @"id":dataDic[@"id"]

                             };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_add_AddrManage_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            [MBProgressHUD showSuccess:netModel.msg];
            [weakSelf requesAddressList];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];

}


// 长按cell，复制操作
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 可以执行的操作,action包括（cut、copy、paste、select、selectAll)，这里只执行 copy 操作
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    // 设置只能复制
    if (action == @selector(cut:)){
        return NO;
    }
    else if(action == @selector(copy:)){
        return YES;
    }
    else if(action == @selector(paste:)){
        return NO;
    }
    else if(action == @selector(select:)){
        return NO;
    }
    else if(action == @selector(selectAll:)){
        return NO;
    }
    else{
        return [super canPerformAction:action withSender:sender];
    }
}

// 执行操作
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if (action == @selector(copy:)) {
        //  把获取到的字符串放置到剪贴板上
        NSArray *array = self.dataSource[indexPath.section];
        [UIPasteboard generalPasteboard].string = array[indexPath.row][@"qiaobao_url"];
        [MBProgressHUD showSuccess:@"地址复制成功"];
    }
}


@end
