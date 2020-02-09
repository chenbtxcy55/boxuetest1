//
//  Mine_Spertor_List_ViewController.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_Spertor_List_ViewController.h"
#import "Mine_Spertor_ViewController.h"//推广f返佣
#import "ZSJ_SettingTableViewCell.h"
#import "MyTeamViewController.h"//我的团队
#import "Mine_Promotion_ViewController.h"//推广业绩
#import "GoCoin_Login_NavView.h"
#import "JB_WebView_Controller.h"
#import "GlobalProtocolViewController.h"
#import "Mine_Spertor_List_Model.h"

@interface Mine_Spertor_List_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *heardImage;

@property (nonatomic, strong) UIView  *teamView;
@property (nonatomic, strong) UILabel  *teamLab;//我的团队
@property (nonatomic, strong) UILabel  *teamCountLab;//团队人数
@property (nonatomic, strong) UIButton  *teamListBtn;//查看团队列表>

@property (nonatomic, strong) UIView  *signBackView;//签到

@property (nonatomic, strong) UIImageView  *rebateImageView;//返佣
@property (nonatomic, strong) UILabel  *rebateTitle;//我的返佣
@property (nonatomic, strong) UIButton  *rebateBtn;//返佣明细
@property (nonatomic, strong) UILabel  *modeyTitleLab;//余额
@property (nonatomic, strong) UILabel  *youLeTitleLab;//油乐券
@property (nonatomic, strong) UILabel  *gouWuTitleLab;//购物券
@property (nonatomic, strong) UILabel  *modeyTitle;//余额
@property (nonatomic, strong) UILabel  *youLeTitle;//油乐券
@property (nonatomic, strong) UILabel  *gouWuTitle;//购物券
@property (nonatomic, strong) UIButton  *yaoQingBtn;//邀请好友

@property (nonatomic,strong) GoCoin_Login_NavView *navView;


@end

@implementation Mine_Spertor_List_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.title = SSKJLocalized(@"推广邀请", nil);

//    _arr = @[SSKJLocalized(@"推广海报", nil),SSKJLocalized(@"我的团队", nil),SSKJLocalized(@"推广业绩", nil)];
//    [self.view addSubview:self.tableView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.heardImage];
    [self.scrollView addSubview:self.teamView];
    
    [self.teamView addSubview:self.teamLab];
    [self.teamView addSubview:self.teamCountLab];
    [self.teamView addSubview:self.teamListBtn];
    
    [self.scrollView addSubview:self.rebateImageView];
    [self.rebateImageView addSubview:self.rebateTitle];
    [self.rebateImageView addSubview:self.rebateBtn];

    [self.scrollView addSubview:self.signBackView];
    
    [self.rebateImageView addSubview:self.modeyTitle];
    [self.rebateImageView addSubview:self.modeyTitleLab];
    [self.rebateImageView addSubview:self.youLeTitle];
    [self.rebateImageView addSubview:self.youLeTitleLab];
    [self.rebateImageView addSubview:self.gouWuTitle];
    [self.rebateImageView addSubview:self.gouWuTitleLab];
    [self.rebateImageView addSubview:self.yaoQingBtn];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.rebateImageView.bottom + ScaleW(50));


    [self navView];

}

- (UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_TabBar)];
        _scrollView.backgroundColor = kGrayWhiteColor;
        if (@available(iOS 11.0, *)){
                   _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
               }else{
                   self.automaticallyAdjustsScrollViewInsets = NO;
               }
    }
    return _scrollView;
}
- (GoCoin_Login_NavView *)navView
{
    if (_navView == nil) {
        
        _navView = [[GoCoin_Login_NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Height_NavBar)];
        
        _navView.rightBtn.hidden = YES;
        _navView.titleLabel.text = SSKJLocalized(@"推广", nil);
        _navView.backBtn.hidden = YES;
        WS(weakSelf);
        
        _navView.BackBtnBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        [self.view addSubview:_navView];
    }
    return _navView;
}

