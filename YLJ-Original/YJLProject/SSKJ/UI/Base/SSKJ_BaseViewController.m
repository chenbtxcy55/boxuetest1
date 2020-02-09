//
//  SSKJ_BaseViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "SSKJ_TitleView.h"
#import "UIImage+RoundedRectImage.h"
#import "JB_Login_ViewController.h"
#import "SSKJ_BaseNavigationController.h"
#import "HeBi_Default_AlertView.h"
#import "My_SetTPWD_ViewController.h"
#import "BLSafeCenterViewController.h"
#import "HeBi_Mine_Certificate_ViewController.h"
#import "HeBi_ApplyShop_AlertView.h"
#import "My_Certificate_ViewController.h"
/*#import "AB_IDDefine_ViewController.h"*/
@interface SSKJ_BaseViewController ()
@property (nonatomic, strong) SSKJ_TitleView *titleView;
@property (nonatomic, strong) HeBi_ApplyShop_AlertView *applyAlertView;
@end

@implementation SSKJ_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = self.titleView;
    
    self.view.backgroundColor = kMainColor;
    
    [self.titleView setTintColor:kNavBGColor];
    
    [self setTitleFont:[UIFont systemFontOfSize:ScaleW(18)]];
    
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"commentWhite"]style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
        item.tintColor = kMainWihteColor;
        self.navigationItem.leftBarButtonItem = item;
        
    }
    
    
    
    
    //    else if(self.isPush == YES){
    //        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction:)];
    //
    //        self.navigationItem.leftBarButtonItem = item;
    //    }
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 去除navigationbar下面的线
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    SsLog(@"当前VC=========%@",NSStringFromClass([self class]));
    self.navigationController.navigationBar.translucent = NO;

}


-(SSKJ_TitleView *)titleView
{
    if (nil == _titleView) {
        
        _titleView = [[SSKJ_TitleView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - ScaleW(250), 40)];
        
    }
    return _titleView;
}

#pragma mark - 基本功能
/*
 * 修改导航栏字体颜色
 */
-(void)setTitleColor:(UIColor *)titleColor
{
    [self.titleView changeTitleColor:titleColor];
}

/*
 * 修改导航栏字体
 */
-(void)setTitleFont:(UIFont *)font
{
    [self.titleView changeTitleFont:font];
}

/*
 * 修改导航栏背景色
 */
-(void)setNavgationBackgroundColor:(UIColor *)navigationBackgroundColor alpha:(CGFloat)alpha
{
    self.navigationController.navigationBar.translucent = YES;
    UIImageView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = alpha;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navigationBackgroundColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init] ];
    
    self.navigationController.navigationBar.barTintColor = navigationBackgroundColor;
}



/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithImage:(UIImage*)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
    self.navigationItem.leftBarButtonItem = item;
}
/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithTitle:(NSString*)title color:(UIColor *)color
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
    item.tintColor = color;
    self.navigationItem.leftBarButtonItem = item;
    
}
/*
 * 返回按钮点击事件
 */
- (void)leftBtnAction:(id)sender
{

    
  
     [self.navigationController popViewControllerAnimated:YES];
}

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavItemWithTitle:(NSString*)title color:(UIColor *)color font:(UIFont *)font
{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rigthBtnAction:)];
    //    item.tintColor = color;
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,
                                  color, NSForegroundColorAttributeName,
                                  nil]
                        forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
    
}

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavgationItemWithImage:(UIImage*)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rigthBtnAction:)];
    self.navigationItem.rightBarButtonItem = item;
}

/*
 * 导航栏右侧按钮点击事件
 */
- (void)rigthBtnAction:(id)sender
{
    
}

//-(void)changeTitle:(NSString *)title
//{
//
//    self.title = title;
//    [self.titleView changeTitle:title];
//
//
//}



-(void)setTitle:(NSString *)title
{
    CGSize sizeToFit = [title sizeWithFont:[UIFont systemFontOfSize:ScaleW(18)] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 40) lineBreakMode:NSLineBreakByWordWrapping];
    self.titleView.frame=CGRectMake(0, 0, sizeToFit.width+40, 40);
    [self.titleView changeTitle:title];
    
}

-(void)setNavigationBarHidden:(BOOL)isHidden
{
    [self.navigationController setNavigationBarHidden:isHidden];
}



// 弹出登录页面
-(void)presentLoginController
{
    JB_Login_ViewController *loginVc = [[JB_Login_ViewController alloc]init];
    SSKJ_BaseNavigationController *navc = [[SSKJ_BaseNavigationController alloc]initWithRootViewController:loginVc];
    
    if (self.navigationController) {
        loginVc.isPush = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
    }else
    {
        navc.modalPresentationStyle = UIModalPresentationFullScreen;

        [self presentViewController:navc animated:YES completion:nil];
    }
}

-(BOOL)judgePayPassword
{
    NSString *tpwd = [SSKJ_User_Tool sharedUserTool].userInfoModel.tpwd;
    
    WS(weakSelf);
    if (tpwd.length > 0 && ![tpwd isEqualToString:@"0"]) {
        return YES;
    }else{
//        if (self.isShowPop) {
//            [MBProgressHUD showError:SSKJLocalized(@"请先设置安全密码", nil) toView:self.view];
//            return NO;
//        }
//        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"安全密码", nil) message:SSKJLocalized(@"请先设置安全密码", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"前往", nil) confirmBlock:^{
//            My_SetTPWD_ViewController *vc = [[My_SetTPWD_ViewController alloc]init];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }];
        return NO;
    }
}

