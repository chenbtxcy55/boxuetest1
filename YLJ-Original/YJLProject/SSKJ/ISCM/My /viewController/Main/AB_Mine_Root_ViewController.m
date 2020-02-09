//
//  AB_Mine_Root_ViewController.m
//  SSKJ
//
//  Created by 孙 on 2019/7/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "AB_Mine_Root_ViewController.h"
#import "SKMain_Header_Cell.h"
#import "SKMy_Info_DetailVC.h"
#import "SKAssetManagementVC.h"
#import "BLAddAddressViewController.h"
#import "SKSecurityCenterVC.h"

#import "SKMyAboutVC.h"
#import "UpdateViewViewController.h"
#import "Mine_Spertor_ViewController.h"
#import "AppDelegate.h"

#import "Super_Myaddress_ViewController.h"

#import "Shop_OrderListRoot_VewController.h"

@interface AB_Mine_Root_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * mainTableView;

@end

@implementation AB_Mine_Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mainTableView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     
     [self.navigationController setNavigationBarHidden:YES];
    
    [self requestGetInfo];
    
//    [self requestCheckVersion];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-Height_NavBar) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = WLColor(246, 247, 251, 1);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView registerClass:[SKMain_Header_Cell class] forCellReuseIdentifier:@"SKMain_Header_Cell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _mainTableView;
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 181 + ScaleW(26)+30 + 90*2;

    }
    else
    {
        return 120;
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SKMain_Header_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKMain_Header_Cell" forIndexPath:indexPath];
        WS(weakSelf);
        cell.myBlock = ^(NSInteger index) {
            
            switch (index) {
                case 0:
                {
#pragma mark --个人资料
                    SsLog(@"个人资料");
                    SKMy_Info_DetailVC * myInfoVC =[SKMy_Info_DetailVC new];
                    
                    [self.navigationController pushViewController:myInfoVC animated:YES];
                    
                }
                    break;
                case 1:
                {
#pragma mark --资产管理
                    SsLog(@"资产管理");
                    SKAssetManagementVC * assetManagementVC =[SKAssetManagementVC new];
                    
                    [self.navigationController pushViewController:assetManagementVC animated:YES];

                }
                    break;
                case 2:
                {
#pragma mark --安全中心
                    SsLog(@"安全中心");
                    SKSecurityCenterVC * securityCenterVC = [SKSecurityCenterVC new];

                    [self.navigationController pushViewController:securityCenterVC animated:YES];
                    
//                    [self.navigationController pushViewController:[NSClassFromString(@"SKBillingRecordsVC") new] animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            weakSelf.view.backgroundColor = [UIColor whiteColor];
            SsLog(@"%ld",(long)index);
        };
        
        if ([SSKJ_User_Tool sharedUserTool].userInfoModel.mobile.length>0) {
            cell.phoneLab.text = [SSKJ_User_Tool sharedUserTool].userInfoModel.mobile;

        }
        cell.uidLab.text = [NSString stringWithFormat:@"UID:%@",[[SSKJ_User_Tool sharedUserTool] getAccount]];
        
        if ([SSKJ_User_Tool sharedUserTool].userInfoModel.status.intValue == 3&&
            [SSKJ_User_Tool sharedUserTool].userInfoModel.auth_status.intValue == 3
            )
        {
            cell.stateLab.text =@"已认证";
            
        }
        else
        {
            cell.stateLab.text =@"未认证";
            
            
        }
        [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ProductBaseServer,[SSKJ_User_Tool sharedUserTool].userInfoModel.upic]] placeholderImage:[UIImage imageNamed:@"my_header"]];
       

        return cell;
    } else
    {
        NSArray * titleArr = nil;
        NSArray * imageViewArr = nil;
        
        SEL method = nil;
        
        if (indexPath.section == 1) {
            titleArr = @[@"邀请返佣",@"提币地址"];
            imageViewArr = @[@"my_inviteBack",@"my_tiBiAdress"];
            method = @selector(invateAndAdress:);
        }
        else if (indexPath.section == 2){
            titleArr=@[SSKJLocalized(@"收货地址", nil),SSKJLocalized(@"订单管理", nil)];
            imageViewArr = @[@"mineAdressIcon",@"mineOrderIcon"];
            method = @selector(adressAndOrder:);

        }
        else
        {
            titleArr = @[@"关于我们",@"版本更新"];
            imageViewArr = @[@"my_aboutUs",@"my_versionUpdate"];
            method = @selector(aboutAndUpdate:);

        }
        
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.contentView.backgroundColor =WLColor(246, 247, 251, 1);
            
            UIView *bgView =[self itemViewWithTitleArr:titleArr withImageNameArr:imageViewArr eventSel:method];
            [cell.contentView addSubview:bgView];
            
        }
        
        return cell;
    }
    
    
    return nil;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        UIView * bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth , 80)];
        bgView.layer.cornerRadius = 10;
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = WLColor(246, 247, 251, 1);
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScaleW(15), 20 , ScreenWidth -ScaleW(15)*2, 60);
        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = YES;
        [button setTitleColor:kMainBlueColor forState:UIControlStateNormal];
        [button setTitle:SSKJLocalized(@"退出登录", nil) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(loginOutBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        
        [bgView addSubview:button];
        
        return bgView;
    }
    return [UIView new];
    
}

