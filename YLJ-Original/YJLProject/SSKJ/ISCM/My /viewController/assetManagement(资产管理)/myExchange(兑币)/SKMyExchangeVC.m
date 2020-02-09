//
//  SKMyExchangeVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKMyExchangeVC.h"
//view
#import "HeBi_Convert_TopView.h"

#import "HeBi_Convert_MiddleView.h"

#import "HeBi_TitleAndInput_View.h"

#import "HeBi_Select_TableView.h"

// controller
#import "HeBi_ConvertRecord_ViewController.h"

// model
#import "HeBi_ConvertCoin_Model.h"
#import "HeBi_ConvertToCoin_Model.h"
#import "UIButton+LXMImagePosition.h"

@interface SKMyExchangeVC ()
@property (nonatomic, strong) UIView *topView;


@property (nonatomic, strong) NSDictionary * myDataDic;

@property (nonatomic, strong) UILabel *warninglabel;

@property (nonatomic, strong) HeBi_Convert_MiddleView *middleView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) HeBi_TitleAndInput_View *pwdView;// 密码
@property (nonatomic, strong) HeBi_TitleAndInput_View *smsCodeView;// 验证码
@property (nonatomic, strong) UIButton *smsCodeButton;  // 获取验证码按钮
@property (nonatomic, strong) UIButton *confirmButton;  // 确认按钮

@property (nonatomic, strong) NSArray *coinArray;
@property (nonatomic, strong) NSArray *convertCoinArray;

// 选择持有币种
@property (nonatomic, strong) HeBi_Select_TableView *coinTableView;

// 选择兑换币种
@property (nonatomic, strong) HeBi_Select_TableView *convertTableView;


// 持有资产model
@property (nonatomic, strong) HeBi_ConvertCoin_Model *coinModel;
// 要兑换的资产model
@property (nonatomic, strong) HeBi_ConvertToCoin_Model *convertModel;

@end

@implementation SKMyExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"兑换", nil);
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"cbjl_icon"]];
    [self setUI];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //    [self requestCoinList];
    
    [self requestAmount];
    
}

-(void)rigthBtnAction:(id)sender
{
    HeBi_ConvertRecord_ViewController *vc = [[HeBi_ConvertRecord_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.warninglabel];
    [self.view addSubview:self.middleView];
    [self.view addSubview:self.pwdView];
    //    [self.view addSubview:self.smsCodeView];
    //    [self.smsCodeView addSubview:self.smsCodeButton];
    [self.view addSubview:self.confirmButton];
}


-(UIView *)topView
{
    if (nil == _topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(12), ScreenWidth, ScaleW(141))];
      
        _topView.backgroundColor = [UIColor whiteColor];
        
        UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(20),ScreenWidth- ScaleW(15)*2 , _topView.height - ScaleW(20) *2)];
        
        borderView.layer.borderWidth = 1;
        borderView.layer.borderColor = WLColor(240,240,240, 1).CGColor;
        
        [_topView addSubview:borderView];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScaleW(15), ScaleW(38), ScaleW(15 + 11 + 28 +10), borderView.height-ScaleW(38) *2);
        
        button.backgroundColor = [UIColor clearColor];
        
        [button setTitle:@"ETH" forState:UIControlStateNormal];
        
        button.titleLabel.font = systemFont(15);
        [button setTitleColor:[UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        
        [button setImagePosition:LXMImagePositionLeft spacing:10];
        
        
        [borderView addSubview:button];
        
        
        UIImageView * imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScaleW(40),  ScaleW(40))];
        imageView.layer.cornerRadius = imageView.height/2;
        
        imageView.image =[UIImage imageNamed:@"duihuan"];
        
        imageView.center = CGPointMake(borderView.width/2, borderView.height/2);
        
        [borderView addSubview:imageView];
        
        
        UIButton * ISCMbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        ISCMbutton.frame = CGRectMake(borderView.right - ScaleW(65)-ScaleW(15), ScaleW(38), ScaleW(15 + 11 + 28 +10), borderView.height-ScaleW(38) *2);
        
        ISCMbutton.backgroundColor = [UIColor clearColor];
        
        [ISCMbutton setTitle:@"YEC" forState:UIControlStateNormal];
        
        ISCMbutton.titleLabel.font = systemFont(15);
        [ISCMbutton setTitleColor:[UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [ISCMbutton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        
        [ISCMbutton setImagePosition:LXMImagePositionLeft spacing:10];
        
        
        [borderView addSubview:ISCMbutton];
        
        
    }
    return _topView;
}

-(UILabel *)warninglabel
{
    if (nil == _warninglabel) {
        
  
        NSString *title = SSKJLocalized(@"账户中持有资产可按比例兑换为其他资产，兑换比例以行情为准", nil);
        
        _warninglabel = [WLTools allocLabel:title font:systemFont(ScaleW(12)) textColor:[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] frame:CGRectMake(0, self.topView.bottom, ScreenWidth, ScaleW(35)) textAlignment:NSTextAlignmentCenter];
        
        CGFloat height = [title boundingRectWithSize:CGSizeMake(_warninglabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_warninglabel.font} context:nil].size.height;
        
        _warninglabel.height = height + ScaleW(15);
        _warninglabel.backgroundColor = WLColor(246, 247, 251, 1);
    }
    return _warninglabel;
}

-(HeBi_Convert_MiddleView *)middleView
{
    if (nil == _middleView) {
        _middleView = [[HeBi_Convert_MiddleView alloc]initWithFrame:CGRectMake(0, self.warninglabel.bottom, ScreenWidth, ScaleW(0))];
        _middleView.backgroundColor = [UIColor whiteColor];
    }
    return _middleView;
}

-(HeBi_TitleAndInput_View *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.middleView.bottom + ScaleW(10), ScreenWidth, ScaleW(85)) leftGap:ScaleW(15) title:SSKJLocalized(@"安全密码", nil) placeHolder:SSKJLocalized(@"请输入安全密码", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecured:YES];
        _pwdView.secureButton.hidden = YES;
    }
    return _pwdView;
}

