//
//  YEC_My_Root_ViewController.m
//  SSKJ
//
//  Created by 孙 on 2019/7/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "YEC_My_Root_ViewController.h"
#import "SKSecurityCenterVC.h"//安全中心
#import "ZSJ_SettingViewController.h"
#import "Mine_Spertor_List_ViewController.h"//推广列表
#import "My_CommunityController.h"//社区
#import "Super_Myaddress_ViewController.h"//收货地址
#import "MallBalanceViewController.h"//商城余额
#import "MyIncomeStaticViewController.h"//静态收益
#import "MyIncomeDynamicViewController.h"//动态收益
#import "ActivateViewController.h"//激活预约
#import "ActivateDetailViewController.h"//支付页面
#import "Shop_OrderListRoot_VewController.h"
#import "SSKJ_UserInfo_Model.h"//用户地址

@interface YEC_My_Root_ViewController ()

@property(nonatomic,strong)UIScrollView * myScrollView;
@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)UILabel * phoneLab;
@property(nonatomic,strong)UILabel *uidLab;

@property(nonatomic,strong)UILabel * sortLab;



@property (nonatomic, strong) UIView * scrollTextView;

@property (nonatomic, strong)UIImageView* rankImageView;

@property (nonatomic, strong) UIButton *leftView;
@property(nonatomic, strong)UILabel *rankLab;//待激活

@property(nonatomic, strong)UILabel *stoPriceLabel;
@property(nonatomic, strong)UILabel *fluctuateLabel;

@property(nonatomic, strong)UILabel *liuTongLabel;
@property(nonatomic, strong)UILabel *faXingLabel;
@property(nonatomic, strong)UILabel *rateLabel;


@property (nonatomic,strong)UIButton *loginBtn;

@end

@implementation YEC_My_Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"我的", nil);
//    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"shezhi"]];

    [self initView];
    

    //GUDONG_ICON
    //[self addLeftNavItemWithTitle:SSKJLocalized(@"股东", nil) color:kMainWihteColor];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:self.leftView];
//
//    self.navigationItem.leftBarButtonItem = item;
    
    
}

-(UIButton *)leftView
{
    if (!_leftView) {
        _leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftView.frame = CGRectMake(0, 0, ScaleW(60), ScaleW(16));
        [_leftView btn:_leftView font:ScaleW(0) textColor:kMainColor text:@"" image:nil sel:@selector(leftAction) taget:self];
        
        UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(25), ScaleW(16))];
        right.image = [UIImage imageNamed:@"GUDONG_ICON"];
        
        [_leftView addSubview:right];
        
        right.centerY = _leftView.centerY;
        
        UILabel *label = [WLTools allocLabel:SSKJLocalized(@"股东", nil) font:systemFont(ScaleW(13)) textColor:kMainWihteColor frame:CGRectMake(ScaleW(8) + right.right, 0, ScaleW(30), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        
        label.numberOfLines = 1;
        
        [label sizeToFit];
        
        _leftView.width = label.right;
        
        [_leftView addSubview:label];
        
         label.centerY = _leftView.centerY;
    }
    return _leftView;
}
- (void)addLeftNavItemWithTitle:(NSString*)title color:(UIColor *)color
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
    item.tintColor = color;
    self.navigationItem.leftBarButtonItem = item;
    
}
#pragma mark -- 设置

-(void)leftAction
{
    
    if (!kLogin) {
        
        //        [MBProgressHUD showError:SSKJLocalized(@"请先登录", nil)];
        [self presentLoginController];
        
        return;
    }
    
    ZSJ_SettingViewController *setV = [[ZSJ_SettingViewController alloc] init];
    [self.navigationController pushViewController:setV animated:true];
}

