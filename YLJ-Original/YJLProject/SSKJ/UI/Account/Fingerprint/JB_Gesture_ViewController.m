//
//  JB_Gesture_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/27.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_Gesture_ViewController.h"
#import "JB_GesturePWD_ViewController.h"

@interface JB_Gesture_ViewController ()
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *zhiwenButton;
@property (nonatomic, strong) UILabel *buttonTitleLabel;
@property (nonatomic, strong) UIButton *pwdButton;
@end

@implementation JB_Gesture_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self requestUserInfo];

}

-(void)setUI
{
    [self.view addSubview:self.headerImageView];
    [self.view addSubview:self.label];
    [self.view addSubview:self.zhiwenButton];
    [self.view addSubview:self.buttonTitleLabel];
    [self.view addSubview:self.pwdButton];
}

-(UIImageView *)headerImageView
{
    if (nil == _headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(82), ScaleW(70), ScaleW(97))];
        _headerImageView.centerX = ScreenWidth / 2;
        _headerImageView.image = [UIImage imageNamed:@"gesture_logo"];
    }
    return _headerImageView;
}

-(UIButton *)zhiwenButton
{
    if (nil == _zhiwenButton) {
        _zhiwenButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.headerImageView.bottom + ScaleW(88), ScaleW(72), ScaleW(72))];
        _zhiwenButton.centerX = self.headerImageView.centerX;
        [_zhiwenButton setImage:[UIImage imageNamed:@"zhiwen"] forState:UIControlStateNormal];
        [_zhiwenButton addTarget:self action:@selector(zhiwenEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zhiwenButton;
}

-(UILabel *)buttonTitleLabel
{
    if (nil == _buttonTitleLabel) {
        _buttonTitleLabel = [WLTools allocLabel:SSKJLocalized(@"请使用指纹验证", nil) font:systemFont(ScaleW(13.5)) textColor:kTextLightBlueColor frame:CGRectMake(0, self.zhiwenButton.bottom + ScaleW(21), ScreenWidth, ScaleW(14)) textAlignment:NSTextAlignmentCenter];
    }
    return _buttonTitleLabel;
}

-(UIButton *)pwdButton
{
    if (nil == _pwdButton) {
        _pwdButton = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight - Height_TabBar - ScaleW(30) - Height_NavBar, ScreenWidth, ScaleW(40))];
        [_pwdButton setTitle:SSKJLocalized(@"使用密码登录", nil) forState:UIControlStateNormal];
        [_pwdButton setTitleColor:kTextBlueColor forState:UIControlStateNormal];
        _pwdButton.titleLabel.font = systemFont(ScaleW(13));
        [_pwdButton addTarget:self action:@selector(pwdEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pwdButton;
}

-(void)zhiwenEvent
{
    if (self.gestureBlock) {
        self.gestureBlock();
    }
}

-(void)pwdEvent
{
    JB_GesturePWD_ViewController *vc = [[JB_GesturePWD_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)requestUserInfo
{
    NSDictionary *params = @{
                             
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_Account_UserInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            if (weakSelf.gestureBlock) {
                weakSelf.gestureBlock();
            }
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
