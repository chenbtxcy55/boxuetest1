//
//  BLMangeAddressViewController.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/3/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BLMangeAddressViewController.h"
#import "QBScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>//相册
@interface BLMangeAddressViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopContraint;
@property (weak, nonatomic) IBOutlet UILabel *dizhiLable;
@property (weak, nonatomic) IBOutlet UILabel *beizhulabel;
@property (weak, nonatomic) IBOutlet UIView *addressBackView;
@property (weak, nonatomic) IBOutlet UIView *remarkBackView;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;


@end

@implementation BLMangeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"添加提币地址", nil);
    
    self.view.backgroundColor = kMainBackgroundColor;
    self.addressBackView.backgroundColor = SKRandomColor;
    self.remarkBackView.backgroundColor = SKRandomColor;
    self.dizhiLable.textColor = SKRandomColor;
    self.beizhulabel.textColor = SKRandomColor;
    self.addressTextField.textColor = SKRandomColor;
    self.noteTextField.textColor = SKRandomColor;
    
    self.TopContraint.constant = ScaleW(12);
    self.addressTextField.adjustsFontSizeToFitWidth = YES;
    self.addressTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.noteTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.addressTextField.placeholder=SSKJLocalized(@"请输入钱包地址", nil);
//    [self.addressTextField setValue:kTextBlueColor forKeyPath:@"_placeholderLabel.textColor"];
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:SSKJLocalized(@"请输入钱包地址", nil) attributes:@{NSForegroundColorAttributeName : kTextBlueColor}];
    
    self.addressTextField.attributedPlaceholder = placeholderString;
    
//    self.noteTextField.placeholder = SSKJLocalized(@"请输入备注信息", nil);
//    
//    [self.noteTextField setValue:SKRandomColor forKeyPath:@"_placeholderLabel.textColor"];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:SSKJLocalized(@"请输入备注信息", nil) attributes:
                                      @{NSForegroundColorAttributeName:kSubTxtColor,
                                        }];
    self.noteTextField.attributedPlaceholder = attrString;
    
    self.dizhiLable.text = SSKJLocalized(@"地址", nil);
    self.beizhulabel.text = SSKJLocalized(@"备注", nil);
    [self.confirmButton setTitle:SSKJLocalized(@"提交", nil) forState:0];
    self.confirmButton.backgroundColor = kTextBlueColor;
//    [self initConfig];
}

- (void)initConfig {
    
//    self.confirmButton.enabled = NO;
//    self.confirmButton.backgroundColor = kDisableColor;
//    [kNotifyCenter addObserver:self selector:@selector(textValueChanged) name:UITextFieldTextDidChangeNotification object:_addressTextField];
//    [kNotifyCenter addObserver:self selector:@selector(textValueChanged) name:UITextFieldTextDidChangeNotification object:_noteTextField];
    
}
- (IBAction)scanCodeClicked:(UIButton *)sender
{
 
    [self videoAuthAction];

    
     AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //NSString *tips = @"您没有权限访问相机,请去设置中开启！";
    if(status == AVAuthorizationStatusAuthorized)
    {
        QBScanCodeViewController *scan = [[QBScanCodeViewController alloc]init];
        __weak BLMangeAddressViewController *weakSelf = self;
        scan.codeScaningString = ^(NSString *string) {
            
            weakSelf.addressTextField.adjustsFontSizeToFitWidth = YES;
            weakSelf.addressTextField.text = string;
        };
        NSInteger count = self.tabBarController.viewControllers.count;
        self.tabBarController.selectedIndex = count - 1;
        [self.navigationController pushViewController:scan animated:YES];
        
    }
    else
    {
       // [MBProgressHUD showError:tips];
//
//        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//
//            [[UIApplication sharedApplication]openURL:url];
//
//        }
        
//        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许该应用访问您的相机\n设置>隐私>相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alart show];
        
        
    }

    
   
    
    
}

//授权相机
- (void)videoAuthAction
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        SsLog(@"%@",granted ? @"相机准许":@"相机不准许");
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


- (void)textValueChanged {
//    if (_addressTextField.text.length != 0 && _noteTextField.text.length != 0 ) {
//        _confirmButton.enabled = YES;
//        _confirmButton.backgroundColor = MainTextColor;
//    } else {
//        _confirmButton.enabled = NO;
//        _confirmButton.backgroundColor = kDisableColor;
//    }
}

- (IBAction)confirmAction:(UIButton *)sender {
    
    if (self.addressTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入地址", nil)];
        return;
    }else if (self.noteTextField.text.length == 0){
        [MBProgressHUD showError:SSKJLocalized(@"请输入备注", nil)];
        return;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"qiaobao_url"] = _addressTextField.text;
    params[@"notes"] = _noteTextField.text;
    params[@"type"] = _currentType;
    
    
    
    WS(weakSelf);
//    [HttpTool postWithURL:AddTiBiAddressURL params:params success:^(id json) {
//
//      [[ManagerGlobeUntil sharedManager] hideHUDFromeView:weakSelf.view];
//
//        LSLog(@"json : %@",json);
//        if ([json[@"status"] integerValue] == 200) {
//            self.refreshListBlock();
//            [self.navigationController popViewControllerAnimated:YES];
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:weakSelf.view];
//        [MBProgressHUD showError:@"请求超时"];
//    }];
}

- (void)setAddAddressBlock:(AddAddressBlock)addAddressBlock {
    _addAddressBlock = addAddressBlock;
}

- (void)setRefreshListBlock:(RefreshListBlock)refreshListBlock {
    _refreshListBlock = refreshListBlock;
}

#pragma mark - 收起键盘
/**
 点击 return 收起键盘
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}
/**
 点击 空白处 收起键盘
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(void)setCurrentType:(NSString *)currentType{
    _currentType = currentType;
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
