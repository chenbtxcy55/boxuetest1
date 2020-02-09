//
//  HeBi_AddAddress_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/11.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_AddAddress_ViewController.h"

// controller
#import "QBScanCodeViewController.h"

// tools
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>//相册

@interface HeBi_AddAddress_ViewController ()

@property (nonatomic, strong) UILabel *addressTitleLabel;

@property (nonatomic, strong) UIView *addressBackView;
@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, strong) UIButton *sweepButton;    // 扫描按钮
//@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *remarkTitleLabel;

@property (nonatomic, strong) UIView *remarkBackView;
@property (nonatomic, strong) UITextField *remarkTextField;

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation HeBi_AddAddress_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"添加地址", nil);
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - UI

-(void)setUI
{
//    [self.view addSubview:self.addressTitleLabel];

    [self.view addSubview:self.addressBackView];
    [self.addressBackView addSubview:self.addressTitleLabel];
    [self.addressBackView addSubview:self.sweepButton];
    [self.addressBackView addSubview:self.addressTextField];
//    [self.addressBackView addSubview:self.lineView];

    
    [self.view addSubview:self.remarkBackView];
    [self.remarkBackView addSubview:self.remarkTitleLabel];
    [self.remarkBackView addSubview:self.remarkTextField];
    
    [self.view addSubview:self.addButton];
    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.addressBackView.bottom, ScreenWidth, 1)];
//    line.backgroundColor = kLineGrayColor;
//    [self.view addSubview:line];
}


-(UILabel *)addressTitleLabel
{
    if (nil == _addressTitleLabel) {
        _addressTitleLabel = [WLTools allocLabel:[NSString stringWithFormat:@"  %@",SSKJLocalized(@"地址", nil)] font:systemMediumFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(0, 0, ScreenWidth, ScaleW(46)) textAlignment:NSTextAlignmentLeft];
        _addressTitleLabel.backgroundColor = kNavBGColor;
    }
    return _addressTitleLabel;
}


-(UIView *)addressBackView
{
    if (nil == _addressBackView) {
        _addressBackView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth, ScaleW(46+50))];
        _addressBackView.backgroundColor = kNavBGColor;
    }
    return _addressBackView;
}

-(UIButton *)sweepButton
{
    if (nil == _sweepButton) {
        _sweepButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(50), ScaleW(46), ScaleW(50), ScaleW(52))];
        [_sweepButton setImage:[UIImage imageNamed:@"my_saoma"] forState:UIControlStateNormal];
        [_sweepButton addTarget:self action:@selector(sweepEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sweepButton;
}

-(UITextField *)addressTextField
{
    if (nil == _addressTextField) {
        _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleW(46), ScreenWidth - ScaleW(12) *2-ScaleW(50), ScaleW(50))];
        _addressTextField.textColor = [UIColor whiteColor];
        _addressTextField.font = systemFont(ScaleW(15));
        _addressTextField.placeholder = SSKJLocalized(@"请输入钱包地址", nil);
        _addressTextField.keyboardType = UIKeyboardTypeASCIICapable;
//        [_addressTextField setValue:WLColor(142,148,163, 1) forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:SSKJLocalized(@"请输入钱包地址", nil) attributes:@{NSForegroundColorAttributeName : kSubTxtColor}];
        
        self.addressTextField.attributedPlaceholder = placeholderString;
    }
    return _addressTextField;
}


-(UILabel *)remarkTitleLabel
{
    if (nil == _remarkTitleLabel) {
        _remarkTitleLabel = [WLTools allocLabel:[NSString stringWithFormat:@"  %@",SSKJLocalized(@"描述", nil)] font:systemMediumFont(ScaleW(15)) textColor:kMainTextColor frame:CGRectMake(0, 0, ScreenWidth, ScaleW(46)) textAlignment:NSTextAlignmentLeft];
        _remarkTitleLabel.backgroundColor = kNavBGColor;

    }
    return _remarkTitleLabel;
}


