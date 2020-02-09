//
//  Mine_Spertor_ViewController.m
//  SSKJ
//
//  Created by 张本超 on 2019/6/12.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_Spertor_ViewController.h"

#import "Mine_SeptorViewHeaderView.h"

#import "MyTeamViewController.h"
#import "GoCoin_Login_NavView.h"
#import "GlobalProtocolViewController.h"
@interface Mine_Spertor_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) Mine_SeptorViewHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *mainImgView;

@property (nonatomic, strong) UIImageView *heardImage;

@property (nonatomic, strong) UIView *twoCodeView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *coopyBtn;
@property (nonatomic, strong) UIButton *inviteBtn;

@property (nonatomic, strong) UILabel *codelabel;

@property (nonatomic, strong) UIImageView *twoCodeImg;

@property (nonatomic,strong) GoCoin_Login_NavView *navView;

@end

@implementation Mine_Spertor_ViewController
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self requstData];
}
#pragma mark - 页面即将显示
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = SSKJLocalized(@"推广海报", nil);
    
    
////    [self.view addSubview:self.tableView];
//
//    [self.view addSubview:self.headerView];
//
//    [self addRightNavItemWithTitle:@"我的团队" color:kMainTextColor font:systemFont(ScaleW(15))];
    
    
    [self.view addSubview:self.mainImgView];
    [self.mainImgView addSubview:self.heardImage];

    [self.mainImgView addSubview:self.twoCodeView];
    
    [self.twoCodeView addSubview:self.twoCodeImg];
    [self.twoCodeView addSubview:self.titleLabel];
    [self.twoCodeView addSubview:self.codelabel];
    [self.twoCodeView addSubview:self.coopyBtn];
    [self.mainImgView addSubview:self.inviteBtn];

    [self navView];

}
- (GoCoin_Login_NavView *)navView
{
    if (_navView == nil) {
        
        _navView = [[GoCoin_Login_NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Height_NavBar)];
        
        _navView.rightBtn.hidden = YES;
        _navView.titleLabel.text = SSKJLocalized(@"邀请好友", nil);
        
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
        [qiandaoBtn setTitle:SSKJLocalized(@"邀请规则", nil) forState:UIControlStateNormal];
        [qiandaoBtn setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        [qiandaoBtn addTarget:self action:@selector(signRuleEvent) forControlEvents:UIControlEventTouchUpInside];
        qiandaoBtn.frame = CGRectMake(ScaleW(292), ScaleW(63), ScaleW(83), ScaleW(24));
        [qiandaoBtn setCornerRadius:ScaleW(12)];
        [_heardImage addSubview:qiandaoBtn];

    }
    return _heardImage;
}

-(UIImageView *)mainImgView
{
    if (!_mainImgView) {
        _mainImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
      
//            _mainImgView.image = [UIImage imageNamed:@"Inver_BacImg"];
            
        _mainImgView.backgroundColor = [WLTools stringToColor:@"#59CCA5"];
        _mainImgView.userInteractionEnabled = YES;
    }
    return _mainImgView;
}

-(UIView *)twoCodeView
{
    if (!_twoCodeView) {
        _twoCodeView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(8), ScreenHeight - ScaleW(16) -ScaleW(304), ScreenWidth - ScaleW(16), ScaleW(304))];
//        _twoCodeView.layer.cornerRadius = ScaleW(5);
//        [_twoCodeView setShadowView:_twoCodeView];
//        _twoCodeView.layer.cornerRadius = ScaleW(8);
//        _twoCodeView.layer.borderWidth = ScaleW(3);
//        _twoCodeView.layer.borderColor = UIColorFromRGB(0xacce4a).CGColor;
//        _twoCodeView.clipsToBounds = YES;
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _twoCodeView.width, _twoCodeView.height)];
        [_twoCodeView addSubview:bgImage];
        bgImage.image = [UIImage imageNamed:@"promotion_yaoqing"];
        
    }
    return _twoCodeView;
}
-(UIImageView *)twoCodeImg
{
    if (!_twoCodeImg) {
        _twoCodeImg = [[UIImageView alloc]initWithFrame:CGRectMake((_twoCodeView.width - ScaleW(135))/2, ScaleW(76), ScaleW(135), ScaleW(135))];
//        _twoCodeImg.backgroundColor = [UIColor purpleColor];
        _twoCodeImg.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *log = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(logAction:)];
        [_twoCodeImg addGestureRecognizer:log];
    }
    return _twoCodeImg;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"长按保存二维码", nil) font:systemFont(ScaleW(16)) textColor:TextGray1d312f frame:CGRectMake(0, 0, _twoCodeView.width, ScaleW(54)) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}
