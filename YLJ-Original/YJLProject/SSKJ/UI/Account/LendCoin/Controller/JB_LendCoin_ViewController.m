//
//  JB_LendCoin_ViewController.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_LendCoin_ViewController.h"
#import "JB_LendChoiceTableViewCell.h"
#import "JB_LendCoinModel.h"
#import "JB_PledgeRecordTableViewCell.h"
#import "JB_PledgeHeaderView.h"
#import "JB_CoinInfoModel.h"
#import "JB_Account_Asset_Index_Model.h"
#import "JB_Lend_DiyaCoinDetail_Model.h"
#import "ETF_Default_ActionsheetView.h"
#import "JB_Lend_JieKuanCoinDetail_Model.h"
#import "JB_Lend_BorrowInfoModel.h"
#import "JB_TransferAccountViewController.h"
#import "JB_PledgeRecordListViewController.h"
#import "JB_Lend_AddActionSheet_View.h"
#import "HeBi_Default_AlertView.h"
#import "JB_Lend_AddActionSheet_View.h"
#import "JB_BorrowRule_ViewController.h"
#define kPage_size @"10"
@interface JB_LendCoin_ViewController ()
<UITableViewDelegate,
UITableViewDataSource,
JB_LendChoiceTableViewCellDelegate,JB_PledgeRecordTableViewCellDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *typesArray;
@property (nonatomic, strong) NSMutableArray *subTitleArray;
@property (nonatomic, strong) NSArray *placeholderArray;
@property (nonatomic, strong) NSMutableArray *inputTextArray;
@property (nonatomic, strong) NSMutableArray *modelsArray;
@property (nonatomic, strong) NSArray *keyboardTypeArray;

@property (nonatomic, strong) JB_PledgeHeaderView *headerView;
@property (nonatomic, assign) JB_LendCoin_VCType type;
@property (nonatomic, strong) NSArray *borrowCoinModels;
@property (nonatomic, strong) NSArray *sendCoinModels;

@property (nonatomic, strong) NSMutableArray *diyaCoinList; // 可选择的抵押币中列表
@property (nonatomic, strong) JB_Account_Asset_Index_Model *diyaCoinModel;      // 选择的抵押币币种
@property (nonatomic, strong) JB_Lend_DiyaCoinDetail_Model *diyaCoinDetailModel;    // 抵押币种详情

@property (nonatomic, strong) NSMutableArray *jiekuanCoinList;// 可选择的借款（借币）币中列表
@property (nonatomic, strong) JB_Account_Asset_Index_Model *jiekuanCoinModel;//选择的借币币种
@property (nonatomic, strong) JB_Lend_JieKuanCoinDetail_Model *jiekuanCoinDetailModel;//选择的借币详情
@property (nonatomic, copy) NSString *zhouqiDay;//周期天数
@property (nonatomic, strong) NSArray *zhouqiDayArray;//周期天数s
@property (nonatomic, copy) NSString *diyaNum;//抵押数量
@property (nonatomic, copy) NSString *jieruNum;//借入数量

@property (nonatomic, strong) JB_Lend_BorrowInfoModel *borrowInfoModel;//借入币信息
@property (nonatomic, strong) JB_PledgeRecordModel *selectModel;

@end

@implementation JB_LendCoin_ViewController

