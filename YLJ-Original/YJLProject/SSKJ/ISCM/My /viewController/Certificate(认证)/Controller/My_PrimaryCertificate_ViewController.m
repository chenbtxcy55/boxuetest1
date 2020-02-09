//
//  My_PrimaryCertificate_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_PrimaryCertificate_ViewController.h"
#import "My_TitleAndInput_View.h"
#import "RegularExpression.h"


@interface My_PrimaryCertificate_ViewController ()

@property (nonatomic, strong) UITextField *nameTextField;  //!< 用户名视图
@property (nonatomic, strong) UITextField *idViewTextField;  //!< 身份证视图
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation My_PrimaryCertificate_ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"初级认证", nil);
    
    self.view.backgroundColor = kBgColor;
    
    [self setUI];
}






#pragma mark - Getter / Setter
-(void)setUI
{
    
    //Base style for 矩形 6
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(239))];
    style.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:style];
    
    UIImageView * iconImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScaleW(84), ScaleW(66))];
    iconImageView.center = CGPointMake(ScreenWidth/2, ScaleW(71) + iconImageView.height/2);
    iconImageView.image = [UIImage imageNamed:@"webicon301"];
    [style addSubview:iconImageView];
    
    UILabel * showLab = [[UILabel alloc] initWithFrame:CGRectMake( ScaleW(15), iconImageView.bottom +ScaleW(30), ScreenWidth - ScaleW(15)*2, ScaleW(40))];
    
    showLab.textColor = kMainBlueColor;
    
    showLab.font = systemScaleFont(13);
    showLab.numberOfLines = 0;
    
    showLab.text = @"为保障您的账户安全，需要进行身份验证\n身份一旦认证无法修改，请仔细填写您的真实信息";
    showLab.textAlignment = NSTextAlignmentCenter;
    
    [style addSubview:showLab];
    
    UIView *nameBgView =[[UIView alloc] initWithFrame:CGRectMake(0, style.bottom +10, ScreenWidth, ScaleW(50))];
    nameBgView.backgroundColor =[UIColor whiteColor];
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(15)*2, ScaleW(50))];
    _nameTextField.textColor = [UIColor blackColor];
    _nameTextField.font = systemFont(ScaleW(15));
    _nameTextField.placeholder = @"请输入您的姓名";
    [_nameTextField setValue:kTitleGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [nameBgView addSubview:_nameTextField];
    
    [self.view addSubview:nameBgView];
    
    UIView *idCardBgView =[[UIView alloc] initWithFrame:CGRectMake(0, nameBgView.bottom+1, ScreenWidth, ScaleW(50))];
    idCardBgView.backgroundColor =[UIColor whiteColor];
    _idViewTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(15)*2, ScaleW(50))];
    _idViewTextField.textColor = [UIColor blackColor];
    _idViewTextField.font = systemFont(ScaleW(15));
    _idViewTextField.placeholder = @"请输入您的身份证号码";
    [_idViewTextField setValue:kTitleGrayColor forKeyPath:@"_placeholderLabel.textColor"];
    [idCardBgView addSubview:_idViewTextField];
    [self.view addSubview:idCardBgView];
    
   
    [self.view addSubview:self.submitButton];
}


-(UIButton *)submitButton
{
    if (nil == _submitButton)
    {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.view.bottom - ScaleW(70) - Height_NavBar, ScreenWidth - ScaleW(24), ScaleW(45))];
        _submitButton.layer.cornerRadius = 4.0f;
        _submitButton.backgroundColor = kMainBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(void)submitEvent
{
    
    [self.view endEditing:YES];
    
    NSString *name = self.nameTextField.text;
    NSString *idNumber = self.idViewTextField.text;
    if (name.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的真实姓名", nil)];
        return;
    }
    
    if (idNumber.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的身份证号码", nil)];
        return;
    }
    
    if (![RegularExpression validateIdentityCard:idNumber])
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的身份证号", nil)];
        return;
    }
    
    
    [self requestPrimaryCertificate:name withIDentity:idNumber];
}


#pragma mark - NetWork Method 网络请求
- (void)requestPrimaryCertificate:(NSString*)name withIDentity:(NSString*)identity
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{@"username":name,
                             @"idCardNo":identity,
                             @"id":@""};
    
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:@"" RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netWorkModel.status.integerValue == SUCCESSED )
        {
            [MBProgressHUD showSuccess:SSKJLocalized(@"提交成功", nil)];
            if (weakSelf.successBlock)
            {
                weakSelf.successBlock(name,identity);
                
                [[SSKJ_User_Tool sharedUserTool].userInfoModel setBasicAuthenticationStatus:@"1"];
                [[SSKJ_User_Tool sharedUserTool].userInfoModel setUsername:name];
//                [[SSKJ_User_Tool sharedUserTool].userInfoModel setIdCard:identity];
                
                
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}


@end