-(void)leftBtnAction:(id)sender
{
   
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (kLogin) {
        [self requestUserInfo];
        self.phoneLab.hidden = NO;
        self.uidLab.hidden = NO;
        self.loginBtn.hidden = YES;
        self.headerImageView.image = [UIImage imageNamed:@"default_header_login"];
    }else{
        self.phoneLab.hidden = YES;
        self.uidLab.hidden = YES;
        self.loginBtn.hidden = NO;
//        [self.loginBtn setTitle:SSKJLocalized(@"您还未登录", nil) forState:UIControlStateNormal];

        self.headerImageView.image = [UIImage imageNamed:@"default_header"];

    }
    
}

#pragma mark -- 设置
-(void)rigthBtnAction:(id)sender
{
    
}


-(void)initView
{
    
    [self.view addSubview:self.myScrollView];
    
    UIView * bigBgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(Height_NavBar+151))];
    bigBgView.backgroundColor = kMainColor;
    
    [self.myScrollView addSubview:bigBgView];
    
    
    
    UIImage * mine_header_image = [UIImage imageNamed:@"mine_header_bg"];
    
    UIImageView * bgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, mine_header_image.size.height)];
    bgView.image = mine_header_image;
    bgView.userInteractionEnabled = YES;
    
    [bigBgView addSubview:bgView];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headEvent)];
//    [bgView addGestureRecognizer:tap];
    
    
    UILabel * titleLab =[[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth -ScaleW(200))/2, Height_StatusBar, ScaleW(200), Height_NavBar-Height_StatusBar)];
    
    titleLab.font = systemScaleBoldFont(18);
    titleLab.textColor = kMainTextColor;
    titleLab.text = SSKJLocalized(@"个人中心", nil);
    titleLab.textAlignment = NSTextAlignmentCenter;
    
    [self.myScrollView addSubview:titleLab];
    
    
    
    
    
    _leftView = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftView.frame = CGRectMake(ScreenWidth-ScaleW(60), Height_StatusBar, ScaleW(60), ScaleW(44));
    [_leftView btn:_leftView font:ScaleW(0) textColor:kMainColor text:@"" image:[UIImage imageNamed:@"mine_shezhi"] sel:@selector(leftAction) taget:self];
    
    [self.myScrollView addSubview:_leftView];
    
    
 
    UIImage * mine_header_bottom = [UIImage imageNamed:@"mine_bottom"];
    
    UIImageView * bottomView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(15), Height_NavBar, ScreenWidth -ScaleW(30), ScaleW(151))];
    bottomView.image = mine_header_bottom;
//    bottomView.backgroundColor = [UIColor redColor];
    bottomView.userInteractionEnabled = YES;
    
    [bigBgView addSubview:bottomView];

    
    
    
    
    [bottomView addSubview:self.headerImageView];
    
    
    
    [bottomView addSubview:self.phoneLab];
    
   
    [bottomView addSubview:self.uidLab];
    
    [bottomView addSubview:self.loginBtn];

    
    [bottomView addSubview:self.rankImageView];
//    self.headerImageView = headerImageView;
    
 
    
