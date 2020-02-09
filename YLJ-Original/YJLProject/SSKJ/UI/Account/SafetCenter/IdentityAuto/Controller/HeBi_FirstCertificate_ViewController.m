//
//  HeBi_FirstCertificate_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_FirstCertificate_ViewController.h"

// controller
#import "HeBi_CertificateSuccessed_ViewController.h"
#import "HeBi_CertificateFail_ViewController.h"

// tools
#import "RegularExpression.h"
#import "AFHTTPSessionManager.h"

@interface HeBi_FirstCertificate_ViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *nameView;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *idcardView;
@property (nonatomic, strong) UITextField *idcardTextField;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation HeBi_FirstCertificate_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"初级认证", nil);
    
    [self setUI];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.translucent = YES;
}
#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.nameView];
    [self.nameView addSubview:self.nameTextField];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.idcardView];
    [self.idcardView addSubview:self.idcardTextField];
    
    [self.view addSubview:self.submitButton];
}


-(UIView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(239))];
        _headerView.backgroundColor = kSubBackgroundColor;
        
        UIImage *image = [UIImage imageNamed:@"first_certificate_img"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(70), ScaleW(image.size.width), ScaleW(image.size.height))];
        imageView.centerX = _headerView.width / 2;
        imageView.image = image;
        [_headerView addSubview:imageView];

        UILabel *label = [WLTools allocLabel:SSKJLocalized(@"为保证您的账户安全，需要进行身份认证\n身份一旦认证无法修改，请仔细填写您的真实信息", nil) font:systemFont(ScaleW(12)) textColor:[UIColor colorWithHexStringToColor:@"878ff5"] frame:CGRectMake(ScaleW(15), imageView.bottom + ScaleW(30), ScreenWidth - ScaleW(30), ScaleW(30)) textAlignment:NSTextAlignmentCenter];
        label.numberOfLines = 0;
        [_headerView addSubview:label];

    }
    return _headerView;
}

- (UIView *)nameView
{
    if (nil == _nameView) {
        _nameView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom + ScaleW(10), ScreenWidth, ScaleW(50))];
        _nameView.backgroundColor = kSubBackgroundColor;
    }
    return _nameView;
}
-(UITextField *)nameTextField
{
    if (nil == _nameTextField){
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, self.nameView.width - ScaleW(30), self.nameView.height)];
        _nameTextField.textColor = kMainWihteColor;
//        _nameTextField.placeholder = SSKJLocalized(@"请输入您的姓名", nil);
//        [_nameTextField setValue:[UIColor colorWithHexStringToColor:@"5b5e95"] forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString:SSKJLocalized(@"请输入您的姓名", nil) attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexStringToColor:@"5b5e95"]}];
        
        _nameTextField.attributedPlaceholder = placeholderString1;
    }
    return _nameTextField;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.nameView.bottom, ScreenWidth, 1)];
        _lineView.backgroundColor = kLineGrayColor;
    }
    return _lineView;
}


- (UIView *)idcardView
{
    if (nil == _idcardView) {
        _idcardView = [[UIView alloc]initWithFrame:CGRectMake(0, self.lineView.bottom, ScreenWidth, ScaleW(50))];
        _idcardView.backgroundColor = kSubBackgroundColor;
    }
    return _idcardView;
}
-(UITextField *)idcardTextField
{
    if (nil == _idcardTextField){
        _idcardTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, self.nameView.width - ScaleW(30), self.nameView.height)];
        _idcardTextField.textColor = kMainWihteColor;
        _idcardTextField.placeholder = SSKJLocalized(@"请输入您的身份证号码", nil);
//        [_idcardTextField setValue:[UIColor colorWithHexStringToColor:@"5b5e95"] forKeyPath:@"_placeholderLabel.textColor"];
        
        NSMutableAttributedString *placeholderString1 = [[NSMutableAttributedString alloc] initWithString: SSKJLocalized(@"请输入您的身份证号码", nil) attributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexStringToColor:@"5b5e95"]}];
        
        _idcardTextField.attributedPlaceholder = placeholderString1;
    }
    return _idcardTextField;
}



-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        
        CGFloat height = ScaleW(20);
        if (IS_IPHONE_X_ALL) {
            height = ScaleW(35);
        }
        
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), ScreenHeight - height -ScaleW(45) - Height_NavBar, ScreenWidth - ScaleW(30), ScaleW(45))];
        _submitButton.backgroundColor = kMainTextColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _submitButton.layer.cornerRadius = _submitButton.height / 2;
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton addGradientColor];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.layer.masksToBounds = YES;
    }
    return _submitButton;
}

#pragma mark - 用户操作

-(void)submitEvent
{
    if (self.nameTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的姓名", nil)];
        return;
    }
    
    
    if (self.nameTextField.text.length < 2) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的姓名", nil)];
        return;
    }
    if ([RegularExpression deptNumInputShouldNumber:self.nameTextField.text?:@""]) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的姓名", nil)];
        return;
    }
    
    if (self.idcardTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的身份证号码", nil)];
        return;
    }
    
    if (![RegularExpression validateIdentityCard:self.idcardTextField.text]) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的身份证号码", nil)];
        return;
    }
    
    [self requestFirstCertificate];
}
- (BOOL) deptNameInputShouldChinese:(NSString *)name

{
    
    NSString *regex = @"[\u4e00-\u9fa5]+";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if ([pred evaluateWithObject:name]) {
        
        return YES;
    }
    
    return NO;
    
}

#pragma mark - 网络请求

-(void)requestFirstCertificate
{
    NSDictionary *params = @{@"card_num":self.idcardTextField.text,
                             @"realname":self.nameTextField.text,
                             @"type":@(1)};
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_SetPrimary_AuthURL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [SSKJ_User_Tool sharedUserTool].userInfoModel.status = @"3";
            [weakSelf.navigationController popViewControllerAnimated:YES];
//            HeBi_CertificateSuccessed_ViewController *vc = [[HeBi_CertificateSuccessed_ViewController alloc]init];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
            
//            NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:weakSelf.navigationController.viewControllers];
//            [mutArr removeObject:self];
//            self.navigationController.viewControllers = mutArr;
    
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}




-(void)backToLastVc
{
    
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
