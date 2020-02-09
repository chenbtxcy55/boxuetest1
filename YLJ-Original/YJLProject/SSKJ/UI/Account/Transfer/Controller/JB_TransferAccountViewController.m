//
//  JB_TransferAccountViewController.m
//  SSKJ
//
//  Created by James on 2019/5/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_TransferAccountViewController.h"
#import "JB_LendChoiceTableViewCell.h"
#import "JB_LendCoinModel.h"
#import "JB_TransferAccount_RecordViewController.h"
#import "JB_Account_Asset_CoinModel.h"
#import "ETF_Default_ActionsheetView.h"
#import "JB_QBW_AccountCoinModel.h"
#define kPage_size @"10"
@interface JB_TransferAccountViewController()
<UITableViewDelegate,
UITableViewDataSource,
JB_LendChoiceTableViewCellDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *typesArray;
@property (nonatomic, strong) NSMutableArray *subTitleArray;
@property (nonatomic, strong) NSMutableArray *placeholderArray;
@property (nonatomic, strong) NSMutableArray *inputTextArray;
@property (nonatomic, strong) NSArray *keyboradArray;
@property (nonatomic, strong) NSMutableArray *modelsArray;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) NSArray *licaiModelsArray;

@property (nonatomic, copy) NSString *selectedTypeString;
@property (nonatomic, copy) NSString *selectedCodeString;
@property (nonatomic, strong) JB_QBW_AccountCoinModel *modelIndex;
@property (nonatomic, assign) NSInteger titleIndex;
@property (nonatomic, strong) NSArray *enumTitlesArray;
@property (nonatomic, strong) NSArray *enumTitleKeyArray;


@property (nonatomic, strong) NSMutableArray *zcArray;//交易币种
@property (nonatomic, strong) NSMutableArray *lcArray;//理财币种

@end

@implementation JB_TransferAccountViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleIndex = 0;
        self.modelsArray = [[NSMutableArray alloc]init];
        self.enumTitlesArray = @[SSKJLocalized(@"从理财账户划转到交易账户", nil),
                                 SSKJLocalized(@"从交易账户划转到理财账户", nil)];
        self.enumTitleKeyArray = @[@"2",@"1"];
        self.titlesArray = @[SSKJLocalized(@"账户", nil),
                             SSKJLocalized(@"选择划转的币种", nil),
                             SSKJLocalized(@"划转数量", nil),
                             SSKJLocalized(@"安全密码", nil)];
        self.subTitleArray = [NSMutableArray arrayWithArray:@[SSKJLocalized(@"从交易账户划转到理财账户", nil),
                                                              SSKJLocalized(@"", nil),
                                                              SSKJLocalized(@"", nil),
                                                              SSKJLocalized(@"", nil)]];
        self.placeholderArray = [NSMutableArray arrayWithArray:@[SSKJLocalized(@"", nil),
                                                                 SSKJLocalized(@"", nil),
                                                                 SSKJLocalized(@"可用0.00", nil),
                                                                 SSKJLocalized(@"请输入安全密码", nil)]];
        self.inputTextArray = [NSMutableArray arrayWithArray:@[SSKJLocalized(@"", nil),
                                                               SSKJLocalized(@"", nil),
                                                               SSKJLocalized(@"", nil),
                                                               SSKJLocalized(@"", nil)]];
        self.typesArray = @[@(JB_LendChoiceCellType_Arrow),
                            @(JB_LendChoiceCellType_Arrow),
                            @(JB_LendChoiceCellType_Input),
                            @(JB_LendChoiceCellType_Input)];
        self.keyboradArray = @[@(UIKeyboardTypeDefault),
                               @(UIKeyboardTypeDefault),
                               @(UIKeyboardTypeDecimalPad),
                               @(UIKeyboardTypeEmailAddress)];
        

        self.selectedTypeString = @"2";//理财到交易

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"划转", nil);
    
    [self createModels];
    
    self.view.backgroundColor = kMainBackgroundColor;
    [self.view addSubview:self.mainTableView];

    [self setupHeaderOrFooter];
    [self addRightNavItemWithTitle:SSKJLocalized(@"划转记录", nil)
                             color:kMainWihteColor
                              font:[UIFont systemFontOfSize:ScaleW(14)]];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self requestLicaiCoinListWithType:self.selectedTypeString];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}



-(void)requestLicaiCoinListWithType:(NSString *)type
{
    
    WS(weakSelf);
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_QBW_Account_listBorrow_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            weakSelf.zcArray = [[NSMutableArray alloc]init];
            weakSelf.lcArray = [[NSMutableArray alloc]init];
            [weakSelf.zcArray removeAllObjects];
            [weakSelf.lcArray removeAllObjects];
            NSArray *zc = [JB_QBW_AccountCoinModel mj_objectArrayWithKeyValuesArray:network_model.data[@"zc"]];

            for (JB_QBW_AccountCoinModel *model in zc) {
                if (model.is_transfer.integerValue == 1) {
                    [weakSelf.zcArray addObject:model];
                }
            }
            NSArray *lc = [JB_QBW_AccountCoinModel mj_objectArrayWithKeyValuesArray:network_model.data[@"lc"]];
            for (JB_QBW_AccountCoinModel *model in lc) {
                if (model.is_transfer.integerValue == 1) {
                    [weakSelf.lcArray addObject:model];
                }
            }
            
            if (zc.count ==0 ||
                lc.count == 0) {
                return ;
            }
            weakSelf.selectedTypeString = weakSelf.enumTitleKeyArray[weakSelf.titleIndex];
            if ([weakSelf.selectedTypeString isEqualToString:@"2"]) {
                weakSelf.modelIndex = weakSelf.lcArray.firstObject;
            }else{
                weakSelf.modelIndex = weakSelf.zcArray.firstObject;
            }
            
            [weakSelf.subTitleArray replaceObjectAtIndex:0 withObject:weakSelf.enumTitlesArray[weakSelf.titleIndex]];
            [weakSelf reloadCoinUsable];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

- (void)reloadCoinUsable {
    [self.subTitleArray replaceObjectAtIndex:1 withObject:self.modelIndex.mark];
    [self.subTitleArray replaceObjectAtIndex:2 withObject:self.modelIndex.mark];
    
    
    [self.placeholderArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"可用", nil),[WLTools noroundingStringWith:self.modelIndex.usable.doubleValue afterPointNumber:8]]];
    self.selectedCodeString = self.modelIndex.mark?:@"";
    [self.mainTableView reloadData];
}