//    self.uidLab = uidLab;
    
    
    UILabel * rankLab = [[UILabel alloc] initWithFrame:CGRectMake( ScaleW(33), ScaleW(0) , self.rankImageView.width - ScaleW(33)- ScaleW(13)-ScaleW(8+5) -ScaleW(5), self.rankImageView.height)];
    
    rankLab.text = SSKJLocalized(@"待激活", nil);
    _rankLab = rankLab;
    rankLab.textAlignment = NSTextAlignmentLeft;
    rankLab.textColor = UIColorFromRGB(0xfefefe);
    
    rankLab.font = systemFont(ScaleW(14));
    rankLab.adjustsFontSizeToFitWidth = YES;
    [self.rankImageView addSubview:rankLab];
    
    
    UIImageView * arrowImageView =[[UIImageView alloc] initWithFrame:CGRectMake(self.rankImageView.width-ScaleW(8)-ScaleW(10), (self.rankImageView.height - ScaleW(10))/2, ScaleW(10), ScaleW(10))];
    
    arrowImageView.image = [UIImage imageNamed:@"daijihuo_icon"];
    
    [self.rankImageView addSubview: arrowImageView];
    
    
    
    {
        
        NSArray *nameArr =@[@"动态收益",@"静态收益",@"商城余额"];
        
        NSArray * imageArr = @[@"dongtaishouyi",@"jingtaishouyi",@"shopYue"];
        
        for (int i = 0 ; i<nameArr.count; i++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(bottomView.width/3 * (i%3), ScaleW(95), bottomView.width/3, ScaleW(40));
            
            [button addTarget:self action:@selector(itemEventTop:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor clearColor];
            
            button.tag = 2000 + i;
            
            UIImageView * imageView =[[UIImageView alloc] initWithFrame:CGRectMake(button.width/2 - ScaleW(20)/2, 0, ScaleW(20), ScaleW(20))];
            imageView.image = [UIImage imageNamed:imageArr[i]];
            
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            [button addSubview:imageView];
            
            
            UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(5), button.height - ScaleW(14) , button.width - ScaleW(5)*2, ScaleW(14))];
            titleLab.textColor = kMainWihteColor;
            titleLab.font = systemMediumFont(14);
            titleLab.textAlignment = NSTextAlignmentCenter;
            titleLab.text = SSKJLocalized(nameArr[i], nil);
            
            [button addSubview:titleLab];
            
            
            [bottomView addSubview:button];
            
            
            
            
        }
    }
    
    
   
    
    
    UIView * itemView = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), bigBgView.bottom + ScaleW(12) , ScreenWidth- ScaleW(15)*2, ScaleW(384))];
    
    itemView.layer.masksToBounds = YES;
    
    itemView.layer.cornerRadius = ScaleW(5);
    
    itemView.backgroundColor = kMianBgColor;
    [self.myScrollView addSubview:itemView];
    
 
    
    
    NSArray *nameArr =@[@"安全中心",@"推广邀请",@"我的社区",@"我的订单",@"收货地址",@"生活缴费",@"聊天",@"众筹",@"持币生息",@"游戏",@"旅游",@"子链"];
    
    NSArray * imageArr = @[@"safeCenter",@"tuiGuangLink",@"mySheQu",@"myOrder",@"shouHuoAdress",@"lifeJiFei",
        @"chatView",@"zhongchou_my",@"chiCoinLiXi",@"game_mine",@"lvYou_mine",@"ziLian_mine"];
    
    for (int i = 0 ; i<nameArr.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(itemView.width/3 * (i%3), itemView.height/4*(i/3), itemView.width/3, itemView.height/4);
        
        [button addTarget:self action:@selector(itemEvent:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        
        button.tag = 1122334455 + i;
        
//        [button setTitle:SSKJLocalized(nameArr[i], nil) forState:UIControlStateNormal];
//
//        button.titleLabel.font = systemMediumFont(15);
//        [button setTitleColor:kMainWihteColor forState:UIControlStateNormal];
//
//        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
//

        UIImage *image = [UIImage imageNamed:imageArr[i]];
        
        UIImageView * imageView =[[UIImageView alloc] initWithFrame:CGRectMake(button.width/2 - image.size.width/2, ScaleW(23), image.size.width, image.size.height)];
        imageView.image = image;
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [button addSubview:imageView];
        
        
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(5), button.height - ScaleW(23) - ScaleW(14) , button.width - ScaleW(5)*2, ScaleW(14))];
        titleLab.textColor = UIColorFromRGB(0x9a9a9a);
        titleLab.font = systemMediumFont(13);
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = SSKJLocalized(nameArr[i], nil);
        
        [button addSubview:titleLab];
        
        
        [itemView addSubview:button];
    
      
        
        
    }
    
//    UIImageView * shuImageView =[[UIImageView alloc] initWithFrame:CGRectMake(itemView.width/3, 0 , 1, itemView.height)];
//    shuImageView.backgroundColor =kTextColor313359;
//    [itemView addSubview:shuImageView];
//
//    UIImageView * shuImageView1 =[[UIImageView alloc] initWithFrame:CGRectMake(itemView.width/3*2, 0 , 1, itemView.height)];
//    shuImageView1.backgroundColor =kTextColor313359;
//    [itemView addSubview:shuImageView1];
//
//
//    UIImageView * hengImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, itemView.height/2 , itemView.width, 1)];
//    hengImageView.backgroundColor =kTextColor313359;
//    [itemView addSubview:hengImageView];
    