- (instancetype)initWithType:(JB_LendCoin_VCType)type
{
    self = [super init];
    if (self) {
        self.type = type;
        self.modelsArray = [[NSMutableArray alloc]init];
        self.titlesArray = @[@[SSKJLocalized(@"选择抵押币种", nil),
                               SSKJLocalized(@"可用资金", nil),
                               SSKJLocalized(@"市场参考价", nil)],
                             @[SSKJLocalized(@"抵押数量", nil),
                               SSKJLocalized(@"借款周期", nil),
                               SSKJLocalized(@"借款利率", nil)],
                             @[SSKJLocalized(@"选择借款币种", nil),
                               SSKJLocalized(@"最多可借", nil),
                               SSKJLocalized(@"借入数量", nil)]];
        self.subTitleArray = [NSMutableArray arrayWithArray: @[@[SSKJLocalized(@"CQTF", nil),
                               SSKJLocalized(@"CQTF", nil),
                               SSKJLocalized(@"CNY", nil)],
                             @[SSKJLocalized(@"CQTF", nil),
                               SSKJLocalized(@"30天", nil),
                               SSKJLocalized(@"0%(年利率)", nil)],
                             @[SSKJLocalized(@"BTC", nil),
                               SSKJLocalized(@"BTC", nil),
                               SSKJLocalized(@"BTC", nil)]]
                              ];
        self.placeholderArray = @[@[SSKJLocalized(@"", nil),
                                    SSKJLocalized(@"", nil),
                                    SSKJLocalized(@"", nil)],
                                  @[SSKJLocalized(@"请输入你要抵押的数量", nil),
                                    SSKJLocalized(@"", nil),
                                    SSKJLocalized(@"", nil)],
                                  @[SSKJLocalized(@"", nil),
                                    SSKJLocalized(@"", nil),
                                    SSKJLocalized(@"请输入你要借入的数量", nil)]];
        self.inputTextArray = [NSMutableArray arrayWithArray: @[@[SSKJLocalized(@"", nil),
                                  SSKJLocalized(@"0.00", nil),
                                  SSKJLocalized(@"0.00", nil)],
                                @[SSKJLocalized(@"", nil),
                                  SSKJLocalized(@"", nil),
                                  SSKJLocalized(@"", nil)],
                                @[SSKJLocalized(@"", nil),
                                  SSKJLocalized(@"0.00", nil),
                                  SSKJLocalized(@"", nil)]]
                               ];
        self.typesArray = @[@[@(JB_LendChoiceCellType_Arrow),
                              @(JB_LendChoiceCellType_InputUnEble),
                              @(JB_LendChoiceCellType_InputUnEble)],
                            @[@(JB_LendChoiceCellType_Input),
                              @(JB_LendChoiceCellType_Arrow),
                              @(JB_LendChoiceCellType_Normal)],
                            @[@(JB_LendChoiceCellType_Arrow),
                              @(JB_LendChoiceCellType_InputUnEble),
                              @(JB_LendChoiceCellType_Input)]];
        self.keyboardTypeArray = @[@[@(UIKeyboardTypeDefault),
                              @(UIKeyboardTypeDefault),
                              @(UIKeyboardTypeDefault)],
                            @[@(UIKeyboardTypeDecimalPad),
                              @(UIKeyboardTypeDefault),
                              @(UIKeyboardTypeDefault)],
                            @[@(UIKeyboardTypeDefault),
                              @(UIKeyboardTypeDefault),
                              @(UIKeyboardTypeDecimalPad)]];
        
        
    }
    return self;
}

-(NSMutableArray *)diyaCoinList
{
    if (nil == _diyaCoinList) {
        _diyaCoinList = [NSMutableArray array];
    }
    return _diyaCoinList;
}

-(NSMutableArray *)jiekuanCoinList
{
    if (nil == _jiekuanCoinList) {
        _jiekuanCoinList = [NSMutableArray array];
    }
    return _jiekuanCoinList;
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        self.title = SSKJLocalized(@"借款", nil);
    }else{
        self.title = SSKJLocalized(@"借币", nil);
    }

    
    [self createModels];
    
    self.view.backgroundColor = kMainBackgroundColor;
    [self.view addSubview:self.mainTableView];
    [self addRightNavItemWithTitle:SSKJLocalized(@"规则说明", nil)
                             color:kMainWihteColor
                              font:[UIFont systemFontOfSize:ScaleW(14)]];

    [self requestDiyaCoinlist];
