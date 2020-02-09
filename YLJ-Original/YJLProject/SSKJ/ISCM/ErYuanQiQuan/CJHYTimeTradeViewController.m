
#import "CJHYTimeTradeViewController.h"
#import "CJHYButtonsView.h"
#import "CJHYTitleBtnView.h"
#import "CJHYTradeHandsView.h"
#import "CJHYTradeAmountView.h"

#import "TradeListModel.h"
#import "TradeCurrentCoinModel.h"

@interface CJHYTimeTradeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *codeNameLabel;

@property (nonatomic, strong) UILabel *currenPriceLabel;

@property (nonatomic, strong) UIButton *cancellBtn;

@property (nonatomic, strong) UIView *septorLine;

@property (nonatomic, strong) UILabel *tradeMoneyNameLabel;
//资产币种
@property (nonatomic, strong) CJHYButtonsView *codeTypeView;
//交易金额
@property (nonatomic, strong) CJHYTradeAmountView *tradeAmountView;
//目标点位
@property (nonatomic, strong) CJHYTitleBtnView *tradeTimeView;

@property (nonatomic, strong) UILabel *percentLabel;

@property (nonatomic, strong) UILabel *paybackLabel;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UIView *tapView;

@property (nonatomic, strong) NSMutableArray *coinListArray;

@property (nonatomic, strong) TradeListModel *currentListModel;

@property (nonatomic, strong) TradeCurrentCoinModel *currenMessageModel;
//当前交易手数
@property (nonatomic, strong) NSString *handCount;
@property (nonatomic, strong) NSString *reate;
@property (nonatomic, strong) NSString *usebleMoney;

@property (nonatomic, assign) double percentValue;

@property (nonatomic, strong) NSArray *timeArray; //交易周期数组

@property (nonatomic ,assign) BOOL isInputNum; //当前是否需要输入
@end

@implementation CJHYTimeTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    //默认一手
    self.handCount = @"1";
    [self viewConfig];
    [self requstTradeCodeList];

    
}

-(UIView *)tapView
{
    if (!_tapView) {
        _tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.mainView.height)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissAction:)];
        [_tapView addGestureRecognizer:tap];
        
        self.tapView.backgroundColor=[UIColor blackColor];
        
        self.tapView.alpha=0.5;
        
    }
    return _tapView;
}

-(void)viewConfig
{
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.tapView];
}
-(void)dissmissAction:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - ScaleW(370), ScreenWidth, ScaleW(370))];
        _mainView.backgroundColor =  [WLTools day:kMainWihteColor night:kBgColor];
        [_mainView addSubview:self.codeNameLabel];
        [_mainView addSubview:self.currenPriceLabel];
        [_mainView addSubview:self.cancellBtn];
        [_mainView addSubview:self.septorLine];
        [_mainView addSubview:self.tradeMoneyNameLabel];
        [_mainView addSubview:self.codeTypeView];
        [_mainView addSubview:self.tradeAmountView];
        //[_mainView addSubview:self.selectTypeHande];
        [_mainView addSubview:self.tradeTimeView];
        [_mainView addSubview:self.percentLabel];
        [_mainView addSubview:self.paybackLabel];
        [_mainView addSubview:self.commitBtn];
        
        
    }
    return _mainView;
}

-(UILabel *)codeNameLabel