-(BOOL)judgeBindEmail
{
    NSString *email = [SSKJ_User_Tool sharedUserTool].userInfoModel.email;
    
    WS(weakSelf);
    if (email.length > 0 && ![email isEqualToString:@"0"]) {
        return YES;
    }else{
        //        if (self.isShowPop) {
        //            [MBProgressHUD showError:SSKJLocalized(@"请先设置安全密码", nil) toView:self.view];
        //            return NO;
        //        }
        //        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"安全密码", nil) message:SSKJLocalized(@"请先设置安全密码", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"前往", nil) confirmBlock:^{
        //            My_SetTPWD_ViewController *vc = [[My_SetTPWD_ViewController alloc]init];
        //            [weakSelf.navigationController pushViewController:vc animated:YES];
        //        }];
        return NO;
    }
}


-(BOOL)judgePayList
{
    NSString *pay_list = [SSKJ_User_Tool sharedUserTool].userInfoModel.pay_list;
    
    WS(weakSelf);
    if (pay_list.length > 0 && ![pay_list isEqualToString:@"0"]) {
        return YES;
    }else{
        if (self.isShowPop) {
            [MBProgressHUD showError:SSKJLocalized(@"请先添加支付方式", nil) toView:self.view];
            return NO;
        }
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"支付方式", nil) message:SSKJLocalized(@"请先添加支付方式", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"前往", nil) confirmBlock:^{
            BLSafeCenterViewController *vc = [[BLSafeCenterViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        return NO;
    }
}


-(void)showLoginAlert
{
    WS(weakSelf);
    [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"您当前还未登录，请先登录或注册", nil) message:@"" cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"登录/注册", nil) confirmBlock:^{
        [weakSelf presentLoginController];
    }];
    
}


// 判断一级认证
-(BOOL)judgeFristCertificate
{
    NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.status.integerValue;
    WS(weakSelf);
    if (status == 1) {                  // 未认证
        if (self.isShowPop) {
            [MBProgressHUD showError:SSKJLocalized(@"请先完成初级认证，前往设置", nil) toView:self.view];
            return NO;
        }
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"请先完成初级认证，前往设置", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"前往", nil) confirmBlock:^{
           /* AB_IDDefine_ViewController *vc = [[AB_IDDefine_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];*/
            
            My_Certificate_ViewController *vc = [[My_Certificate_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
    }else if (status == 2){         // 审核中
        [MBProgressHUD showError:SSKJLocalized(@"您的认证正在审核中，请耐心等待", nil)];
    }else if (status == 3){         // 已认证
        return YES;
    }else if (status == 4){         // 已拒绝
        if (self.isShowPop) {
            [MBProgressHUD showError:SSKJLocalized(@"您的认证被拒绝，请重新认证", nil) toView:self.view];
            return NO;
        }
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"您的初级认证被拒绝，请重新认证", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"前往", nil) confirmBlock:^{
            My_Certificate_ViewController *vc = [[My_Certificate_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];

    }
    return NO;
}

// 判断二级认证
-(BOOL)judgeSecondCertificate
{
    if ([SSKJ_User_Tool sharedUserTool].userInfoModel.status.integerValue != 3) {
        [self judgeFristCertificate];
        return NO;
    }
    WS(weakSelf);
    NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.auth_status.integerValue;
    
    if (status == 1) {                  // 未认证
        if (self.isShowPop) {
            [MBProgressHUD showError:SSKJLocalized(@"您还未完成高级认证，前往设置", nil) toView:self.view];
            return NO;
        }
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"您还未完成高级认证，前往设置", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"前往", nil) confirmBlock:^{
            My_Certificate_ViewController *vc = [[My_Certificate_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];

    }else if (status == 2){         // 审核中
        [MBProgressHUD showError:SSKJLocalized(@"您的高级认证正在审核中，请耐心等待", nil)];
    }else if (status == 3){         // 已认证
        return YES;
    }else if (status == 4){         // 已拒绝
        if (self.isShowPop) {
            [MBProgressHUD showError:SSKJLocalized(@"您的高级认证被拒绝，请重新认证", nil) toView:self.view];
            return NO;
        }
        [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"您的高级认证被拒绝，请重新认证", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"前往", nil) confirmBlock:^{
            My_Certificate_ViewController *vc = [[My_Certificate_ViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];

    }
    
    return NO;
}

// 判断商家认证
-(BOOL)judgeBusinessCertificate
{
    
    NSInteger is_shop = [SSKJ_User_Tool sharedUserTool].userInfoModel.is_shop.integerValue;
    if (is_shop == 1) {         // 已认证
        return YES;
    }else if (is_shop == 2){            // 审核中
        [MBProgressHUD showSuccess:SSKJLocalized(@"您的商家认证正在审核中，请耐心等待！", nil)];
        return NO;
    }else if(is_shop == 0){            // 未认证
        [self.applyAlertView show];
        return NO;
    }else if(is_shop == 3){            // 拒绝
        [self.applyAlertView show];
        return NO;
    }
    return YES;
}

-(HeBi_ApplyShop_AlertView *)applyAlertView
{
    if (nil == _applyAlertView) {
        _applyAlertView = [[HeBi_ApplyShop_AlertView alloc]init];
        WS(weakSelf);
        _applyAlertView.confirmBlock = ^{
            [weakSelf requestApplyShop];
        };
       
    }
    return _applyAlertView;
}


#pragma mark - 申请商家认证

-(void)requestApplyShop
{
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];
    
    NSDictionary *params = @{
                             @"account":Account
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_ApplyShop_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [MBProgressHUD showSuccess:SSKJLocalized(@"提交成功", nil)];
            [weakSelf.applyAlertView hide];
            [SSKJ_User_Tool sharedUserTool].userInfoModel.is_shop = @"2";
            [weakSelf.applyAlertView hide];
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