-(UILabel *)codelabel
{
    if (!_codelabel) {
        _codelabel = [WLTools allocLabel:@"" font:systemBoldFont(ScaleW(14)) textColor:TextGray666666 frame:CGRectMake((_twoCodeView.width - ScaleW(220))/2, _twoCodeImg.bottom + ScaleW(15), ScaleW(220), ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _codelabel;
}
-(UIButton *)coopyBtn
{
    if (!_coopyBtn) {
        _coopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _coopyBtn.frame = CGRectMake((_twoCodeView.width - ScaleW(130))/2, _twoCodeView.height - ScaleW(34) - ScaleW(15), ScaleW(130), ScaleW(34));
        _coopyBtn.layer.cornerRadius = ScaleW(17);
        _coopyBtn.clipsToBounds = YES;
        [_coopyBtn btn:_coopyBtn font:ScaleW(13) textColor:kMainWihteColor text:@"复制邀请码" image:nil sel:@selector(coopyBtnAction:) taget:self];
        _coopyBtn.backgroundColor = kNavBGColor;
    }
    return _coopyBtn;
}


-(UIButton *)inviteBtn
{
    if (!_inviteBtn) {
        _inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _inviteBtn.frame = CGRectMake(0, self.twoCodeView.top -ScaleW(30)-ScaleW(230), ScreenWidth, ScaleW(230));
        [_inviteBtn btn:_inviteBtn font:ScaleW(15) textColor:kMainWihteColor text:@"" image:nil sel:@selector(saveAction:) taget:self];
        _inviteBtn.backgroundColor = [UIColor clearColor];
    }
    return _inviteBtn;
}
-(void)saveAction:(UIButton*)sender
{
    
    UIGraphicsBeginImageContextWithOptions(self.mainImgView.size, NO, [UIScreen mainScreen].scale);
    [self.mainImgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(snapshotImage, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    
}

- (void)signRuleEvent{
    //邀请规则
    GlobalProtocolViewController *gVC = [GlobalProtocolViewController new];
    gVC.type = 2;
    [self.navigationController pushViewController:gVC animated:YES];
}

-(void)coopyBtnAction:(UIButton *)sender
{
    if (self.codelabel.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"获取失败", nil)];
        return;
    }
    
    [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string=self.codelabel.text;
}
-(void)logAction:(UILongPressGestureRecognizer *)log
{
    UIImage *img1 = _twoCodeImg.image;
    if (log.state == UIGestureRecognizerStateBegan) {
        
        UIImageWriteToSavedPhotosAlbum(img1, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    }
    
}
// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:SSKJLocalized(@"保存失败", nil)];
    } else {
        [MBProgressHUD showError:SSKJLocalized(@"保存至相册", nil)];
        return;
    }
}
-(void)rigthBtnAction:(id)sender{
    
    MyTeamViewController *vc = [[MyTeamViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight -  Height_NavBar) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
        
        _tableView.separatorColor = kMainBackgroundColor;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.backgroundColor = kSubBackgroundColor;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        // [_tableView registerClass:[JB_FBC_DealHall_Cell class] forCellReuseIdentifier:cellid];
        // WS(weakSelf);
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //           // [weakSelf headerRefresh];
        //        }];
        
        //        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //           // [weakSelf footerRefresh];
        //        }];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}
-(Mine_SeptorViewHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[Mine_SeptorViewHeaderView alloc]init];
    }
    return _headerView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return ScaleW(0.001);
    }
    return ScaleW(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Shop_OrderList_TableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Shop_OrderList_TableViewCell"];
        cell.backgroundColor = cell.contentView.backgroundColor = kMainWihteColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = kMainTextColor;
        cell.textLabel.font = systemFont(ScaleW(15));
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(5), ScaleW(49),_tableView.width - ScaleW(10), ScaleW(1))];
        lineView.backgroundColor = kMainLineColor;
        [cell.contentView addSubview:lineView];
        
    }
   
    
    return cell;
}

-(void)requstData{
  
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_tuiguang_link_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
            
    
            self.codelabel.text = netWorkModel.data[@"tgno"];
            //邀请二维码
           [self.twoCodeImg sd_setImageWithURL:[NSURL URLWithString:netWorkModel.data[@"qrc"]]];
//            [self.twoCodeImg sd_setImageWithURL:[NSURL URLWithString:netWorkModel.data[@"url"]]];

//            self.headerView.dataDic = netWorkModel.data;
//            self.tableView.tableHeaderView = self.headerView;
        }
        else
        {
            
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

@end