//       _myScrollView.contentSize = CGSizeMake(ScreenWidth, ((itemView.bottom >ScreenHeight)?itemView.bottom:ScreenHeight)+ ScaleW(10));
    
//    UIButton* submiteButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), itemView.bottom + ScaleW(100), ScreenWidth - ScaleW(50), ScaleW(45))];
//    //        _submiteButton.layer.cornerRadius = _submiteButton.height / 2;
//    submiteButton.backgroundColor = kTextColorc2965b;
//    [submiteButton setTitle:SSKJLocalized(@"退出登录", nil) forState:UIControlStateNormal];
//    [submiteButton setTitleColor:kMainWihteColor forState:UIControlStateNormal];
//    submiteButton.titleLabel.font = systemFont(ScaleW(16));
//    [submiteButton addTarget:self action:@selector(sureEvent) forControlEvents:UIControlEventTouchUpInside];
//    //        [_submiteButton addGradientColor];
//    submiteButton.layer.masksToBounds = YES;
//    submiteButton.layer.cornerRadius = ScaleW(10);
//    
//    [_myScrollView addSubview:submiteButton];
    
    _myScrollView.contentSize = CGSizeMake(ScreenWidth, ((titleLab.bottom >ScreenHeight)?titleLab.bottom:ScreenHeight)+ ScaleW(10));
    
}
-(void)noticeEvent:(UIButton*)sender
{
    
 
}
-(UIImageView*)headerImageView
{
    if (_headerImageView == nil) {
        UIImageView * headerImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScaleW(14), ScaleW(17), ScaleW(47), ScaleW(47))];
        headerImageView.layer.cornerRadius = headerImageView.height/2;
        
        headerImageView.image = [UIImage imageNamed:@"default_header"];
        headerImageView.layer.masksToBounds = YES;
        _headerImageView = headerImageView;
        
        
    }
    return _headerImageView;
    
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.headerImageView.right + ScaleW(13), self.headerImageView.top, ScaleW(145), self.headerImageView.height)];
        _loginBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_loginBtn setTitle:SSKJLocalized(@"您还未登录", nil) forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kMainWihteColor forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = systemBoldFont(ScaleW(21));
        [_loginBtn addTarget:self action:@selector(pullLogin) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.hidden = YES;
    }
    return _loginBtn;
}

#pragma mark - 拉起登录
- (void)pullLogin{
    if (!kLogin) {
        
        //        [MBProgressHUD showError:SSKJLocalized(@"请先登录", nil)];
        [self presentLoginController];
        return;
    }
}

-(UIImageView*)rankImageView
{
    if (_rankImageView == nil) {
        UIImageView * headerImageView =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-ScaleW(30)-ScaleW(115),ScaleW(34), ScaleW(115), ScaleW(26))];
//        headerImageView.layer.cornerRadius = headerImageView.height/2;
        
        headerImageView.image = [UIImage imageNamed:@"mine_status_bg"];
//        headerImageView.layer.masksToBounds = YES;
//        _rankImageView.backgroundColor = [UIColor redColor];
        _rankImageView = headerImageView;
        headerImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectJiHuoImage)];
        
        [headerImageView addGestureRecognizer:tap];
        
    }
    return _rankImageView;
    
}
-(UILabel*)phoneLab
{
    if (_phoneLab ==nil) {
        UILabel * phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.right + ScaleW(13), ScaleW(25), ScaleW(200),ScaleW(13))];
        
        phoneLab.text = @"";
        
        phoneLab.textAlignment = NSTextAlignmentLeft;
        phoneLab.textColor = kMainWihteColor;
        
        phoneLab.font = systemBoldFont(ScaleW(16));
        _phoneLab = phoneLab;
    }
    
    return _phoneLab;
}
-(UILabel*)uidLab
{
    if (_uidLab == nil) {
        UILabel * uidLab = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.right + ScaleW(13), self.phoneLab.bottom + ScaleW(8) , ScaleW(200), ScaleW(10))];
        
        uidLab.text = @"--";
        
        uidLab.textAlignment = NSTextAlignmentLeft;
        uidLab.textColor = kTextb9b9b9;
        
        uidLab.font = systemFont(ScaleW(12));
        
        _uidLab = uidLab;
    }
    return _uidLab;
    
}