{
    if (!_codeNameLabel) {
        UIColor *textColor = [WLTools day:kTextGrayColor333333 night:kMainWihteColor];
        _codeNameLabel = [WLTools allocLabel:@"--/--" font:systemBoldFont(ScaleW(16)) textColor:textColor frame:CGRectMake(ScaleW(5), ScaleW(22), ScaleW(110), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _codeNameLabel;
    
}

-(UILabel *)currenPriceLabel
{
    if (!_currenPriceLabel) {
        UIColor *currentColor = _tradeDerection == 1 ?GREEN_HEX_COLOR:RED_HEX_COLOR;
        _currenPriceLabel = [WLTools allocLabel:@"0000.0000" font:systemFont(ScaleW(16)) textColor:currentColor frame:CGRectMake(ScaleW(131), ScaleW(22), ScaleW(120), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _currenPriceLabel;
}

-(UIButton *)cancellBtn{
    if (!_cancellBtn) {
        _cancellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancellBtn.frame = CGRectMake(ScreenWidth - ScaleW(85), ScaleW(11), ScaleW(85), ScaleW(33));
        [_cancellBtn btn:_cancellBtn font:ScaleW(14) textColor:kSubTitleColor text:SSKJLocalized(@"取消", nil) image:nil sel:@selector(cancellbtnAction:) taget:self];
    }
    return _cancellBtn;
}
-(UIView *)septorLine
{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(5), _cancellBtn.bottom,ScreenWidth - ScaleW(10), ScaleW(1))];
        _septorLine.backgroundColor = kLineColor;
        
    }
    return _septorLine;
}
-(UILabel *)tradeMoneyNameLabel
{
    if (!_tradeMoneyNameLabel) {
        _tradeMoneyNameLabel = [WLTools allocLabel:SSKJLocalized(@"交易金额", nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(5), ScaleW(21) + _septorLine.bottom,ScaleW(65), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _tradeMoneyNameLabel;
}
#pragma mark 选择金额
-(CJHYButtonsView *)codeTypeView
{
    if (!_codeTypeView) {
        _codeTypeView = [[CJHYButtonsView alloc]init];
        _codeTypeView.left = _tradeMoneyNameLabel.right;
        _codeTypeView.top = _tradeMoneyNameLabel.top-ScaleW(20);

        
        WS(weakSelf);
        _codeTypeView.selectBtnBlock = ^(NSString * _Nonnull codeString) {
            for (TradeListModel *model in weakSelf.coinListArray) {
                if ([model.name isEqualToString:codeString]) {
                    
                    weakSelf.currentListModel = model;
                    
                }
               
            }
           
            if ([codeString isEqualToString:@"其他"]) {
                
                weakSelf.tradeAmountView.hidden=NO;
                self->_isInputNum=YES;
                
                self->_tradeAmountView.top = self->_tradeMoneyNameLabel.bottom+ScaleW(30);
                
                weakSelf.tradeTimeView.top = weakSelf.tradeAmountView.bottom;
              weakSelf.percentLabel.top=weakSelf.tradeTimeView.bottom+ScaleW(25);
                
                weakSelf.paybackLabel.top=weakSelf.percentLabel.top;

                weakSelf.commitBtn.top=weakSelf.percentLabel.bottom+ScaleW(20);
                


            }
            else{
                self->_isInputNum=NO;
                weakSelf.tradeAmountView.hidden=YES;
                
//                self->_tradeAmountView.top = self->_tradeMoneyNameLabel.bottom+ScaleW(30);
//
                weakSelf.tradeTimeView.top = weakSelf.tradeMoneyNameLabel.bottom+ScaleW(30);
                weakSelf.percentLabel.top=weakSelf.tradeTimeView.bottom+ScaleW(25);
                
                weakSelf.paybackLabel.top=weakSelf.percentLabel.top;
                
                weakSelf.commitBtn.top=weakSelf.percentLabel.bottom+ScaleW(20);
                
                [weakSelf tradeccaturulauTradeText: weakSelf.currentListModel.name];
                
                
            }
            [weakSelf clearData];
            
        };
    }
    return _codeTypeView;
}
#pragma mark 输入金额
-(CJHYTradeAmountView *)tradeAmountView
{
    if (!_tradeAmountView) {
        _tradeAmountView = [[CJHYTradeAmountView alloc]init];
        _tradeAmountView.top = _tradeMoneyNameLabel.bottom+ScaleW(10);
        _tradeAmountView.titleLabel.text = SSKJLocalized(@"交易金额", nil);
        _tradeAmountView.amountTf.placeholder=[NSString stringWithFormat:@"请输入大于%ld且是%ld的倍数",_maxnum,_num];
        
//        WS(weakSelf);
//        _tradeAmountView.buttonClickedBlock = ^(NSString * _Nonnull string) {
//            [weakSelf catulateTotalAmount];
//        };
        

        _tradeAmountView.amountTf.delegate = self;
        
        _tradeAmountView.hidden=YES;
    }
    return _tradeAmountView;
}
#pragma mark 选择周期
-(CJHYTitleBtnView *)tradeTimeView
{
    if (!_tradeTimeView) {
        _tradeTimeView = [[CJHYTitleBtnView alloc]init];
        _tradeTimeView.top = _codeTypeView.bottom;
//         _tradeTimeView.codeArray = @[@"3min",@"5min"];

        _tradeTimeView.titleLabel.text = SSKJLocalized(@"交易周期", nil);
        _tradeTimeView.buttonClickedBlock = ^(NSString * _Nonnull string) {
            
            
//
//                [weakSelf tradeccaturulauTradeText:weakSelf.tradeAmountView.amountTf.text];
          
           
        };
    }
    return _tradeTimeView;
}
#pragma mark 可用余额
-(UILabel *)percentLabel
{
    if (!_percentLabel) {
        _percentLabel = [WLTools allocLabel:SSKJLocalized(@"可用：--", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(5),_tradeTimeView.bottom+ScaleW(25), ScaleW(135), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
        
        _percentLabel.adjustsFontSizeToFitWidth=YES;
        
    }
    return _percentLabel;
}
#pragma mark 交易额
-(UILabel *)paybackLabel
{
    if (!_paybackLabel) {
        _paybackLabel = [WLTools allocLabel:SSKJLocalized(@"交易额：--", nil) font:systemFont(ScaleW(14)) textColor:kMainBlueColor frame:CGRectMake(ScaleW(150), _percentLabel.top, ScreenWidth-ScaleW(160), ScaleW(15)) textAlignment:(NSTextAlignmentRight)];
        
        _paybackLabel.adjustsFontSizeToFitWidth=YES;

    }
    return _paybackLabel;
}
-(NSMutableArray *)coinListArray
{
    if (!_coinListArray) {
        _coinListArray = [NSMutableArray array];
    }
    return _coinListArray;
}

-(UIButton *)commitBtn
{
    
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIColor *currentColor = _tradeDerection == 1 ?GREEN_HEX_COLOR:RGBCOLOR(255,87,85);
        _commitBtn.frame = CGRectMake(ScaleW(26), ScaleW(20) + _paybackLabel.bottom, ScaleW(325), ScaleW(45));
        _commitBtn.backgroundColor = currentColor;
        [_commitBtn btn:_commitBtn font:ScaleW(15) textColor:kMainWihteColor text:_tradeDerection == 1 ?SSKJLocalized(@"买涨", nil):SSKJLocalized(@"买跌", nil) image:nil sel:@selector(commitActionAction:) taget:self];
        
        _commitBtn.layer.cornerRadius = ScaleW(45/2.f);
        
        
    }
    return _commitBtn;
}
-(void)commitActionAction:(UIButton *)sender
{
    
    NSString *num;//金额
    
    if (_isInputNum) {
        
        if (_tradeAmountView.amountTf.text.doubleValue == 0) {
            
            [MBProgressHUD showError:SSKJLocalized(@"请输入交易金额", nil)];
            
            return;
            
        }
        else{
            
            num=_tradeAmountView.amountTf.text;
            
        }
    }
    else{
        
        num=_currentListModel.name;
        
    }
    
//    if (_tradeAmountView.amountTf.text.doubleValue< _currentListModel.min_num.floatValue) {
//        [MBProgressHUD showError:SSKJLocalized(@"输入数量小于最小数量", nil)];
//        return;
//    }
//  if(_tradeAmountView.amountTf.text.doubleValue>_currentListModel.max_num.floatValue) {
//        [MBProgressHUD showError:SSKJLocalized(@"输入数量大于最大数量",
//                                               nil)];
//      return;
//
//    }
    //    type    是    int    1买涨 2买跌
    //    ptype    是    string    资产币种:USDT BTC ETH EOS,字母大写
    //    unit_num    是    float    交易量
    //    num    是    int    认购手数
    //    pid    是    int    交易币种pid
    //    aim_point    是    int    目标点位
    
    // Mine_create_order_URL
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
//    NSDictionary *params = @{@"type":@(_tradeDerection),@"ptype":self.codeTypeView.currentText,@"num":_tradeAmountView.amountTf.text,@"pid":self.currenMessageModel.pid,@"aim_point":[self.tradeTimeView.currentText stringByReplacingOccurrencesOfString:@"S" withString:@""]};
    
    NSMutableDictionary *params=[NSMutableDictionary new];
    
    NSString *time=[NSString stringWithFormat:@"%@",_timeArray[self.tradeTimeView.currenIndex]];
    NSString *code_type;
    
    if ([_currentModel.code hasPrefix:@"btc"]) {
        
        code_type=@"1";
    }
    else if ([_currentModel.code hasPrefix:@"eth"])
    {
         code_type=@"3";
    }
    [params setObject:time forKey:@"order_cycle"];
    [params setObject:code_type forKey:@"coin_type"];
    [params setObject:@(_tradeDerection) forKey:@"order_type"];
    [params setObject:num forKey:@"buy_num"];

    SsLog(@"params::%@",params);
    
//    order_cycle    是    string    交易周期 3 三min 5 五min
//    coin_type    是    string    币种类型行情 1 BTC/USDT,3 ETH/USDT
//    order_type    是    string    订单类型 1买涨 2买跌
//    buy_num
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:KQiQuanBuy RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             !self.buySucessBlock?:self.buySucessBlock();
             [self dismissViewControllerAnimated:YES completion:^{
                 
             }];
             
            
         }
             
             [MBProgressHUD showError:network_Model.msg];

         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD showError:error.localizedDescription];

         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
     }];
}
-(void)cancellbtnAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark ------长连接刷新数据


-(void)setCurrentModel:(JB_Market_Index_Model *)currentModel

{
    _currentModel = currentModel;
    
    if (_currentModel == nil) {
        return;
    }
    // self.currenPriceLabel.text = [WLTools noroundingStringWith:_currentModel.price.doubleValue afterPointNumber:[self pointCount:_currentModel.code]];
    
    
    self.currenPriceLabel.text =  [WLTools noroundingStringWith:_currentModel.price.doubleValue afterPointNumber:[self pointCount:self.currentModel.code]];
    self.codeNameLabel.text = [_currentModel.code.uppercaseString stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    
//    [self tradeccaturulauTrade];
    
}
#pragma mark 获取配置信息
-(void)requstTradeCodeList
{
    // Mine_wall_list_URL
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{
                             
                             };
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:KQiQuanSettting RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             [self.coinListArray removeAllObjects];
             
             NSArray *array=[network_Model.data objectForKey:@"order_price"];
             
             self.reate = [network_Model.data objectForKey:@"trans_fee"];
             
             self.usebleMoney = [network_Model.data objectForKey:@"wallfour"];
             self->_percentLabel.text = [NSString stringWithFormat:@"可用  %@ ",[WLTools noroundingStringWith:self.usebleMoney.doubleValue afterPointNumber:2]];
             
             for (NSString *str  in array) {
                 
                 TradeListModel *model = [[TradeListModel alloc]init];
                 
                 model.name=str;
            
                 
                 [self.coinListArray addObject:model];
             }
             
        
            TradeListModel *model = [[TradeListModel alloc]init];
             
             model.name=@"其他";
             [self.coinListArray addObject:model];
             
             weakSelf.currentListModel = self.coinListArray.firstObject;
             
             weakSelf.codeTypeView.codeArray=self.coinListArray;
            [weakSelf tradeccaturulauTradeText: weakSelf.currentListModel.name];
             
             self->_timeArray = [network_Model.data objectForKey:@"order_cycle"];
             
             weakSelf.tradeTimeView.codeArray=self->_timeArray;
             
//             [weakSelf setDefultValue];
             //[self catulateTotalAmount];
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
     }];
}
-(void)requstTradeListRequst
{
    ///home/Contract/pro_list Mine_pro_list_URL
    // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{
                             @"type":@"2"
                             };
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:@"" RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             
             for (NSDictionary *dic  in network_Model.data) {
                 if ([dic[@"mark"] isEqualToString:self.currentModel.code]) {
                     TradeCurrentCoinModel *model = [[TradeCurrentCoinModel alloc]init];
                     [model setValuesForKeysWithDictionary:dic];
                     self.currenMessageModel = model;
                     break;
                 }
                 
             }
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
     }];
}
-(void)setDefultValue{
//    NSMutableArray *codeNameArray = [NSMutableArray array];
//    for (TradeListModel *model in self.coinListArray) {
//        [codeNameArray addObject:model.pname];
//    }
//    self.codeTypeView.codeArray = self.coinListArray;
//    for (TradeListModel *model in self.coinListArray) {
//        if ([model.pname isEqualToString:self.self.codeTypeView.currentText])
//        {
//            self.currentListModel = model;
//        }
//    }
    
    self.currentListModel = self.coinListArray.firstObject;

    
    //[self catulateTotalAmount];
    
}