//    [self requestZhouQiDay];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self headerRefresh];
   
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)rigthBtnAction:(id)sender {
    JB_BorrowRule_ViewController *vc = [[JB_BorrowRule_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createModels {
    [self.modelsArray removeAllObjects];
    for (NSInteger i = 0; i<self.titlesArray.count; i++) {
        NSArray *list = self.titlesArray[i];
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSInteger j = 0; j<list.count; j++) {
            JB_LendCoinModel *model = [[JB_LendCoinModel alloc]init];
            JB_LendChoiceCellType type = (JB_LendChoiceCellType)[self.typesArray[i][j] integerValue];
            UIKeyboardType keyboardType = (UIKeyboardType)[self.keyboardTypeArray[i][j] integerValue];
            NSString *title = self.titlesArray[i][j];
            NSString *subTitle = self.subTitleArray[i][j];
            NSString *placeholder = self.placeholderArray[i][j];
            NSString *inputText = self.inputTextArray[i][j];
            model.type = type;
            model.title = title?:@"";
            model.subTitle = subTitle?:@"";
            model.inputPlaceHolder = placeholder?:@"";
            model.inputText = inputText?:@"";
            model.keyboardType = keyboardType;
            [array addObject:model];
        }
        [self.modelsArray addObject:array];
    }
    
}


#pragma mark -- 网络请求
//
//- (void)requestLendCoin {
//    NSDictionary *params = @{@"type":@"1",
//                             @"out_code":@"",
//                             @"in_code":@"",
//                             @"num":@"",
//                             @"in_num":@"",
//                             @"days":@""};
//
//    //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    WS(weakSelf);
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_LendCoin_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
//        //        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//        if ([network_model.status integerValue] == SUCCESSED) {
//
//        }else{
//            [MBProgressHUD showError:network_model.msg];
//        }
//
//    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//    }];
//}

#pragma mark -- JB_LendChoiceTableViewCellDelegate
- (void)inputTFInfoWithModel:(JB_LendCoinModel *)model inputString:(NSString *)inputString {
    if ([model.title isEqualToString:SSKJLocalized(@"抵押数量", nil)]) {
        JB_LendCoinModel *model = self.modelsArray[1][0];
        
        if (inputString.doubleValue > self.diyaCoinDetailModel.usable.doubleValue) {
            if (self.diyaCoinDetailModel.usable.doubleValue == 0) {
                inputString = @"0.00";
            }else{
                inputString = self.diyaCoinDetailModel.usable;
            }
        }
        
        model.inputText = inputString?:@"";
        self.diyaNum = inputString?:@"";
        
        [self requestJieRuCoinInfo];
    }
    if ([model.title isEqualToString:SSKJLocalized(@"借入数量", nil)]) {
        JB_LendCoinModel *model = self.modelsArray[2][2];
        model.inputText = inputString?:@"";
        self.jieruNum = inputString?:@"";
    }
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        NSArray *lists = self.modelsArray[section];
        return lists.count;
    }
    if (section == 1) {
        NSArray *lists = self.modelsArray[section];
        return lists.count;
    }
    if (section == 2) {
        NSArray *lists = self.modelsArray[section];
        return lists.count;
    }
    if (section == 3) {
        return self.dataSource.count;
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0||
        indexPath.section == 1 ||
        indexPath.section == 2) {
        JB_LendChoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
        NSArray *array = self.modelsArray[indexPath.section];
        JB_LendCoinModel *model = self.modelsArray[indexPath.section][indexPath.row];
//        model.subTitle = self.subTitleArray[indexPath.section][indexPath.row];
//        model.inputText = self.inputTextArray[indexPath.section][indexPath.row];
        
        if (array.count-1 == indexPath.row) {
            [cell configureCellWithModel:model
                              hiddenLine:YES];
        }else{
            [cell configureCellWithModel:model
                              hiddenLine:NO];
        }
        
    
        return cell;
    }
    JB_PledgeRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.recordModel = self.dataSource[indexPath.row];
    cell.delegate = self;
    return cell;

}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 ||
        section == 1 ||
        section == 2) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
        headerView.backgroundColor = kMainBackgroundColor;
        
        return headerView;
    }
    return self.headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 ||
        section == 1 ||
        section == 2) {
        return ScaleW(10);
    }else{
        return ScaleW(205);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 &&
        indexPath.row == 0) {
        NSArray *coinNames = [self.diyaCoinList valueForKeyPath:@"mark"];
        WS(weakSelf);
        [ETF_Default_ActionsheetView showWithItems:coinNames title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
            weakSelf.diyaCoinModel = self.diyaCoinList[selectIndex];
            [weakSelf reloadDiYaCoinPname];
        } cancleBlock:^{}];
    }
    
    if (indexPath.section == 1 &&
        indexPath.row == 1) {
        WS(weakSelf);

        [ETF_Default_ActionsheetView showWithItems:self.zhouqiDayArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
            weakSelf.zhouqiDay = weakSelf.zhouqiDayArray[selectIndex];
            [weakSelf requestJieRuCoinInfo];
            
        } cancleBlock:^{}];
    }
    
    if (indexPath.section == 2 &&
        indexPath.row == 0) {
        NSArray *coinNames = [self.jiekuanCoinList valueForKeyPath:@"mark"];
        WS(weakSelf);
        [ETF_Default_ActionsheetView showWithItems:coinNames title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
            weakSelf.jiekuanCoinModel = self.jiekuanCoinList[selectIndex];
            [weakSelf reloadJieKuanCoinPname];
        } cancleBlock:^{}];
    }
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = kMainBackgroundColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = ScaleW(64);
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[JB_LendChoiceTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_mainTableView registerClass:[JB_PledgeRecordTableViewCell class] forCellReuseIdentifier:@"recordCell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        WS(weakSelf);
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
//
//        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf footerRefresh];
//        }];
    }
    return _mainTableView;
}

