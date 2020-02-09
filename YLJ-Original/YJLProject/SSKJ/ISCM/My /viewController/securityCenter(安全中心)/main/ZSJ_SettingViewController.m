//
//  ZSJ_SettingViewController.m
//  SSKJ
//
//  Created by zhao on 2019/10/7.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "ZSJ_SettingViewController.h"
#import "ZSJ_SettingTableViewCell.h"
#import "CILanguageSelectViewController.h"
#import "My_FeedBack_ViewController.h"
#import "AppDelegate.h"
#import "HeBi_Default_AlertView.h"
#import "SSKJ_Version_Model.h"
#import "SSKJ_Version_AlertView.h"

@interface ZSJ_SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) UIButton* loginButton;
@property (nonatomic, strong) SSKJ_Version_Model * versionModel;

@end

@implementation ZSJ_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"设置", nil);

    _arr = @[SSKJLocalized(@"语言切换", nil),SSKJLocalized(@"意见反馈", nil),SSKJLocalized(@"当前版本", nil)];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.loginButton];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
}
-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth,ScreenHeight- Height_TabBar -ScaleW(5)) style:UITableViewStyleGrouped];
        [_tableView registerClass:[ZSJ_SettingTableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 10;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.backgroundColor = kNavBGColor;
        
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(0.001);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ZSJ_SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = _arr[indexPath.row];
    if (indexPath.row == 0) {
        NSString *language;
        
        if ([[[SSKJLocalized sharedInstance]currentLanguage] containsString:@"en"]) {
            language = @"English";
        }else{
            language = @"中文";
        }
        cell.valueLabel.text = language;
    }else if (indexPath.row == 1){
        cell.valueLabel.text = @"";
    }else{
        cell.valueLabel.text = [NSString stringWithFormat:@"V%@",AppVersion];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    switch (indexPath.row)
    {
#pragma mark case 版本更新
        case 2:
        {
            self.versionModel = nil;
            [self checkVersion];
            
        }
            break;
#pragma mark case 意见反馈
        case 1:
        {
            
            My_FeedBack_ViewController *controller = [[My_FeedBack_ViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
#pragma mark case 1 语言
        case 0:
        {
            CILanguageSelectViewController *controller = [[CILanguageSelectViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
    }
}



-(UIButton *)loginButton
{
    if (nil == _loginButton) {
        _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), ScreenHeight - ScaleW(45) - ScaleW(24)-Height_NavBar, ScreenWidth - ScaleW(30), ScaleW(45))];
        [_loginButton setTitle:SSKJLocalized(@"退出登录", nil) forState:UIControlStateNormal];
        [_loginButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        //        _loginButton.layer.masksToBounds = YES;
        //        _loginButton.layer.cornerRadius = ScaleW(10.f);
        //        _loginButton.backgroundColor = kMainBlueColor;
        _loginButton.titleLabel.font = systemBoldFont(ScaleW(16));
//        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _loginButton.backgroundColor = kTheMeColor;
        [_loginButton addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginButton;
}
-(void)loginEvent
{
    
    
    NSString *title1 = SSKJLocalized(@"退出登录", nil);
    
    [HeBi_Default_AlertView showWithTitle:SSKJLocalized(@"", nil) message:title1 cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确认", nil) confirmBlock:^{

        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate gotoMain];
        
        [SSKJ_User_Tool clearUserInfo];
    }];
    
  
    
}

#pragma mark - 检测版本更新
-(void)checkVersion
{
    NSDictionary *dict=@{@"version":AppVersion,
                         @"type":@"2"
                         };
    
    SsLog(@"\r版本->请求参数：%@",dict);
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_CheckVersion_URL RequestType:RequestTypePost Parameters:dict Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            
            if (self.versionModel==nil) {
                SSKJ_Version_Model * model = [SSKJ_Version_Model mj_objectWithKeyValues:network_Model.data];
                weakSelf.versionModel = model;
                
                [SSKJ_Version_AlertView showWithModel:model confirmBlock:^{
                    
                    
                    [weakSelf upgrade_Button_Event];
                    
                    
                } cancleBlock:^{
                    
                }];
            }
            
            
            
            
            
            
        }else{
            
            [MBProgressHUD showError:SSKJLocalized(@"已是最新版本", nil)];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
}
#pragma mark - 版本更新控制 立即更新 事件
-(void)upgrade_Button_Event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionModel.addr]];
}
@end
