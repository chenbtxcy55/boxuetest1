//
//  MyIncomeDynamicViewController.m
//  SSKJ
//
//  Created by zhao on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//
/*
 动态收益
 */
#import "MyIncomeDynamicViewController.h"

#import "MyIncomeDynamicHeardView.h"
#import "MyIncomeShareViewController.h"//分享奖励
#import "MyIncomeManageViewController.h"//管理奖励
#import "MyIncomeExtremeViewController.h"//级差奖励
#import "MyIncomeTeamViewController.h"//团队奖励
#import "MyIncomeWelfareViewController.h"//福利奖

#import "NinaPagerView.h"



@interface MyIncomeDynamicViewController ()<NinaPagerViewDelegate>
@property (nonatomic,strong)MyIncomeShareViewController *systemVC;


@property (nonatomic,strong)MyIncomeDynamicHeardView *heardView;
@property (nonatomic, strong) NinaPagerView *ninaPagerView;

@end

@implementation MyIncomeDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"动态收益", nil);
    [self.view addSubview:self.heardView];
    [self ninaPagerView];
}
- (NinaPagerView *) ninaPagerView
{
    
    if (!_ninaPagerView)
    {
        //行业资讯
        self.systemVC = [[MyIncomeShareViewController alloc]init];
        MyIncomeManageViewController *lockV = [[MyIncomeManageViewController alloc] init];
        MyIncomeExtremeViewController *fenHong = [[MyIncomeExtremeViewController alloc] init];
        MyIncomeTeamViewController *fuWu = [[MyIncomeTeamViewController alloc] init];
        
        
        MyIncomeWelfareViewController *fuWu1 = [[MyIncomeWelfareViewController alloc] init];
        NSArray *controllers=@[self.systemVC,lockV,fenHong,fuWu,fuWu1
                               ];
        
        NSArray *titleArray =@[SSKJLocalized(@"分享奖励", nil),SSKJLocalized(@"管理奖励", nil),SSKJLocalized(@"级差奖励", nil),SSKJLocalized(@"团队奖励", nil),SSKJLocalized(@"福利奖", nil)
                               ];
        _ninaPagerView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, ScaleW(150), ScreenWidth, ScreenHeight  - Height_NavBar - ScaleW(150)) WithTitles:titleArray WithObjects:controllers];
        
        _ninaPagerView.topTabBackGroundColor = kNavBGColor;
        
        _ninaPagerView.topTabHeight = ScaleW(40);
        
        _ninaPagerView.titleFont = 15;
        
        _ninaPagerView.sliderBlockColor = kNavBGColor;
        
        _ninaPagerView.underlineColor = UIColorFromRGB(0x5ba56f);
        
        _ninaPagerView.selectTitleColor = UIColorFromRGB(0x5ba56f);
        
        _ninaPagerView.nina_autoBottomLineEnable = YES;
        
        _ninaPagerView.nina_scrollEnabled = YES;
        
        _ninaPagerView.delegate = self;
        
        _ninaPagerView.selectBottomLinePer = 1;
        
        [self.view addSubview:_ninaPagerView];
        
    }
    return _ninaPagerView;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self requstHeardViewData];
    
}
- (MyIncomeDynamicHeardView *)heardView{
    if (!_heardView) {
        _heardView = [[MyIncomeDynamicHeardView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, ScaleW(150))];
    }
    return _heardView;
}
-(void)requstHeardViewData{
    
    WS(weakSelf);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:kIscm_concession_count_Api RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([netWorkModel.status isEqualToString:@"200"]) {
//            @property (nonatomic,strong)UILabel *tOneLab;//社区人数
//            @property (nonatomic,strong)UILabel *tTwoLab;//分享奖励
//            @property (nonatomic,strong)UILabel *tThreeLab;//管理奖励
//            @property (nonatomic,strong)UILabel *tFoutLab;//累计业绩
//
//            @property (nonatomic,strong)UILabel *bOneLab;//级差奖励
//            @property (nonatomic,strong)UILabel *bTwoLab;//团队奖励
//            @property (nonatomic,strong)UILabel *bThreeLab;//福利奖励
//            @property (nonatomic,strong)UILabel *bFoutLab;//大区业绩
            weakSelf.heardView.tOneLab.text =[WLTools noroundingStringWith:[netWorkModel.data[@"team_count"] doubleValue] afterPointNumber:4] ;
            weakSelf.heardView.tTwoLab.text = [WLTools noroundingStringWith:[netWorkModel.data[@"share_count"] doubleValue] afterPointNumber:4] ;
            weakSelf.heardView.tThreeLab.text = [WLTools noroundingStringWith:[netWorkModel.data[@"manager_reward_count"] doubleValue] afterPointNumber:4] ;
            weakSelf.heardView.tFoutLab.text =[WLTools noroundingStringWith:[netWorkModel.data[@"team_achievement"] doubleValue] afterPointNumber:4]  ;
            weakSelf.heardView.bOneLab.text = [WLTools noroundingStringWith:[netWorkModel.data[@"jicha_count"] doubleValue] afterPointNumber:4] ;
            weakSelf.heardView.bTwoLab.text =[WLTools noroundingStringWith:[netWorkModel.data[@"team_reward_count"] doubleValue] afterPointNumber:4] ;
            weakSelf.heardView.bThreeLab.text =[WLTools noroundingStringWith:[netWorkModel.data[@"fuli_count"] doubleValue] afterPointNumber:4] ;
            weakSelf.heardView.bFoutLab.text = [WLTools noroundingStringWith:[netWorkModel.data[@"big_team_count"] doubleValue] afterPointNumber:4];
            
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