-(void)requestLicai
{
    WS(weakSelf);
    NSDictionary *dic = @{@"type":self.selectedTypeString,
                          @"code":self.selectedCodeString,
                          @"num":self.inputTextArray[2],
                          @"tpwd":[WLTools md5:self.inputTextArray[3]]};
    NSString *url = JB_BorrowTransferMoney_URL;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:dic Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [weakSelf.inputTextArray replaceObjectAtIndex:2 withObject:@""];
            [weakSelf.inputTextArray replaceObjectAtIndex:3 withObject:@""];
            [weakSelf.mainTableView reloadData];
            JB_TransferAccount_RecordViewController *vc = [[JB_TransferAccount_RecordViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
          

        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

- (void)setupHeaderOrFooter {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
    headerView.backgroundColor = kMainBackgroundColor;
    
    self.mainTableView.tableHeaderView = headerView;
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(65))];
    footerView.backgroundColor = kMainBackgroundColor;
    [footerView addSubview:self.submitButton];
    self.mainTableView.tableFooterView = footerView;;
}

#pragma mark -- ButtonClick
- (void)rigthBtnAction:(id)sender {
    JB_TransferAccount_RecordViewController *vc = [[JB_TransferAccount_RecordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)submitButtonClick {
    [self requestLicai];
}

- (void)createModels {
    [self.modelsArray removeAllObjects];
    for (NSInteger i = 0; i<self.titlesArray.count; i++) {
        JB_LendCoinModel *model = [[JB_LendCoinModel alloc]init];
        JB_LendChoiceCellType type = (JB_LendChoiceCellType)[self.typesArray[i] integerValue];
        UIKeyboardType keyboardType = (UIKeyboardType)[self.keyboradArray[i] integerValue];

        NSString *title = self.titlesArray[i];
        NSString *subTitle = self.subTitleArray[i];
        NSString *placeholder = self.placeholderArray[i];
        NSString *inputText = self.inputTextArray[i];
        model.type = type;
        model.title = title?:@"";
        model.subTitle = subTitle?:@"";
        model.inputPlaceHolder = placeholder?:@"";
        model.inputText = inputText?:@"";
        model.keyboardType = keyboardType;
        [self.modelsArray addObject:model];
    }
    
}



#pragma mark -- 网络请求

- (void)inputTFInfoWithModel:(JB_LendCoinModel *)model inputString:(NSString *)inputString {
    if ([model.title isEqualToString:SSKJLocalized(@"划转数量", nil)]) {
        [self.inputTextArray replaceObjectAtIndex:2 withObject:inputString];
    }
    if ([model.title isEqualToString:SSKJLocalized(@"安全密码", nil)]) {
        [self.inputTextArray replaceObjectAtIndex:3 withObject:inputString];
    }
    

}

#pragma mark -- UITableViewDelegate,UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {

        WS(weakSelf);
        [ETF_Default_ActionsheetView showWithItems:self.enumTitlesArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
            weakSelf.titleIndex = selectIndex;
            [weakSelf requestLicaiCoinListWithType:weakSelf.enumTitleKeyArray[selectIndex]];
        } cancleBlock:^{}];
    }
    if (indexPath.row == 1) {
        NSArray *coinsArray;
        if ([self.selectedTypeString isEqualToString:@"2"]) {
            coinsArray = [self.lcArray valueForKeyPath:@"mark"];
        }else{
            coinsArray = [self.zcArray valueForKeyPath:@"mark"];
        }
        WS(weakSelf);
        [ETF_Default_ActionsheetView showWithItems:coinsArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
            if ([self.selectedTypeString isEqualToString:@"2"]) {
                weakSelf.modelIndex = weakSelf.lcArray[selectIndex];
            }else{
                weakSelf.modelIndex = weakSelf.zcArray[selectIndex];
            }
            
            [weakSelf reloadCoinUsable];
        } cancleBlock:^{}];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titlesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    JB_LendChoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    
    NSArray *array = self.modelsArray;
    JB_LendCoinModel *model = array[indexPath.row];
    NSString *subTitle = self.subTitleArray[indexPath.row];
    NSString *placeholder = self.placeholderArray[indexPath.row];
    NSString *inputText = self.inputTextArray[indexPath.row];
    model.subTitle = subTitle;
    model.inputPlaceHolder = placeholder;
    model.inputText = inputText;
    
    
    if (array.count-1 == indexPath.row) {
        [cell configureCellWithModel:array[indexPath.row]
                          hiddenLine:YES];
    }else{
        [cell configureCellWithModel:array[indexPath.row]
                          hiddenLine:NO];
    }
    
    return cell;
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
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    
    }
    return _mainTableView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), ScaleW(20), ScreenWidth-ScaleW(25*2), ScaleW(45))];
        [_submitButton setTitle:SSKJLocalized(@"立即划转", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
        [_submitButton addGradientColor];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.layer.masksToBounds = YES;
        [_submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}
@end