-(UIView *)remarkBackView
{
    if (nil == _remarkBackView) {
        _remarkBackView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(46 +50), ScreenWidth, ScaleW(46 +50))];
        _remarkBackView.backgroundColor = kNavBGColor;
    }
    return _remarkBackView;
}


-(UITextField *)remarkTextField
{
    if (nil == _remarkTextField) {
        _remarkTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleW(46), ScreenWidth - ScaleW(30)-ScaleW(75), ScaleW(50))];
        _remarkTextField.textColor = [UIColor whiteColor];
        _remarkTextField.font = systemFont(ScaleW(15));
        _remarkTextField.placeholder = SSKJLocalized(@"填写备注信息", nil);
        _remarkTextField.keyboardType = UIKeyboardTypeASCIICapable;
//        [_remarkTextField setValue:WLColor(142,148,163, 1) forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:SSKJLocalized(@"填写备注信息", nil) attributes:@{NSForegroundColorAttributeName : kSubTxtColor}];
        
        self.remarkTextField.attributedPlaceholder = placeholderString;
    }
    return _remarkTextField;
}


-(UIButton *)addButton
{
    if (nil == _addButton) {
        
        _addButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), ScreenHeight - Height_NavBar - ScaleW(45) - ScaleW(39), ScreenWidth - ScaleW(30), ScaleW(45))];
        [_addButton setTitle:SSKJLocalized(@"添加", nil) forState:UIControlStateNormal];
        [_addButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _addButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _addButton.layer.cornerRadius = _addButton.height / 2;
        [_addButton addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
        [_addButton addGradientColor];
        _addButton.layer.cornerRadius = ScaleW(5);
        _addButton.layer.masksToBounds = YES;
//        [_addButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_addButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _addButton.backgroundColor = kTheMeColor;
    }
    return _addButton;
}

#pragma mark - 用户操作

// 扫描

-(void)sweepEvent
{
    [self videoAuthAction];
    
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //NSString *tips = @"您没有权限访问相机,请去设置中开启！";
    if(status == AVAuthorizationStatusAuthorized)
    {
        QBScanCodeViewController *scan = [[QBScanCodeViewController alloc]init];
        WS(weakSelf);
        scan.codeScaningString = ^(NSString *string) {
            weakSelf.addressTextField.adjustsFontSizeToFitWidth = YES;
            weakSelf.addressTextField.text = string;
        };
        [self.navigationController pushViewController:scan animated:YES];
        
    }
    
}

//授权相机
- (void)videoAuthAction
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        SsLog(@"%@",granted ? SSKJLocalized(@"相机准许", nil):SSKJLocalized(@"相机不准许", nil));
        [self checkVideoStatus];
    }];
}

//检查相机权限
- (void)checkVideoStatus
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启相机
            //self.videoStatus = @"AVAuthorizationStatusNotDetermined";
            break;
        case AVAuthorizationStatusRestricted:
            //未授权，家长限制
            //self.videoStatus = @"AVAuthorizationStatusRestricted";
            break;
        case AVAuthorizationStatusDenied:
            //未授权
            // self.videoStatus = @"AVAuthorizationStatusDenied";
            break;
        case AVAuthorizationStatusAuthorized:
            //玩家授权
            // self.videoStatus = @"AVAuthorizationStatusAuthorized";
            break;
        default:
            break;
    }
    
}

// 确认添加
-(void)addEvent
{
    if (self.addressTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入钱包地址", nik)];
        return;
    }
    
    if (self.remarkTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请填写备注信息", nik)];
        return;
    }
    [self requestAddAddress];
    
}

#pragma mark - 网络请求
#pragma mark  请求添加地址

-(void)requestAddAddress
{
    
    NSDictionary *params = @{
                            @"address":self.addressTextField.text,
                            @"notes":self.remarkTextField.text,
                            @"type":[self.coinType lowercaseString]
                            };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_add_AddrManage_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showError:network_model.msg];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
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