#pragma mark -------信息model

-(void)setCurrenMessageModel:(TradeCurrentCoinModel *)currenMessageModel
{
    _currenMessageModel = currenMessageModel;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    for (id objc in _currenMessageModel.aim_point) {
        [titleArray addObject:[NSString stringWithFormat:@"%@S",objc]];
    }
    self.tradeTimeView.codeArray = titleArray;
    
    _percentValue = [_currenMessageModel.odds[self.tradeTimeView.currenIndex] doubleValue];
   
    
     [self tradeccaturulauTradeText:_tradeAmountView.amountTf.text];
    
    
}
-(void)setCurrentListModel:(TradeListModel *)currentListModel
{
    _currentListModel = currentListModel;
    
    [self tradeccaturulauTradeText:_tradeAmountView.amountTf.text];
    
    [self clearData];
    
}
#pragma mark ---计算交易金额

-(void)tradeccaturulauTradeText:(NSString *)text
{

    double num=[text doubleValue];
    
    
    double value = num+num*[self.reate doubleValue ]/100.0;
    _paybackLabel.text = [NSString stringWithFormat:@"%@%@ %@",SSKJLocalized(@"交易额 ", nil),[WLTools noroundingStringWith:value afterPointNumber:2],@""];
   
}

#pragma mark ----计算交易量