-(HeBi_TitleAndInput_View *)smsCodeView
{
    if (nil == _smsCodeView) {
        _smsCodeView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(85)) leftGap:ScaleW(15) title:SSKJLocalized(@"手机验证码", nil) placeHolder:SSKJLocalized(@"请输入手机验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecured:NO];
    }
    return _smsCodeView;
}

-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(85), 0, ScaleW(85), ScaleW(40))];
        _smsCodeButton.titleLabel.numberOfLines = 0;
        _smsCodeButton.centerY = self.smsCodeView.textField.centerY;
        [_smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton setTitleColor:kTextBlueColor forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(13));
        [_smsCodeButton addTarget:self action:@selector(getSmsCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsCodeButton;
}


-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15),self.pwdView.bottom + ScaleW(50), ScreenWidth - ScaleW(30), ScaleW(45))];
        _confirmButton.backgroundColor = WLColor(44,102,255, 1);
        [_confirmButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.cornerRadius = 4.0f;
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(HeBi_Select_TableView *)coinTableView
{
    if (nil == _coinTableView) {
        _coinTableView = [[HeBi_Select_TableView alloc]initWithFrame:CGRectMake(self.topView.bottom, self.topView.bottom, ScaleW(100), ScaleW(100))];
        _coinTableView.centerX = ScaleW(72);
        WS(weakSelf);
        _coinTableView.selectCoinBlock = ^(NSInteger index) {
            weakSelf.coinModel = weakSelf.coinArray[index];
            [weakSelf.middleView clearView];
            [weakSelf requestConvertListWithModel:weakSelf.coinModel];
            [weakSelf.coinTableView removeFromSuperview];
            
        };
    }
    return _coinTableView;
}

-(HeBi_Select_TableView *)convertTableView
{
    if (nil == _convertTableView) {
        _convertTableView = [[HeBi_Select_TableView alloc]initWithFrame:CGRectMake(self.topView.bottom, self.topView.bottom, ScaleW(100), ScaleW(100))];
        _convertTableView.centerX = ScreenWidth - ScaleW(72);
        WS(weakSelf);
        _convertTableView.selectCoinBlock = ^(NSInteger index) {
            [weakSelf.middleView clearView];
            weakSelf.convertCoinArray = weakSelf.convertCoinArray[index];
            [weakSelf.convertTableView removeFromSuperview];
        };
    }
    return _convertTableView;
}

#pragma mark - 用户操作

#pragma makr 获取验证码
-(void)getSmsCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"mobile"] = @"";
    
    params[@"type"] = @"3";
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:nil RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf changeCheckcodeButtonState];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}