- (JB_PledgeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[JB_PledgeHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(205))];
    
        WS(weakSelf);
        _headerView.submitButtonBlock = ^{
            if (self.diyaNum.length == 0) {
                [MBProgressHUD showError:SSKJLocalized(@"请输入抵押数量", nil)];
                return ;
            }
            if (self.jieruNum.length == 0) {
                [MBProgressHUD showError:SSKJLocalized(@"请输入借入数量", nil)];
                return ;
            }
            [JB_Lend_AddActionSheet_View showPayPwdWithConfirmBlock:^(NSString * _Nonnull pwd) {
                [weakSelf requestDiyaDaikuanWithPwd:pwd];
            }];
            
        };
        _headerView.recordButtonBlock = ^{
            JB_PledgeRecordListViewController *vc = [[JB_PledgeRecordListViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _headerView;
}

#pragma mark - JB_PledgeRecordTableViewCellDelegate

- (void)buyBackDidSelectedWithModel:(JB_PledgeRecordModel *)model
{
    [self reqeustBuyBackWithID:model.tran_id?:@""];
}

- (void)addDidSelectedWithModel:(JB_PledgeRecordModel *)model {
    self.selectModel = model;
    [self requestLicaiCoinBalanceWithModel:model];
}
#pragma mark - 获取抵押币种列表

-(void)requestDiyaCoinlist
{
    NSString *type;
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        type = @"1";
    }else{
        type = @"2";
    }
    NSDictionary *params  = @{
                              @"type":type
                              };
    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_PledgeCoins_List_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_model.status.integerValue == SUCCESSED) {
            [weakSelf handleDiyaCoinListWithModel:network_model];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];

    }];
}

-(void)handleDiyaCoinListWithModel:(WL_Network_Model *)net_model
{
    NSArray *array = [JB_Account_Asset_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data];
    [self.diyaCoinList removeAllObjects];
    [self.diyaCoinList addObjectsFromArray:array];
    self.diyaCoinModel = self.diyaCoinList.firstObject;
    [self reloadDiYaCoinPname];
}
- (void)reloadDiYaCoinPname {
    
    JB_LendCoinModel *model = self.modelsArray[0][0];
    model.subTitle = self.diyaCoinModel.mark?:@"";
    JB_LendCoinModel *model1 = self.modelsArray[0][1];
    model1.subTitle = self.diyaCoinModel.mark?:@"";
    JB_LendCoinModel *model2 = self.modelsArray[1][0];
    model2.subTitle = self.diyaCoinModel.mark?:@"";
    [self.mainTableView reloadData];
    [self requestDiyaCoinDetail];
    [self requestJiekuanCoinlist];//获取借入币列表
}