//-(void)catulateTotalAmount
//{
//   // double totalAmount =  _handCount.doubleValue*self.tradeAmountView.currentText.doubleValue;
////    NSString *amount =  [WLTools noroundingStringWith:totalAmount afterPointNumber:[self point:self.codeTypeView.currentText]];
////
////    self.paybackLabel.text = [NSString stringWithFormat:SSKJLocalized(@"交易总额：%@%@", nil),amount,self.codeTypeView.currentText?:@"--"];
//}



-(NSInteger)pointCount:(NSString *)code
{
    /*币种
     btc/usdt  2位
     ltc/usdt 2位
     eth/usdt 2位
     etc/usdt 4位
     zec/usdt 2位
     eos/usdt 4位
     xrp/usdt 4位
     trx/usdt 6位
     dash/usdt  2位
     bch/usdt 2位*/
    if ([code.lowercaseString isEqualToString:@"btc/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"ltc/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eth/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"etc/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"zec/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"eos/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"xrp/usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"trx/usdt"]) {
        return 6;
    }
    if ([code.lowercaseString isEqualToString:@"dash/usdt"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"bch/usdt"]) {
        return 2;
    }
    return 4;
    
}
-(NSInteger)point:(NSString *)code
{
    
    if ([code.lowercaseString isEqualToString:@"btc"]) {
        return 6;
    }
    
    if ([code.lowercaseString isEqualToString:@"eth"]) {
        return 5;
    }
    if ([code.lowercaseString isEqualToString:@"eos"]) {
        return 2;
    }
    if ([code.lowercaseString isEqualToString:@"usdt"]) {
        return 2;
    }
    return 4;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requstTradeListRequst];
    //预期回报
}

