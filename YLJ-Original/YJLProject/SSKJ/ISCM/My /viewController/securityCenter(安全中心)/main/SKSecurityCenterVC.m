//
//  SKSecurityCenterVC.m
//  SSKJ
//
//  Created by 孙 on 2019/7/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKSecurityCenterVC.h"
//身份认证
#import "My_Certificate_ViewController.h"
//设置安全密码
#import "My_SetTPWD_ViewController.h"
//修改密码
#import "My_ChangePWD_ViewController.h"
//商家认证
#import "OTC_BusinessApply_VC.h"
#import "My_BindPhone_ViewController.h"//绑定邮箱
#import "ZSJ_BindPhone_ViewController.h"//绑定邮箱
#import "BLAddAddressViewController.h"//提币地址

@interface SKSecurityCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * mainTableView;


@end

@implementation SKSecurityCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
    
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];

    self.title = SSKJLocalized(@"安全中心", nil);
    
    [self requestGetInfo];
//    [self requestvCancelShop];
    [self.mainTableView reloadData];
    
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth, ScreenHeight-Height_NavBar - ScaleW(5)) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = kNavBGColor;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_mainTableView registerClass:[SKMyCharge_RecordCell class] forCellReuseIdentifier:@"SKMyCharge_RecordCell"];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _mainTableView.scrollEnabled = NO;
    }
    return _mainTableView;
}
#pragma mark -- UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return ScaleW(55);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    for (id view in [cell.contentView subviews])
    {
        
        [view removeFromSuperview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel * label = [UILabel new];
    label.textColor = kMainWihteColor;
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:ScaleW(14)];
    label.textAlignment = NSTextAlignmentLeft;
    label.frame =  CGRectMake(15, 0, 100, ScaleW(55));
    
    [cell.contentView addSubview:label];
    
    UILabel * contentLabel = [UILabel new];
    contentLabel.textColor = kSubTxtColor;
    contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:ScaleW(13)];
    contentLabel.textAlignment = NSTextAlignmentRight;
    contentLabel.frame =  CGRectMake(ScreenWidth-200 - 33-5, 0, 200, ScaleW(55));
    [cell.contentView addSubview:contentLabel];
    
    UIImageView* arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(7)-ScaleW(15), (ScaleW(55)-ScaleW(12))/2, ScaleW(7), ScaleW(12))];
    arrowImageView.image = [UIImage imageNamed:@"my_rightArrow"];
    [cell.contentView addSubview:arrowImageView];
    
    UIImageView* lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, ScaleW(55)-.5, ScreenWidth - 30, .5)];
    lineImageView.backgroundColor = kLineBgColor;
    [cell.contentView addSubview:lineImageView];
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row ==0) {
                label.text = SSKJLocalized(@"钱包地址", nil);
                
            
                
            }
            else
            {
                label.text = SSKJLocalized(@"绑定邮箱", nil);
                
                
                if (![[SSKJ_User_Tool sharedUserTool].userInfoModel.email isEqualToString:@"0"]
                    )
                {
                    contentLabel.text = [self setupTitle:[SSKJ_User_Tool sharedUserTool].userInfoModel.email] ;

                }
                else
                {
                    contentLabel.text =SSKJLocalized(@"未绑定", nil);
                }
            }
        }
            break;
        case 1:
        {
            
            if (indexPath.row ==0) {
                label.text = SSKJLocalized(@"登录密码", nil);

                if (![self judgePayPassword]) {
                    
                    contentLabel.text =SSKJLocalized(@"未设置", nil);
                }
                else
                {
                    contentLabel.text =SSKJLocalized(@"已设置", nil);

                }
                    
               
                
            }
            else
            {
                label.text = SSKJLocalized(@"安全密码", nil);
                
                if (![self judgePayPassword]) {
                    contentLabel.text =SSKJLocalized(@"未设置", nil);

                }
                else
                {
                    contentLabel.text =SSKJLocalized(@"已设置", nil);
                    
                }
                
                
            }
            
            
        }
            break;
            
        default:
            break;
    }
    
    cell.contentView.backgroundColor = kNavBGColor;
    
    
    return cell;
    
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [UIView new];
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 1) {
//        return 10;
//    }
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row ==0) {
#pragma mark ---钱包地址
              
                BLAddAddressViewController * certificate_ViewController =[BLAddAddressViewController new];
                
                [self.navigationController pushViewController:certificate_ViewController animated:YES];
                
            }
            else
            {
                
#pragma mark --- 绑定邮箱

                if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.email isEqualToString:@"0"]||[SSKJ_User_Tool sharedUserTool].userInfoModel.email.length==0) {
                    ZSJ_BindPhone_ViewController *VC = [[ZSJ_BindPhone_ViewController alloc] init];
                    [self.navigationController pushViewController:VC animated:YES];
                }
                else
                {
                    
                    [MBProgressHUD showError:SSKJLocalized(@"邮箱已绑定", nil)];
                }
               
                
            }
            
        }
            break;
        case 1:
        {
            
            if (indexPath.row ==0) {
                
#pragma mark ---登录密码

                
                if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.email isEqualToString:@"0"]||[SSKJ_User_Tool sharedUserTool].userInfoModel.email.length==0) {
                    [MBProgressHUD showError:SSKJLocalized(@"请先绑定邮箱", nil)];
                    
                }
                else
                {
                    My_ChangePWD_ViewController *resetPwdVC = [[My_ChangePWD_ViewController alloc] init];
                    [self.navigationController pushViewController:resetPwdVC animated:YES];
                }
                
             
                
            }
            else
            {
                
#pragma mark ---安全密码
          
                if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.email isEqualToString:@"0"]||[SSKJ_User_Tool sharedUserTool].userInfoModel.email.length==0) {
                    [MBProgressHUD showError:SSKJLocalized(@"请先绑定邮箱", nil)];

                }
                else
                {
                    My_SetTPWD_ViewController *  vc  = [My_SetTPWD_ViewController new];
                    
                    vc.statusBlock = ^{
                        
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
              
//
                
            }
            
            
        }
            break;
        default:
            break;
    }
    
    
    
    
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
            
            
            [self.mainTableView reloadData];
        }
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


#pragma mark -- 取消商家
-(void)requestvCancelShop
{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];

    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_cancel_shop_Api RequestType:RequestTypePost Parameters:@{
                                                                                                                        @"account":Account
                                                                                                                        } Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
          
            [SSKJ_User_Tool sharedUserTool].userInfoModel.is_shop = @"0";
            

            [self.mainTableView reloadData];
            [MBProgressHUD showError:netWorkModel.msg];

        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];

        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (NSString *)setupTitle:(NSString *)title {
    NSMutableString* str1 = [[NSMutableString alloc]initWithString:title];
    NSString *mobileStr;
    if ([RegularExpression validateMobile:title] ) {
        mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        NSRange range = [title rangeOfString:@"@"];
        
        if (range.location == 0) {
            [str1 insertString:@"*" atIndex:1];
            mobileStr = [NSString stringWithFormat:@"%@",str1];
        }else if (range.location == 1){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
        }else if (range.location == 2){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"****"];
        }else if (range.location == 3){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"****"];
        }else if (range.location == 4){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:@"****"];
        }else if (range.location == 5){
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"****"];
        }else{
            mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(2, 4) withString:@"****"];
        }
    }
    return mobileStr;
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