-(void)loginOutBtnAction:(UIButton *)sender
{
    
    UIAlertController *alertViewControler = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认退出该程序吗" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确认", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
         [SSKJ_User_Tool clearUserInfo];
        [kNotifyCenter postNotificationName:@"loginOffAction" object:nil];
    }];
    
    [alertViewControler addAction:cancelAction];
    [alertViewControler addAction:sureAction];
    [self showDetailViewController:alertViewControler sender:nil];
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        
        return 80;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(UIView *)itemViewWithTitleArr:(NSArray*)titleArr withImageNameArr:(NSArray*)imageArr eventSel:(SEL)methodName
{
    UIView * bgView =[[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(15)*2, 60 *titleArr.count)];
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<titleArr.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 60 *i, bgView.width, 60);
        
        [button addTarget:self action:methodName forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        button.tag = 11112222 +i;
        [bgView addSubview:button];
        
        
        UIImageView * iconImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(15), (button.height-ScaleW(19))/2, ScaleW(19), ScaleW(19))];
        iconImageView.image = [UIImage imageNamed:imageArr[i]];
//        iconImageView.contentMode = 
        [button addSubview:iconImageView];
        UILabel * showTile = [[UILabel alloc]initWithFrame:CGRectMake(iconImageView.right+ScaleW(16), (button.height -20)/2, 100, 20)];
        showTile.textColor = kMainWihteColor;
        showTile.font = [UIFont systemFontOfSize:ScaleW(14)];
        showTile.adjustsFontSizeToFitWidth = YES;
        showTile.textColor =[UIColor blackColor];
        showTile.text = titleArr[i];
        [button addSubview:showTile];
        
        
        UIImageView * arrowImageView =[[UIImageView alloc] initWithFrame:CGRectMake(button.width- ScaleW(15) -ScaleW(8), (button.height-ScaleW(13))/2, ScaleW(8), ScaleW(13))];
        arrowImageView.image =[UIImage imageNamed:@"my_rightArrow"];
        [button addSubview:arrowImageView];
        
        if (i !=titleArr.count-1) {
            UIImageView * lineImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(15), button.height -.5, button.width -ScaleW(15) *2, .5)];
            lineImageView.backgroundColor =kLineGrayColor;
            [button addSubview:lineImageView];
        }
        
        
    }
    return bgView;
    
}
-(void)adressAndOrder:(UIButton*)sender{
    
    if (sender.tag == 11112222) {
#pragma mark --收货地址
    
        Super_Myaddress_ViewController *vc = [[Super_Myaddress_ViewController alloc]init];
        vc.type=1;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
#pragma mark --订单管理
      
        Shop_OrderListRoot_VewController * adressVC =[Shop_OrderListRoot_VewController new];
        
        [self.navigationController pushViewController:adressVC animated:YES];
        
        
    }
}
-(void)invateAndAdress:(UIButton*)sender
{
    if (sender.tag == 11112222) {
#pragma mark --邀请返佣
        SsLog(@"邀请返佣");
        Mine_Spertor_ViewController *vc = [[Mine_Spertor_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
#pragma mark --提币地址
        SsLog(@"提币地址");
        BLAddAddressViewController * adressVC =[BLAddAddressViewController new];
        
        [self.navigationController pushViewController:adressVC animated:YES];
        
        
    }
}
-(void)aboutAndUpdate:(UIButton*)sender
{
    
    if (sender.tag == 11112222) {
#pragma mark --关于我们

        [self requestAboutUs];
        
        SsLog(@"关于我们");
      
    }
    else
    {
#pragma mark --版本更新
        SsLog(@"版本更新");

        [self requestCheckVersion];
        
    }
    
}
#pragma mark -- 关于我们请求
-(void)requestAboutUs
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_about_us_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
            SKMyAboutVC *vc = [[SKMyAboutVC alloc]init];
            vc.addressStr = netWorkModel.data[@"value"];
            
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            
            [self.navigationController presentViewController:vc animated:YES completion:^{
                //
                vc.view.superview.backgroundColor = [UIColor clearColor];
            }];
        }
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
}

#pragma mark -- 获取个人信息
-(void)requestGetInfo
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_get_user_info_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:netWorkModel.data];
//            userModel.account = [[SSKJ_User_Tool sharedUserTool] getAccount];
            [SSKJ_User_Tool sharedUserTool].userInfoModel = userModel;
            
            [weakSelf.mainTableView reloadData];
            
            
        }
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


#pragma mark -- 检查版本更新
-(void)requestCheckVersion
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_check_version_Api RequestType:RequestTypePost Parameters:@{@"version":AppVersion,@"type":@"2"} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (statusCode ==200) {
            if ([netWorkModel.data isEqualToString:@""] || [netWorkModel.data[@"version"] compare:AppVersion] == kCFCompareLessThan) {
                
                SKMyAboutVC *vc = [[SKMyAboutVC alloc]init];
                vc.addressStr = netWorkModel.msg;
                
                vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
                
                [self.navigationController presentViewController:vc animated:YES completion:^{
                    //
                    vc.view.superview.backgroundColor = [UIColor clearColor];
                }];
                
            }else{
               
                UpdateViewViewController *vc = [[UpdateViewViewController alloc]init];
                
                vc.dataDic = responseObject;
                
                vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
                
                [self.navigationController presentViewController:vc animated:YES completion:^{
                    //
                    vc.view.superview.backgroundColor = [UIColor clearColor];
                }];
            }
           
        }
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