#pragma mark - 请求币种余额
-(void)requestDiyaCoinDetail
{
    NSString *type;
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        type = @"1";
    }else{
        type = @"2";
    }
    NSDictionary *params  = @{@"type":type,
                              @"out_code":self.diyaCoinModel.mark,
                              };
    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_PledgeCoinDetail_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_model.status.integerValue == SUCCESSED) {
            
            [weakSelf handleDiyaCoinDetailWithModel:network_model];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

-(void)handleDiyaCoinDetailWithModel:(WL_Network_Model *)net_model
{
    self.diyaCoinDetailModel = [JB_Lend_DiyaCoinDetail_Model mj_objectWithKeyValues:net_model.data];
    [self reloadDiYaCoinInfo];
}

- (void)reloadDiYaCoinInfo {
    JB_LendCoinModel *model = self.modelsArray[0][1];
    model.inputText = [WLTools noroundingStringWith:self.diyaCoinDetailModel.usable.doubleValue afterPointNumber:8];
    JB_LendCoinModel *model1 = self.modelsArray[0][2];
    model1.inputText = [WLTools noroundingStringWith:self.diyaCoinDetailModel.price_cny.doubleValue afterPointNumber:2];
    [self.mainTableView reloadData];
    
}

#pragma mark - 请求周期天数
-(void)requestZhouQiDay
{
    NSString *type;
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        type = @"1";
    }else{
        type = @"2";
    }
    NSDictionary *params  = @{@"type":type,
                              @"in_code":self.jiekuanCoinModel.mark,
                              @"out_code":self.diyaCoinModel.mark};
    WS(weakSelf);
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Borrow_GetDays_Record_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_model.status.integerValue == SUCCESSED) {
            [weakSelf handleZhouQiDaysWithModel:network_model];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)handleZhouQiDaysWithModel:(WL_Network_Model *)net_model
{
    self.zhouqiDayArray = net_model.data;
    self.zhouqiDay = self.zhouqiDayArray.firstObject;
    [self reloadZhouQiDay];
}

- (void)reloadZhouQiDay {
    JB_LendCoinModel *model = self.modelsArray[1][1];
    model.subTitle = [NSString stringWithFormat:@"%@%@",self.zhouqiDay?:@"",SSKJLocalized(@"天", nil)];
    [self.mainTableView reloadData];
    [self requestJieRuCoinInfo];//获取借入币信息
    
}

//请求借款币种列表
-(void)requestJiekuanCoinlist
{
    NSString *type;
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        type = @"1";
    }else{
        type = @"2";
    }
    NSDictionary *params  = @{
                              @"type":type,
                              @"out_code":self.diyaCoinModel.mark
                              };
    WS(weakSelf);
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_BorrowCoins_List_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_model.status.integerValue == SUCCESSED) {
            [weakSelf handleJiekuanCoinListWithModel:network_model];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

-(void)handleJiekuanCoinListWithModel:(WL_Network_Model *)net_model
{
    NSArray *array = [JB_Account_Asset_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"in_coins"]];
    [self.jiekuanCoinList removeAllObjects];
    [self.jiekuanCoinList addObjectsFromArray:array];
    
    self.jiekuanCoinModel = self.jiekuanCoinList.firstObject;
    [self reloadJieKuanCoinPname];
    
}

- (void)reloadJieKuanCoinPname {
    JB_LendCoinModel *model = self.modelsArray[2][0];
    model.subTitle = self.jiekuanCoinModel.mark?:@"";
    JB_LendCoinModel *model1 = self.modelsArray[2][1];
    model1.subTitle = self.jiekuanCoinModel.mark?:@"";
    JB_LendCoinModel *model2 = self.modelsArray[2][2];
    model2.subTitle = self.jiekuanCoinModel.mark?:@"";
    [self.mainTableView reloadData];
    [self requestZhouQiDay];//获取周期
//    [self requestJieRuCoinInfo];//获取借入币信息
    
}