- (UIImageView *)heardImage{
    if (_heardImage == nil) {
        _heardImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, ScaleW(380))];
        _heardImage.image = [UIImage imageNamed:@"promotion_heard"];
        _heardImage.userInteractionEnabled = YES;
        UIButton *qiandaoBtn = [UIButton new];
        qiandaoBtn.backgroundColor = UIColorFromRGB(0x009d6a);
        qiandaoBtn.titleLabel.font = systemFont(ScaleW(14));
        [qiandaoBtn setTitle:SSKJLocalized(@"签到规则", nil) forState:UIControlStateNormal];
        [qiandaoBtn setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        [qiandaoBtn addTarget:self action:@selector(signRuleEvent) forControlEvents:UIControlEventTouchUpInside];
        qiandaoBtn.frame = CGRectMake(ScaleW(292), Height_NavBar, ScaleW(83), ScaleW(24));
        [qiandaoBtn setCornerRadius:ScaleW(12)];
        [_heardImage addSubview:qiandaoBtn];
    }
    return _heardImage;
}

- (UIView *)teamView{
    if (_teamView == nil) {
        _teamView = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), self.heardImage.bottom - ScaleW(24), ScreenWidth - ScaleW(30), ScaleW(60))];
        _teamView.backgroundColor = kMainWihteColor;
        _teamView.clipsToBounds = YES;
        _teamView.layer.cornerRadius = ScaleW(3);
    }
    return _teamView;
}
- (UILabel *)teamLab{
    if (_teamLab == nil) {
        _teamLab = [WLTools allocLabel:SSKJLocalized(@"我的团队：", nil) font:systemFont(ScaleW(15)) textColor:TextGray1d312f frame:CGRectMake(ScaleW(15), 0, ScaleW(80), _teamView.height) textAlignment:NSTextAlignmentLeft];
    }
    return _teamLab;
}

- (UILabel *)teamCountLab{
    if (_teamCountLab == nil) {
        _teamCountLab = [WLTools allocLabel:SSKJLocalized(@"人", nil) font:systemBoldFont(ScaleW(18)) textColor:TextGray1d312f frame:CGRectMake(_teamLab.right, 0, ScaleW(120), _teamView.height) textAlignment:NSTextAlignmentLeft];
    }
    return _teamCountLab;
}

- (UIButton *)teamListBtn{
    if (_teamListBtn == nil) {
        _teamListBtn = [WLTools allocButton:SSKJLocalized(@"查看团队列表>", nil) textColor:kNavBGColor nom_bg:nil hei_bg:nil frame:CGRectMake(_teamView.width - ScaleW(15) - ScaleW(95), 0, ScaleW(95), _teamView.height)];
        _teamListBtn.titleLabel.font = systemFont(ScaleW(14));
        _teamListBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_teamListBtn addTarget:self action:@selector(teamListClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _teamListBtn;
}


- (UIView *)signBackView {
    if (nil == _signBackView) {
        _signBackView = [UIView new];
        _signBackView.backgroundColor = kMainWihteColor;
        _signBackView.frame = CGRectMake(ScaleW(15), self.teamView.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(90));
        UIImageView *imgView = [FactoryUI createImageViewWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(60), ScaleW(60)) imageName:@"homepage_sign"];
//        imgView.backgroundColor = [UIColor redColor];
        UILabel *titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(imgView.right + ScaleW(20), ScaleW(25), ScaleW(180), ScaleW(16)) text:SSKJLocalized(@"您还有一份惊喜未领取", nil) textColor:kTheMeColor font:systemFont(ScaleW(16))];
        UILabel *subLabel = [FactoryUI createLabelWithFrame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(14), ScaleW(130), ScaleW(14)) text:SSKJLocalized(@"每日签到，惊喜多多", nil) textColor:kGrayTitleColor font:systemFont(ScaleW(14))];
        UIButton *signBtn = [FactoryUI createButtonWithFrame:CGRectMake(_signBackView.width - ScaleW(60) - ScaleW(10), ScaleW(34), ScaleW(60), ScaleW(22)) title:SSKJLocalized(@"立即签到", nil) titleColor:kMainWihteColor imageName:nil backgroundImageName:nil target:self selector:@selector(signEvent) font:systemFont(ScaleW(12))];
        signBtn.backgroundColor = kTheMeColor;
        [signBtn setCornerRadius:ScaleW(11)];
        
        [_signBackView addSubview:imgView];
        [_signBackView addSubview:titleLabel];
        [_signBackView addSubview:subLabel];
        [_signBackView addSubview:signBtn];

    }
    return _signBackView;
}




