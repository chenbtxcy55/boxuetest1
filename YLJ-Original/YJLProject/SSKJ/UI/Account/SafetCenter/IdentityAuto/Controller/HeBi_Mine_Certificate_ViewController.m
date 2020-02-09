//
//  HeBi_Mine_Certificate_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Mine_Certificate_ViewController.h"
// view
#import "HeBi_Mine_Certificate_Cell.h"

// controller
#import "HeBi_FirstCertificate_ViewController.h"
#import "HeBi_SecondCertificate_ViewController.h"
#import "HeBi_CertificateSuccessed_ViewController.h"
#import "HeBi_CertificateFail_ViewController.h"


static NSString *cellid = @"HeBi_Mine_Certificate_Cell";


@interface HeBi_Mine_Certificate_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HeBi_Mine_Certificate_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"身份认证", nil);
    [self setUI];
    
    self.dataSource = [NSMutableArray arrayWithCapacity:10];
    
    NSArray *array = @[SSKJLocalized(@"初级认证", nil),
                       SSKJLocalized(@"高级认证",nil)];
    [self.dataSource addObjectsFromArray:array];
    [self.tableView reloadData];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.tableView reloadData];
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}


#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.tableView];
}

-(UIView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(302))];
        _headerView.backgroundColor = kSubBackgroundColor;
        UIImage *image = [UIImage imageNamed:@"img_cercificate"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(image.size.width), ScaleW(image.size.height))];
        imageView.image = image;
        imageView.center = CGPointMake(_headerView.width / 2, _headerView.height / 2);
        
        [_headerView addSubview:imageView];
    }
    return _headerView;
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _tableView.separatorColor = UIColorFromRGB(0x555555);
        
        _tableView.backgroundColor = [UIColor clearColor];
        
        [_tableView registerClass:[HeBi_Mine_Certificate_Cell class] forCellReuseIdentifier:cellid];
        
        _tableView.tableHeaderView = self.headerView;
        
    }
    return _tableView;
}




#pragma mark - UITableViewDelegate UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(10);
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
    HeBi_Mine_Certificate_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    NSString *title = self.dataSource[indexPath.row];
    NSString *statusString;
    if (indexPath.row == 0) {
        NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.status.integerValue;
        if (status == 1) {
            statusString = SSKJLocalized(@"未认证", nil);
        }else if(status == 2){
            statusString = SSKJLocalized(@"审核中", nil);
        }else if(status == 3){
            statusString = SSKJLocalized(@"已认证", nil);
        }else if(status == 4){
            statusString = SSKJLocalized(@"已拒绝", nil);
        }
    }else{
        NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.auth_status.integerValue;
        if (status == 1) {
            statusString = SSKJLocalized(@"未认证", nil);
        }else if(status == 2){
            statusString = SSKJLocalized(@"审核中", nil);
        }else if(status == 3){
            statusString = SSKJLocalized(@"已认证", nil);
        }else if(status == 4){
            statusString = SSKJLocalized(@"已拒绝", nil);
        }
    }
    
    [cell setTitle:title status:statusString];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:                     // 一级认证
            {
                NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.status.integerValue;
                
                if (status == 3) {
                    HeBi_CertificateSuccessed_ViewController *vc = [[HeBi_CertificateSuccessed_ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [self firstCertificateEvent];
                }
            }
                break;
            case 1:                     // 二级认证
            {
                NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.auth_status.integerValue;
                if (status == 1) {
                    [self secondCertificateEvent];
                }else if (status == 3){
                    HeBi_CertificateSuccessed_ViewController *vc = [[HeBi_CertificateSuccessed_ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (status == 4){
                    HeBi_CertificateFail_ViewController *vc = [[HeBi_CertificateFail_ViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (status == 2){
                    [MBProgressHUD showError:SSKJLocalized(@"二级认证审核中，请耐心等待", nil)];
                }
            }
                break;
                
            default:
                break;
        }
    }
}


-(void)firstCertificateEvent
{
    NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.status.integerValue;
    status = 1;
    if (status == 1) {
        HeBi_FirstCertificate_ViewController *vc = [[HeBi_FirstCertificate_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (status == 2){
        [MBProgressHUD showError:SSKJLocalized(@"初级认证审核中，请耐心等待", nil)];
        return;
    }else if (status == 3){
        HeBi_CertificateSuccessed_ViewController *vc = [[HeBi_CertificateSuccessed_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
//        [MBProgressHUD showError:SSKJLocalized(@"一级认证已通过", nil)];
//        return;
    }else if (status == 4){
        HeBi_CertificateFail_ViewController *vc = [[HeBi_CertificateFail_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        //        [MBProgressHUD showError:SSKJLocalized(@"二级认证已通过", nil)];
        //        return;
    }
}

-(void)secondCertificateEvent
{

    if ([SSKJ_User_Tool sharedUserTool].userInfoModel.status.integerValue != 3) {
//        [self judgeFristCertificate];
        [MBProgressHUD showError:SSKJLocalized(@"请先完成初级认证", nil)];
        return;
    }
    
    NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.auth_status.integerValue;
    if (status == 1) {
        HeBi_SecondCertificate_ViewController *vc = [[HeBi_SecondCertificate_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (status == 2){
        [MBProgressHUD showError:SSKJLocalized(@"高级认证审核中，请耐心等待", nil)];
        return;
    }else if (status == 3){
        HeBi_CertificateSuccessed_ViewController *vc = [[HeBi_CertificateSuccessed_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
//        [MBProgressHUD showError:SSKJLocalized(@"二级认证已通过", nil)];
//        return;
    }else if (status == 4){
        HeBi_CertificateFail_ViewController *vc = [[HeBi_CertificateFail_ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        //        [MBProgressHUD showError:SSKJLocalized(@"二级认证已通过", nil)];
        //        return;
    }
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