-(void)headEvent
{
    
}
#pragma mark -- 激活
-(void)selectJiHuoImage{
    
    if (!kLogin) {
        
        //        [MBProgressHUD showError:SSKJLocalized(@"请先登录", nil)];
        [self presentLoginController];
        
        return;
    }
    
    switch ([SSKJ_User_Tool sharedUserTool].userInfoModel.level.intValue) {
        case 0:
        {
            if ([SSKJ_User_Tool sharedUserTool].userInfoModel.is_trans.integerValue == 0) {
                if ([SSKJ_User_Tool sharedUserTool].userInfoModel.is_yuyue.integerValue == 0) {
                    //未预约  待激活
                    //选择套餐
                    ActivateViewController *vc = [[ActivateViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:true];
                }else if ([SSKJ_User_Tool sharedUserTool].userInfoModel.is_yuyue.integerValue == 1){
                    //已经预约  未支付
//                    self.rankLab.text = SSKJLocalized(@"待支付", nil);
                    //支付页面
                    ActivateDetailViewController *vc = [[ActivateDetailViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:true];
                }
            }
        }
            break;
//        case 1:
//            self.rankLab.text = SSKJLocalized(@"初级经济人", nil);
//            break;
//        case 2:
//            self.rankLab.text = SSKJLocalized(@"中级经济人", nil);
//
//            break;
//        case 3:
//            self.rankLab.text = SSKJLocalized(@"高级经济人", nil);
//
//            break;
//        case 4:
//            self.rankLab.text = SSKJLocalized(@"超级经济人", nil);
//
//            break;
//        case 5:
//            self.rankLab.text = SSKJLocalized(@"特级经济人", nil);
//
//            break;
        default:
            break;
    }
    
    
    
   
}

#pragma mark -- 收益  余额
-(void)itemEventTop:(UIButton *)sender{
    if (!kLogin) {
        
//        [MBProgressHUD showError:SSKJLocalized(@"请先登录", nil)];
        [self presentLoginController];
        return;
    }
    
    switch (sender.tag - 2000) {
        case 0:
        {
#pragma mark -- @"动态收益"
            MyIncomeDynamicViewController * securityCenterVC = [[MyIncomeDynamicViewController alloc] init];
            
            [self.navigationController pushViewController:securityCenterVC animated:YES];
        }
            break;
            
        case 1:
        {
#pragma mark -- @"静态收益"
            MyIncomeStaticViewController * securityCenterVC = [[MyIncomeStaticViewController alloc] init];
            
            [self.navigationController pushViewController:securityCenterVC animated:YES];
        }
            break;
        case 2:
        {
#pragma mark -- @"商城余额"

            MallBalanceViewController * securityCenterVC = [[MallBalanceViewController alloc] init];
            
            [self.navigationController pushViewController:securityCenterVC animated:YES];
        }
            break;
        
        default:
            break;
    }
    
    
}
#pragma mark -- item 事件
-(void)itemEvent:(UIButton *)sender
{
    
    if (!kLogin) {
        
//        [MBProgressHUD showError:SSKJLocalized(@"请先登录", nil)];
        [self presentLoginController];

        return;
    }
    switch (sender.tag - 1122334455) {
        case 0:
        {
#pragma mark -- @"安全中心"
          
            SKSecurityCenterVC * securityCenterVC = [[SKSecurityCenterVC alloc] init];
            
            [self.navigationController pushViewController:securityCenterVC animated:YES];
        }
            break;
            
        case 1:
        {

#pragma mark -- @"推广邀请"

            Mine_Spertor_List_ViewController * securityCenterVC = [[Mine_Spertor_List_ViewController alloc] init];
            
            [self.navigationController pushViewController:securityCenterVC animated:YES];
        }
            break;
        case 2:
        {
#pragma mark -- @"我的社区"

            if ([SSKJ_User_Tool sharedUserTool].userInfoModel.is_community.intValue == 1) {
                My_CommunityController * securityCenterVC = [[My_CommunityController alloc] init];
                
                [self.navigationController pushViewController:securityCenterVC animated:YES];
            }
            else
            {
                
                [MBProgressHUD showError:SSKJLocalized(@"您还不是社区成员", nil)];
            }
            
          
        }
            break;
        case 3:
        {
#pragma mark -- @"我的订单"
            Shop_OrderListRoot_VewController *vc = [[Shop_OrderListRoot_VewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
        //收获地址
#pragma mark -- @"收获地址"

            Super_Myaddress_ViewController * securityCenterVC = [[Super_Myaddress_ViewController alloc] init];
            securityCenterVC.type = 1;

            [self.navigationController pushViewController:securityCenterVC animated:YES];
        }
            break;
      
        default:
        {
            
            [MBProgressHUD showError:SSKJLocalized(@"暂未开放", nil)];
        }
            break;
    }
    
    
}


-(UIScrollView *)myScrollView
{
    if (_myScrollView == nil) {
        
        _myScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth , ScreenHeight)];
        if (@available(iOS 11.0, *)) {
            _myScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _myScrollView.backgroundColor = kMainColor;
//        _myScrollView.bounces = YES;

        
    }
    return _myScrollView;
}

#pragma mark 请求个人中心



-(void)requestUserInfo
{
    NSDictionary *params = @{
                             
                             };
    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_get_user_info_Api RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            
            [SSKJ_User_Tool sharedUserTool].userInfoModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_model.data];
            weakSelf.uidLab.text = [NSString stringWithFormat:@"UID：%@",[SSKJ_User_Tool sharedUserTool].userInfoModel.uid];
            weakSelf.phoneLab.text = [SSKJ_User_Tool sharedUserTool].userInfoModel.mobile;
            weakSelf.headerImageView.image = [UIImage imageNamed:@"default_header_login"];
            [weakSelf changeUI];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}
- (void)changeUI{
    
// level   ，未激活是 0普通会员 购买不同套餐（1、初级2、中级3、高级4、超级5、特级经纪
    //是否购买套餐激活  0否 1是   is_yuyue  //1已经预约 0 未预约
    
    switch ([SSKJ_User_Tool sharedUserTool].userInfoModel.level.integerValue) {
        case 0:
        {
            if ([SSKJ_User_Tool sharedUserTool].userInfoModel.is_trans.integerValue == 0) {
                if ([SSKJ_User_Tool sharedUserTool].userInfoModel.is_yuyue.integerValue == 0) {
                    //未预约
                    self.rankLab.text = SSKJLocalized(@"待激活", nil);
                }else if ([SSKJ_User_Tool sharedUserTool].userInfoModel.is_yuyue.integerValue == 1){
                    //已经预约  未支付
                    self.rankLab.text = SSKJLocalized(@"待支付", nil);
                }
            }
        }
            break;
        case 1:
             self.rankLab.text = SSKJLocalized(@"初级经纪人", nil);
            break;
        case 2:
            self.rankLab.text = SSKJLocalized(@"中级经纪人", nil);

            break;
        case 3:
            self.rankLab.text = SSKJLocalized(@"高级经纪人", nil);

            break;
        case 4:
            self.rankLab.text = SSKJLocalized(@"超级经纪人", nil);

            break;
        case 5:
            self.rankLab.text = SSKJLocalized(@"特级经纪人", nil);
            
            break;
        default:
            break;
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
