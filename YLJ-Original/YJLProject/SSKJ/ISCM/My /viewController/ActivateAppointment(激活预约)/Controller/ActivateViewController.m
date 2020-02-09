//
//  ActivateViewController.m
//  SSKJ
//
//  Created by zhao on 2019/10/9.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 激活预约
 */
#import "ActivateViewController.h"
#import "ActivateTableViewCell.h"
#import "ActivateWarmAlertView.h"
#import "ActivateDetailViewController.h"

#import "ActivateViewModel.h"


@interface ActivateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MBProgressHUD *hudView;

@property (nonatomic,strong)UIView *heardView;
@property (nonatomic,strong)UIView *footView;
@property (nonatomic,strong)UIButton *submitButton;
@property (nonatomic,strong)ActivateWarmAlertView *applyAlertView;//弹框

@property (nonatomic,strong)ActivateViewModel *clickModel;
@end

@implementation ActivateViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"激活预约", nil);
    [self tableView];
    [self.view addSubview:self.heardView];
    self.tableView.tableFooterView = self.footView;
    [self requstListrequset];
}
-(ActivateWarmAlertView *)applyAlertView
{
    if (nil == _applyAlertView) {
        _applyAlertView = [[ActivateWarmAlertView alloc]init];
        WS(weakSelf);
        _applyAlertView.confirmBlock = ^{
            [weakSelf surePayClick];
        };
        _applyAlertView.cancelClickBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:true];
        };
    }
    return _applyAlertView;
}
#pragma mark - 去付款
- (void)surePayClick{
    ActivateDetailViewController *vc = [[ActivateDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}
-(MBProgressHUD *)hudView{
    if (!_hudView) {
        _hudView = [[MBProgressHUD alloc] initWithView:self.view];
    }
    return _hudView;
}
- (UIView *)heardView{
    if (!_heardView) {
        _heardView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth, ScaleW(40))];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(0), ScreenWidth, ScaleW(40))];
        lab.textColor = kMainWihteColor;
        lab.font = systemFont(ScaleW(15));
        lab.text = SSKJLocalized(@"请选择激活套餐", nil);
        [_heardView addSubview:lab];
        _heardView.backgroundColor = kNavBGColor;
    }
    return _heardView;
}
- (UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleW(0), ScreenWidth, ScaleW(220))];
        _footView.backgroundColor = kNavBGColor;
        [_footView addSubview:self.submitButton];
    }
    return _footView;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), ScaleW(149), ScreenWidth - ScaleW(50), ScaleW(45))];
        _submitButton.layer.cornerRadius = _submitButton.height / 2;
        [_submitButton setTitle:SSKJLocalized(@"预约", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
        //        [_submitButton addGradientColor];
        _submitButton.backgroundColor = kMainBlueColor;
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateNormal];
//        [_submitButton setBackgroundImage:[UIImage imageNamed:@"login_Btn_bg"] forState:UIControlStateHighlighted];
        _submitButton.backgroundColor = kTheMeColor;
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = ScaleW(5);
    }
    return _submitButton;
}

#pragma mark - 预约
- (void)submitEvent{
    
    if (self.clickModel.ID.length < 1) {
        [MBProgressHUD showError:SSKJLocalized(@"请选择激活套餐", nil)];

        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:Yuyue_lockURL RequestType:RequestTypePost Parameters:@{@"id":_clickModel.ID} Success:^(NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (network_Model.status.integerValue == SUCCESSED)
         {
             [weakSelf.applyAlertView show];
         }else{
             [MBProgressHUD showError:network_Model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
    
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(50), ScreenWidth,ScreenHeight - Height_NavBar - ScaleW(50)) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.backgroundColor = kNavBGColor;
  
        [self.view addSubview:_tableView];
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
     
       
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ActivateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivateTableViewCell"];
    if (!cell)
    {
        cell = [[ActivateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivateTableViewCell"];
    }
    ActivateViewModel *model = self.dataArray[indexPath.row];
    cell.detailLab.text = [NSString stringWithFormat:@"%@：%@",model.title,[WLTools noroundingStringWith:model.num.doubleValue afterPointNumber:4]];
    if (self.clickModel.ID == model.ID) {
        cell.clickImage.image = [UIImage imageNamed:@"clickY"];
    }else{
        cell.clickImage.image = [UIImage imageNamed:@"clickN"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _clickModel = _dataArray[indexPath.row];
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(46);
}

-(void)requstListrequset
{
    
   
    WS(weakSelf);
    [self.hudView showAnimated:YES];
    
    [self.tableView reloadData];
    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:ActivateListURL RequestType:RequestTypeGet Parameters:pamas Success:^(NSInteger statusCode, id responseObject) {
        [weakSelf.tableView.mj_header endRefreshing];
        [self.hudView hideAnimated:YES];
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
    
        if (net_model.status.integerValue == 200) {
            if ([net_model.data[@"list"] isKindOfClass:NSArray.class]) {
                self.dataArray = [ActivateViewModel mj_objectArrayWithKeyValuesArray:net_model.data[@"list"]];
            }
          
            
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [self.hudView hideAnimated:YES];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

@end
