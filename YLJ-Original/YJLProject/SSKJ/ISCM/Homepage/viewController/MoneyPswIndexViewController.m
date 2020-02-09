//
//  MoneyPswIndexViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/7/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MoneyPswIndexViewController.h"

@interface MoneyPswIndexViewController ()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *nameVerCodeLabel;

@property (nonatomic, strong) UITextField *pleaseTextFiled;

@property (nonatomic, strong) UIButton *cancellBtn;

@property (nonatomic, strong) UIButton *ensureBtn;

@property (nonatomic, strong) UIView *dismissView;




@end

@implementation MoneyPswIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
    self.view.backgroundColor = kClearBackColor;
}
-(void)viewConfig
{
    [self.view addSubview:self.mainView];
    
    [self.view addSubview:self.dismissView];
    
    
    [self.mainView addSubview:self.nameVerCodeLabel];
    
    [self.mainView addSubview:self.pleaseTextFiled];
    
    [self.mainView addSubview:self.cancellBtn];
    
    [self.mainView addSubview:self.ensureBtn];
    
}

-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - ScaleW(222), ScreenWidth, ScaleW(222))];
        
        _mainView.backgroundColor = kMainWihteColor;
    }
    return _mainView;
}
-(UIView *)dismissView
{
    if (!_dismissView) {
        _dismissView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - _mainView.height)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_dismissView addGestureRecognizer:tap];
        
    }
    return _dismissView;
}
-(UILabel *)nameVerCodeLabel{
    if (!_nameVerCodeLabel){
        _nameVerCodeLabel = [WLTools allocLabel:@"安全密码安全验证" font:systemBoldFont(ScaleW(17)) textColor:kTitleColor frame:CGRectMake(0, 0, ScreenWidth, ScaleW(77)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _nameVerCodeLabel;
}
-(UITextField *)pleaseTextFiled
{
    if (!_pleaseTextFiled) {
        _pleaseTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, _nameVerCodeLabel.bottom, ScreenWidth, ScaleW(50))];
        [_pleaseTextFiled textField:_pleaseTextFiled textFont:ScaleW(15) placeHolderFont:ScaleW(15) text:nil placeText:@"请输入安全密码" textColor:kTitleColor placeHolderTextColor:kSubTitleColor];
        _pleaseTextFiled.leftViewMode = UITextFieldViewModeAlways;
        _pleaseTextFiled.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(14), ScaleW(ScaleW(50)))];
        _pleaseTextFiled.backgroundColor = kBgColor;
        _pleaseTextFiled.secureTextEntry = YES;
        
        
    }
    return _pleaseTextFiled;
}

-(UIButton *)cancellBtn
{
    if (!_cancellBtn) {
        _cancellBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancellBtn btn:_cancellBtn font:ScaleW(15) textColor:kMainBlueColor text:SSKJLocalized(@"取消", nil) image:nil sel:@selector(cancellAction:) taget:self];
        _cancellBtn.frame = CGRectMake(ScaleW(15), ScaleW(30) + _pleaseTextFiled.bottom, ScaleW(168), ScaleW(45));
        _cancellBtn.layer.cornerRadius = ScaleW(5);
        
        [_cancellBtn setBorderWithWidth:1 andColor:kMainBlueColor];
        
        
        
    }
    return _cancellBtn;
}
-(UIButton *)ensureBtn
{
    if (!_ensureBtn) {
        _ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ensureBtn btn:_ensureBtn font:ScaleW(15) textColor:kMainWihteColor text:@"确定" image:nil sel:@selector(ensureBtnAction:) taget:self];
        _ensureBtn.backgroundColor = kMainBlueColor;
        
        _ensureBtn.layer.cornerRadius = ScaleW(5);
        _ensureBtn.frame = CGRectMake(ScaleW(10) + _cancellBtn.right, ScaleW(30) + _pleaseTextFiled.bottom, ScaleW(168), ScaleW(45));
        
    }
    return _ensureBtn;
}
-(void)cancellAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)ensureBtnAction:(UIButton *)sender
{
    [self requestbuyLocked];
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)requestbuyLocked {
    
    if (!_pleaseTextFiled.text.length) {
        [MBProgressHUD showError:_pleaseTextFiled.placeholder];
        return;
    }
    
    WS(weakSelf);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
 
    
   
    params[@"tpwd"] = [WLTools md5:self.pleaseTextFiled.text];
    params[@"id"] = _idString;
   
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_add_Abuy_lock_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            !self.sucessBlock?:self.sucessBlock();
           [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            
        }
        [MBProgressHUD showError:network_model.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //[MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
    
}

@end