#pragma mark - 获取借入币信息
-(void)requestJieRuCoinInfo
{
    NSString *type;
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        type = @"1";
    }else{
        type = @"2";
    }
    NSDictionary *params  = @{@"type":type,
                              @"out_code":self.diyaCoinModel.mark,
                              @"in_code":self.jiekuanCoinModel.mark,
                              @"days":self.zhouqiDay?:@"",
                              @"num":self.diyaNum?:@"0"};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Borrow_Info_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_model.status.integerValue == SUCCESSED) {
            
            [weakSelf handleBorrowInfoWithModel:network_model];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

-(void)handleBorrowInfoWithModel:(WL_Network_Model *)net_model
{
    self.borrowInfoModel = [JB_Lend_BorrowInfoModel mj_objectWithKeyValues:net_model.data];
    [self reloadBorrowInfo];
}

- (void)reloadBorrowInfo {
    
    if (self.zhouqiDay != nil) {
        JB_LendCoinModel *model1 = self.modelsArray[1][1];
        model1.subTitle = [NSString stringWithFormat:@"%@%@",self.zhouqiDay?:@"",SSKJLocalized(@"天", nil)];
        [self.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
        
        JB_LendCoinModel *model = self.modelsArray[1][2];
        
        model.subTitle = [NSString stringWithFormat:@"%@%%%@",[WLTools noroundingStringWith:self.borrowInfoModel.rate.doubleValue afterPointNumber:2],SSKJLocalized(@"(年利率)", nil)];
        
        [self.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:1], nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    JB_LendCoinModel *model1 = self.modelsArray[2][1];
    model1.inputText = self.borrowInfoModel.in_num;
    [self.mainTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:2], nil] withRowAnimation:UITableViewRowAnimationNone];

}

#pragma mark - 抵押贷快
-(void)requestDiyaDaikuanWithPwd:(NSString *)pwd
{
    NSString *type;
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        type = @"1";
    }else{
        type = @"2";
    }
    NSDictionary *params  = @{@"type":type,
                              @"out_code":self.diyaCoinModel.mark,
                              @"in_code":self.jiekuanCoinModel.mark,
                              @"days":self.zhouqiDay?:@"",
                              @"num":self.diyaNum?:@"0",
                              @"in_num":self.jieruNum?:@"0",
                              @"tpwd":[WLTools md5:pwd?:@""]
                              };
    WS(weakSelf);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_BorrowAdd_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_model.status.integerValue == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf requestPborrowRecord];
            [weakSelf requestDiyaCoinlist];//刷新币种信息
            [weakSelf clearInputNumber];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

-(void)requestPborrowRecord
{
    NSString *type;
    if (self.type == JB_LendCoin_VCType_RendMoney) {
        type = @"1";
    }else{
        type = @"2";
    }

    NSDictionary *params = @{@"page":@(self.page),
                             @"size":@3,
                             @"type":type,
                             @"status":@"1"};
    
    //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_PledgeBorrow_Record_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf handleTeamDataWithModel:network_model];
        }else{
            [weakSelf endRefresh];
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf endRefresh];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}


-(void)handleTeamDataWithModel:(WL_Network_Model *)network_model
{
    
    NSArray *array = [JB_PledgeRecordModel mj_objectArrayWithKeyValuesArray:network_model.data[@"res"]];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    _page++;
    [self.dataSource addObjectsFromArray:array];
    
    if (array.count != kPage_size.integerValue) {
        self.mainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.mainTableView.mj_footer.state = MJRefreshStateIdle;
    }
//    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.mainTableView offY:ScaleW(50)];
    
    [self endRefresh];
    
    [self.mainTableView reloadData];
    
    
}

-(void)headerRefresh
{
    self.page = 1;
    [self requestPborrowRecord];
}

-(void)footerRefresh
{
    [self requestPborrowRecord];
}