#pragma mark ---------TextFiledDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * inputString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([string isEqualToString:@""]) {
         [self tradeccaturulauTradeText:inputString];
        return YES;
    }
   
    if (inputString.floatValue > _currentListModel.max_num.floatValue) {
        //[MBProgressHUD showError:SSKJLocalized(@"输入数量大于最大数量",
                                               //nil)];
        [self tradeccaturulauTradeText:inputString];
        return YES;
    }else
    {
        [self tradeccaturulauTradeText:inputString];
        return YES;
    }
   
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //
//    if (textField.text.floatValue < _currentListModel.min_num.floatValue) {
//        [MBProgressHUD showError:SSKJLocalized(@"输入数量小于最小数量", nil)];
//        _paybackLabel.text =  SSKJLocalized(@"预期回报：--", nil);
//    }else{
//
//    }
    
    if (!_isInputNum) {
        
        
        return;
        
        
    }
    NSInteger num=[textField.text integerValue];
    
    if (num >=_maxnum && num %_num ==0) {
        
       
        [self tradeccaturulauTradeText:_tradeAmountView.amountTf.text];

    }
    else{
        _paybackLabel.text=nil;
        NSString *msg=[NSString stringWithFormat:@"请输入大于%ld且是%ld的倍数",_maxnum,_num];
        
        showAlert(msg);
        
    }
}

-(void)clearData
{
    self.tradeAmountView.amountTf.text = nil;
    
}



@end