//返佣
- (UIImageView *)rebateImageView{
    if (_rebateImageView == nil) {
        _rebateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(8), self.signBackView.bottom + ScaleW(10), ScreenWidth - ScaleW(16), ScaleW(193))];
        _rebateImageView.userInteractionEnabled = YES;
        _rebateImageView.image = [UIImage imageNamed:@"promotion_rebate"];
    }
    return _rebateImageView;
}

- (UILabel *)rebateTitle{
    if (_rebateTitle == nil) {
        _rebateTitle = [WLTools allocLabel:SSKJLocalized(@"我的返佣", nil) font:systemFont(ScaleW(18)) textColor:TextGray1d312f frame:CGRectMake((self.rebateImageView.width - ScaleW(80))/2, 0, ScaleW(80), ScaleW(54)) textAlignment:NSTextAlignmentCenter];
    }
    return _rebateTitle;
}
- (UIButton *)rebateBtn{
    if (_rebateBtn == nil) {
        _rebateBtn = [WLTools allocButton:SSKJLocalized(@"返佣明细", nil) textColor:kNavBGColor nom_bg:nil hei_bg:nil frame:CGRectMake(_teamView.width - ScaleW(16) - ScaleW(65), 0, ScaleW(65), ScaleW(54))];
        _rebateBtn.titleLabel.font = systemFont(ScaleW(15));
        _rebateBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_rebateBtn addTarget:self action:@selector(fanYongClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rebateBtn;
}

//余额
- (UILabel *)modeyTitle{
    if (_modeyTitle == nil) {
        _modeyTitle = [WLTools allocLabel:SSKJLocalized(@"0", nil) font:systemBoldFont(ScaleW(19)) textColor:TextGray1d312f frame:CGRectMake(ScaleW(10), self.rebateBtn.bottom + ScaleW(26), self.rebateImageView.width/3 - ScaleW(20) , ScaleW(20)) textAlignment:NSTextAlignmentCenter];
    }
    return _modeyTitle;
}

- (UILabel *)modeyTitleLab{
    if (_modeyTitleLab == nil) {
        _modeyTitleLab = [WLTools allocLabel:SSKJLocalized(@"余额", nil) font:systemFont(ScaleW(13)) textColor:TextGray6a6b6e frame:CGRectMake(ScaleW(10), self.modeyTitle.bottom + ScaleW(9), self.rebateImageView.width/3 - ScaleW(20) , ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _modeyTitleLab;
}



- (UILabel *)youLeTitle{
    if (_youLeTitle == nil) {
        _youLeTitle = [WLTools allocLabel:SSKJLocalized(@"0", nil) font:systemBoldFont(ScaleW(19)) textColor:TextGray1d312f frame:CGRectMake(self.rebateImageView.width/3, self.rebateBtn.bottom + ScaleW(26), self.rebateImageView.width/3 , ScaleW(20)) textAlignment:NSTextAlignmentCenter];
    }
    return _youLeTitle;
}

- (UILabel *)youLeTitleLab{
    if (_youLeTitleLab == nil) {
        _youLeTitleLab = [WLTools allocLabel:SSKJLocalized(@"油乐券", nil) font:systemFont(ScaleW(13)) textColor:TextGray6a6b6e frame:CGRectMake(self.rebateImageView.width/3, self.modeyTitle.bottom + ScaleW(9), self.rebateImageView.width/3 , ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _youLeTitleLab;
}


- (UILabel *)gouWuTitle{
    if (_gouWuTitle == nil) {
        _gouWuTitle = [WLTools allocLabel:SSKJLocalized(@"0", nil) font:systemBoldFont(ScaleW(19)) textColor:TextGray1d312f frame:CGRectMake(self.rebateImageView.width/3 * 2 + ScaleW(10), self.rebateBtn.bottom + ScaleW(26), self.rebateImageView.width/3 - ScaleW(20) , ScaleW(20)) textAlignment:NSTextAlignmentCenter];
    }
    return _gouWuTitle;
}

- (UILabel *)gouWuTitleLab{
    if (_gouWuTitleLab == nil) {
        _gouWuTitleLab = [WLTools allocLabel:SSKJLocalized(@"购物券", nil) font:systemFont(ScaleW(13)) textColor:TextGray6a6b6e frame:CGRectMake(self.rebateImageView.width/3 * 2 + ScaleW(10), self.modeyTitle.bottom + ScaleW(9), self.rebateImageView.width/3 - ScaleW(20) , ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _gouWuTitleLab;
}

- (UIButton *)yaoQingBtn{
    if (_yaoQingBtn == nil) {
        _yaoQingBtn = [WLTools allocButton:SSKJLocalized(@"邀请好友", nil) textColor:kMainWihteColor nom_bg:nil hei_bg:nil frame:CGRectMake((self.rebateImageView.width - ScaleW(130))/2, self.rebateImageView.height - ScaleW(15) - ScaleW(34), ScaleW(130), ScaleW(34))];
        _yaoQingBtn.titleLabel.font = systemFont(ScaleW(13));
        _yaoQingBtn.backgroundColor = kNavBGColor;
        _yaoQingBtn.layer.cornerRadius = ScaleW(17);
        _yaoQingBtn.clipsToBounds = YES;
        [_yaoQingBtn addTarget:self action:@selector(yaoQingClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _yaoQingBtn;
}

#pragma mark - 查看团队列表
- (void)teamListClick{
    
    MyTeamViewController *vc = [[MyTeamViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 邀请好友
- (void)yaoQingClick{
    Mine_Spertor_ViewController *vc = [[Mine_Spertor_ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}
#pragma mark - 返佣明细
- (void)fanYongClick{
    Mine_Promotion_ViewController *vc = [[Mine_Promotion_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)signRuleEvent{
    //邀请规则
    GlobalProtocolViewController *gVC = [GlobalProtocolViewController new];
    gVC.type = 3;
    [self.navigationController pushViewController:gVC animated:YES];
}
#pragma mark - 签到

- (void)signEvent {
    [self requestSign];
}
- (void)requestSign {
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kYLJ_center_sign RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            //            [self.headerView reloadData];
        }else{
        }
        [MBProgressHUD showError:network_model.msg];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self requestData];
}
#pragma mark - 页面即将显示
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

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
   
    cell.valueLabel.text = @"";
   
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row)
    {
#pragma mark case 推广海报
        case 0:
        {
            Mine_Spertor_ViewController *vc = [[Mine_Spertor_ViewController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
           
        }
            break;
#pragma mark case 我的团队
        case 1:
        {
            MyTeamViewController *vc = [[MyTeamViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
#pragma mark case 推广业绩
        case 2:
        {
           
            Mine_Promotion_ViewController *vc = [[Mine_Promotion_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}

- (void)requestData {
    
    NSDictionary * params = @{
//                              @"bank_user_name":self.accountView.valueString,
//                              @"bank_name":self.bankTypeView.valueString,
//                              @"bank_open":self.bankBranchView.valueString,
//                              @"bank_number":[WLTools md5:self.bankAcountView.valueString],
                              };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_team_jiBiecount_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            Mine_Spertor_List_Model *model = [Mine_Spertor_List_Model mj_objectWithKeyValues:network_model.data];
            self.teamCountLab.text = [NSString stringWithFormat:@"%@人",model.tearm_count];
            self.modeyTitle.text = [WLTools noroundingStringWith:model.money.doubleValue afterPointNumber:2];
            self.youLeTitle.text = [WLTools noroundingStringWith:model.coupon.doubleValue afterPointNumber:2];
            self.gouWuTitle.text = [WLTools noroundingStringWith:model.shop_balance.doubleValue afterPointNumber:2];

        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

@end