-(void)endRefresh
{
    //    UITableView *tableView = _type == 0 ? self.teamTableView : self.incomeTableView;
    if (self.mainTableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.mainTableView.mj_header endRefreshing];
    }
    
    if (self.mainTableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.mainTableView.mj_footer endRefreshing];
    }
}


-(void)requestPayBackWithTranID:(NSString *)tranID
{
    
    
//    NSString *type;
//    if (self.type == JB_LendCoin_VCType_RendMoney) {
//        type = @"1";
//    }else{
//        type = @"2";
//    }
    NSDictionary *params  = @{
                              @"order_id":tranID?:@"",
                              };
    WS(weakSelf);
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_BorrowPayback_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (network_model.status.integerValue == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf headerRefresh];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}

-(void)requestLicaiCoinBalanceWithModel:(JB_PledgeRecordModel *)model
{
    WS(weakSelf);
    
    
    NSDictionary *params = @{
                             @"out_code":model.out_pname
                             };
    
    
    NSString *url = JB_LicaiCoinBalance_URL;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf handleExchangeListWithModel:network_model];
        }else{
            [weakSelf endRefresh];
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf endRefresh];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}


-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    
    JB_Account_Asset_Index_Model *assetModel = [JB_Account_Asset_Index_Model mj_objectWithKeyValues:net_model.data];
    WS(weakSelf);
    [JB_Lend_AddActionSheet_View showWithModel:assetModel confirmBlock:^(NSString * _Nonnull number, NSString * _Nonnull pwd) {
        [weakSelf requestConverWithNumber:number pwd:pwd];
    }];
    
}


-(void)requestConverWithNumber:(NSString *)number pwd:(NSString *)pwd
{
    NSDictionary *params = @{
                             @"tran_id":self.selectModel.tran_id,
                             @"out_code":self.selectModel.out_pname,
                             @"num":number,
                             @"tpwd":[WLTools md5:pwd]
                             };
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_LendCover_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showSuccess:network_model.msg];
            [weakSelf headerRefresh];
        }else{
            [weakSelf endRefresh];
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf endRefresh];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)reqeustBuyBackWithID:(NSString *)tran_id
{
    
    NSDictionary *params = @{@"tran_id":tran_id,
                             @"type":@"1"};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_BuyBackInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if ([network_model.status integerValue] == SUCCESSED) {
            NSString *fine_rate = network_model.data[@"fine_rate"];
            NSString *is_adv = network_model.data[@"is_adv"];
            [weakSelf buyBackOperateWithID:tran_id?:@""
                                 fine_rate:fine_rate?:@""
                                    is_adv:is_adv?:@""];
        }else{
            [MBProgressHUD showSuccess:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}


- (void)buyBackOperateWithID:(NSString *)tran_id fine_rate:(NSString *)fine_rate is_adv:(NSString *)is_adv {
    
    WS(weakSelf);
    if (is_adv.integerValue == 1) {
        NSString *title1 = SSKJLocalized(@"提前赎回将支付", nil);
        NSString *title2 = SSKJLocalized(@"的违约金，确认赎回吗？", nil);
        NSString *content = [NSString stringWithFormat:@"%@%@%%%@",title1?:@"",[WLTools noroundingStringWith:fine_rate.doubleValue afterPointNumber:4],title2?:@""];
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"", nil) message:content cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确认", nil) confirmBlock:^{
            [weakSelf requestPayBackWithTranID:tran_id?:@""];
        }];
    }else{
        NSString *title1 = SSKJLocalized(@"您确定赎回吗？", nil);
        
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"", nil) message:title1 cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确认", nil) confirmBlock:^{
            [weakSelf requestPayBackWithTranID:tran_id?:@""];
        }];
    }
}


- (void)clearInputNumber {
    JB_LendCoinModel *model = self.modelsArray[1][0];
    model.inputText = @"";
    self.diyaNum = @"";
    

    JB_LendCoinModel *model1 = self.modelsArray[2][2];
    model1.inputText = @"";
    self.jieruNum = @"";
    
    [self requestJieRuCoinInfo];
    [self.mainTableView reloadData];
}
@end