#pragma mark - 倒计时
// 倒计时
- (void)changeCheckcodeButtonState {
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    WS(weakSelf);
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodeButton setTitle:SSKJLocalized(@"重新获取", nil) forState:UIControlStateNormal];
                weakSelf.smsCodeButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%ld秒后重新发送", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                weakSelf.smsCodeButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

#pragma mark - 网络请求
#pragma mark 请求币种列表
-(void)requestCoinList
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:@"" RequestType:RequestTypeGet Parameters:@{@"id":@""} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf handleConvertListWithModel:net_model];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)handleConvertListWithModel:(WL_Network_Model *)net_model
{
    self.coinArray = [HeBi_ConvertCoin_Model mj_objectArrayWithKeyValuesArray:net_model.data];
    
    if (self.coinArray.count != 0) {
        self.coinModel = self.coinArray.firstObject;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (HeBi_ConvertCoin_Model *model in self.coinArray) {
        [array addObject:model.code];
    }
    
    self.coinTableView.dataSource = array;
    
    [self requestConvertListWithModel:self.coinModel];
}

-(void)setCoinModel:(HeBi_ConvertCoin_Model *)coinModel
{
    _coinModel = coinModel;
    self.middleView.coinModel = coinModel;
    
}

#pragma mark 请求要兑换的币种列表

-(void)requestConvertListWithModel:(HeBi_ConvertCoin_Model *)model
{
    
    NSDictionary *param = @{
                            @"code":model.code
                            };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:@"" RequestType:RequestTypeGet Parameters:param Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf handleConvertToListWithModel:net_model];
        }else{
            weakSelf.convertModel = nil;
            weakSelf.convertTableView.dataSource = nil;
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)handleConvertToListWithModel:(WL_Network_Model *)net_model
{
    self.convertCoinArray = [HeBi_ConvertToCoin_Model mj_objectArrayWithKeyValuesArray:net_model.data];
    
    if (self.convertCoinArray.count != 0) {
        self.convertModel = self.convertCoinArray.firstObject;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (HeBi_ConvertToCoin_Model *model in self.convertCoinArray) {
        [array addObject:model.dealCode];
    }
    
    self.convertTableView.dataSource = array;
    
}


-(void)setConvertModel:(HeBi_ConvertToCoin_Model *)convertModel
{
    _convertModel = convertModel;
    self.middleView.convertModel = convertModel;
}


#pragma makr 确认兑换
-(void)confirmEvent
{
    if (self.middleView.ammount.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入兑换数量", nil)];
        return;
    }
    if (self.middleView.ammount.doubleValue == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"兑换数量不能为0", nil)];
        return;
    }
    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入安全密码", nil)];
        return;
    }
    
    //    if (self.smsCodeView.valueString.length == 0) {
    //        [MBProgressHUD showError:SSKJLocalized(@"请输入手机验证码", nil)];
    //        return;
    //    }
    
    [self requestConvert];
    
}

#pragma mark 请求兑换

-(void)requestConvert
{
    
    NSDictionary *param = @{
                            @"num":self.middleView.ammount,
                            @"tpwd":[WLTools md5:self.pwdView.valueString],
                            };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_Recognize_do_ex_Api RequestType:RequestTypePost Parameters:param Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf handleConfirConvertWithModel:net_model];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


-(void)handleConfirConvertWithModel:(WL_Network_Model *)net_model
{
    [self.middleView clearView];
    self.pwdView.valueString = @"";
    self.smsCodeView.valueString = @"";
    
    [self rigthBtnAction:@""];
}

-(void)requestAmount
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_Recognize_ex_pre_Api RequestType:RequestTypePost Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {

            self.myDataDic = net_model.data;
            
            weakSelf.middleView.exchangeFee = net_model.data[@"rate"];

        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
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
