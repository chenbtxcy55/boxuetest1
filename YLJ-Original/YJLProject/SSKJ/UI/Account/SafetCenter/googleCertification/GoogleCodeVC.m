//
//  GoogleCodeVC.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2018/8/30.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "GoogleCodeVC.h"
#import "MQVerCodeInputView.h"
#import "BLPopVerView.h"
#import "BLSafeCenterViewController.h"
//#import "BLAcountGetMoneyViewController.h"
@interface GoogleCodeVC ()
@property (weak, nonatomic) IBOutlet MQVerCodeInputView *codeInputView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic, strong) BLPopVerView *popView;
@property (nonatomic,strong) NSString * googleCodeStr;
@end

@implementation GoogleCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _codeInputView.maxLenght = 6;//最大长度
    _codeInputView.keyBoardType = UIKeyboardTypeNumberPad;
    [_codeInputView mq_verCodeViewWithMaxLenght];
    _codeInputView.block = ^(NSString *text){
        NSLog(@"text = %@",text);
        self.googleCodeStr = text;
    };
    self.titlelabel.text = SSKJLocalized(@"谷歌验证码", nil);
    [self.nextBtn setTitle:SSKJLocalized(@"下一步", nil) forState:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_popView removeFromSuperview];
}

- (IBAction)nestBtnClick:(id)sender {
    if (self.googleCodeStr.length == 0 || self.googleCodeStr.length < 6) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
    }else{
        if ([self.fromVC isEqualToString:@"登录"]) {
            [self httpCheck_google_code];
        }else{
            [self popVerCodeView];
        }
        
    }
}

- (void)popVerCodeView {
    self.popView = [[BLPopVerView alloc] init];
    _popView.parentVC = self;
    _popView.fromVC = @"google";
//    _popView.phoneNumber = kPhoneNumber;
    _popView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:_popView];
    [UIView animateWithDuration:0.3 animations:^{
        _popView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }];
    __weak typeof(self) weakSelf = self;
    _popView.presentBlock = ^(NSString *code) {
        [weakSelf checkGoogleCommand:code withGoogleCode:weakSelf.googleCodeStr];
    };
}


/**
 谷歌密保验证

 @param code 短信验证码
 @param googleCode 谷歌验证码
 */
- (void)checkGoogleCommand:(NSString *)code withGoogleCode:(NSString *)googleCode{
    if (code.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
    }else if (googleCode.length == 0){
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
    }
    
//    NSDictionary *params = @{@"dyGoodleCommand":@(googleCode.intValue),
//                             @"code":@(code.intValue),
//                             @"account":kPhoneNumber
//                             };
//    __weak typeof(self) weakSelf = self;
//    [[ManagerGlobeUntil sharedManager] showHUDWithMsg:ZBLocalized(@"加载中", nil) inView:self.view];
//    [HttpTool postWithURL:CheckGoogleCommand params:params success:^(id json) {
//        NSLog(@"%@",json);
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:weakSelf.view];
//        if ([json[@"status"] integerValue] == 200) {
//            for (UIViewController *controller in self.navigationController.viewControllers) {
//                if ([controller isKindOfClass:[BLSafeCenterViewController class]]) {
//                    [self.navigationController popToViewController:controller animated:YES];
//                }
//            }
//        }else{
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//
//    } failure:^(NSError *error) {
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:weakSelf.view];
//        [MBProgressHUD showError:ZBLocalized(@"服务器请求异常", nil)];
//    }];
}

//登录或者提现验证谷歌验证码
- (void)httpCheck_google_code{
//    NSDictionary *params = @{
//                             @"dyGoodleCommand":self.googleCodeStr
//                             };
//    __weak typeof(self) weakSelf = self;
//    [[ManagerGlobeUntil sharedManager] showHUDWithMsg:ZBLocalized(@"加载中", nil) inView:self.view];
//    [HttpTool postWithURL:Check_google_code params:params success:^(id json) {
//        NSLog(@"%@",json);
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:weakSelf.view];
//        if ([json[@"status"] integerValue] == 200) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (self.model == nil) {
//                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//                }else{
////                    BLAcountGetMoneyViewController *getMoney = [[BLAcountGetMoneyViewController alloc]init];
////                    getMoney.model = self.model;
////                    [weakSelf.navigationController pushViewController:getMoney animated:YES];
//                }
//                [kUserDefaults setObject:@"1" forKey:@"logined"];
//                
//            });
//        }else{
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//        
//    } failure:^(NSError *error) {
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:weakSelf.view];
//        [MBProgressHUD showError:ZBLocalized(@"服务器请求异常", nil)];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
